//
//  TimelineViewController.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 13/07/2022.
//

import UIKit
import RxSwift

final class TimelineViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: MBCCollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    var viewModel: TimelineViewModelProtocol!
    
    private lazy var navBarDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: C.Fonts.almaraiRegular, size: 16)
        lbl.textAlignment = .right
        return lbl
    }()
    
    private lazy var navBarTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = C.LocKeys.timelineBarTitleLbl.localized()
        lbl.font = UIFont(name: C.Fonts.almaraiExtraBold, size: 23)
        lbl.textAlignment = .left
        return lbl
    }()
    
    // Blur
    private lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBlur()
        setupUI()
        bind()
        viewModel.getMovieData(from: Date())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupUI() {
        let bgImage = UIImage(named: C.Images.timelineBackground)
        backgroundImageView.image = bgImage
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .clear
        
        let burgerImage = UIImage(named: C.Images.burgerMenu)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: burgerImage, style: .plain, target: self, action: #selector(sideMenuButtonTapped))
        
        let calendarImage = UIImage(named: C.Images.calendarBarButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: calendarImage, style: .plain, target: self, action: #selector(calendarButtonTapped))
        
        let containerView = UIView()
        containerView.addSubview(navBarDateLabel)
        containerView.addSubview(navBarTitleLabel)

        let screenWidth = UIScreen.main.bounds.width
        containerView.widthAnchor.constraint(equalToConstant: screenWidth * 0.73).isActive = true

        containerView.translatesAutoresizingMaskIntoConstraints = false
        navBarDateLabel.translatesAutoresizingMaskIntoConstraints = false
        navBarTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        navBarTitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        navBarDateLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        navBarTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        navBarDateLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        navigationItem.titleView = containerView
    }
    
    private func setupBlur() {
        view.addSubview(visualEffectView)
        NSLayoutConstraint.activate([
            visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor),
            visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor),
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        visualEffectView.alpha = 0
    }
    
}

// MARK: - CollectionView Delegate and DataSource methods

extension TimelineViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimelineMovieCell.reuseIdentifier, for: indexPath) as? TimelineMovieCell else {
            return UICollectionViewCell()
        }
        let movie = viewModel.getModel(for: indexPath)
        cell.setup(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let movie = viewModel.getModel(for: indexPath)
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier, for: indexPath) as? SectionHeaderReusableView else {
                return UICollectionReusableView()
            }
            
            header.setup(with: movie)
            return header
            
        case BackgroundSupplementaryView.kind:
            guard let backgroundView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: BackgroundSupplementaryView.reuseIdentifier,
                for: indexPath) as? BackgroundSupplementaryView else {
                return UICollectionReusableView()
            }
            
            backgroundView.setup(with: movie)
            return backgroundView
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = viewModel.getModel(for: indexPath)
        let coordinator = MovieDetailsCoordinator(navigationController: navigationController, id: movie.id)
        
        coordinator.start()
    }
    
}

// MARK: - Private methods

extension TimelineViewController {
    private func bind() {
        viewModel.changed.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] changed in
                if changed {
                    self?.updateCollectionView()
                }
            }).disposed(by: disposeBag)
        
        viewModel.selectedDate.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] date in
                self?.navBarDateLabel.text = date.barLabelText
            }).disposed(by: disposeBag)
    }
    
    private func updateCollectionView() {
        collectionView.reloadData()
        viewModel.indexPathsForAvailableNow.forEach { indexPath in
            collectionView.scrollToItem(at: indexPath,
                                        at: .centeredHorizontally,
                                        animated: true)
        }
    }
    
    private func openCalendarMenu() {
        visualEffectView.alpha = 1
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            
            let vc = PopUpViewController()
            vc.delegate = self
            vc.dates = self.viewModel.createDays(8, from: Date())
            vc.selectedRow = self.viewModel.selectedRow
            
            self.present(vc, animated: true)
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    private func openSideMenu() {
        visualEffectView.alpha = 1
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.viewModel.goToSideMenu(self)
        }
    }
    
    @objc private func sideMenuButtonTapped() {
        openSideMenu()
    }
    
    @objc private func calendarButtonTapped() {
        openCalendarMenu()
    }

}

// MARK: - Delegate methods

extension TimelineViewController: PopUpDelegate, SideMenuDelegate {
    func handleDismiss() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        visualEffectView.alpha = 0
    }
    
    func getSelectedDate(_ date: Date, and row: Int) {
        viewModel.selectedRow = row
        viewModel.selectedDate.onNext(date)
        viewModel.getMovieData(from: date)
    }
    
    func reloadTimeline() {
        collectionView.reloadData()
    }
}
