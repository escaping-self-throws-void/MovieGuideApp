//
//  MovieDetailsViewController.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 20/07/2022.
//

import UIKit
import RxSwift

final class MovieDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var backgroundImageView: MBCImageView!
    @IBOutlet weak var collectionView: MovieDetailsCollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.collectionViewLayout = createLayout()
        }
    }
    
    // MARK: - Vars / Values
    var viewModel: MovieDetailsViewModel!
    
    private let disposeBag = DisposeBag()
    
    // Blur
    private lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getMovieDetails()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            guard let sections = self.viewModel.movieUIModel?.sections else { return nil }
            
            switch sections[sectionIndex].type {
            case .synopsis:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), padding: 0)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .estimated(114), items: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                // header
                let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(344))
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: MovieDetailsCollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [headerItem]
                
                section.supplementariesFollowContentInsets = false
                
                return section
            case .cast:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), padding: 0)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .absolute(70), height: .absolute(100), items: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.interGroupSpacing = 10
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 10)
                
                // header
                let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: MovieDetailsCollectionView.elementKindSectionHeader, alignment: .top)
                headerItem.contentInsets = .init(top: 0, leading: 15, bottom: -10, trailing: 0)
                section.boundarySupplementaryItems = [headerItem]
                section.supplementariesFollowContentInsets = false
                
                return section
            case .directors:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), padding: 0)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .estimated(115), height: .absolute(50), items: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.interGroupSpacing = 1
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 10)
                
                // header
                let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: MovieDetailsCollectionView.elementKindSectionHeader, alignment: .top)
                headerItem.contentInsets = .init(top: 0, leading: 15, bottom: -10, trailing: 0)
                section.boundarySupplementaryItems = [headerItem]
                section.supplementariesFollowContentInsets = false
                
                return section
            case .genres:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), padding: 0)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .estimated(80), height: .absolute(30), items: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.interGroupSpacing = 1
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 10)
                
                // header
                let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: MovieDetailsCollectionView.elementKindSectionHeader, alignment: .top)
                headerItem.contentInsets = .init(top: 0, leading: 15, bottom: -10, trailing: 0)
                section.boundarySupplementaryItems = [headerItem]
                section.supplementariesFollowContentInsets = false
                
                return section
            }
        }
    }
    
    // MARK: - Setup View
    private func setupView() {
        setupBindings()
        setupUI()
        setupGradientView()
        setupNavigationBar()
        setupBlur()
    }
    
    private func setupBindings() {
        viewModel.hasLoaded.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            self?.backgroundImageView.setImage(with: self?.viewModel.movieUIModel?.header.poster)
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }

    
    private func setupUI() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        
        let background = UIView(frame: view.bounds)
        background.backgroundColor = .black
        background.alpha = 0.6
        view.insertSubview(background, at: 1)
    }
    
    private func setupGradientView() {
        let backgroundView = UIView(frame: gradientView.bounds)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        
        let topColor = UIColor(named: C.Colors.darkBlueGrey) ?? .black
        let bottomColor = UIColor(named: C.Colors.darkGrey ) ?? .black
        gradientLayer.colors = [topColor.cgColor,
                                bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.25)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.shouldRasterize = true
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        
        gradientView.addSubview(backgroundView)
    }
    
    private func setupNavigationBar() {
        let backButtonImage = UIImage(named: C.Images.exitBarButton)
        let barImageView = UIImageView(image: backButtonImage)
        let backButton = UIBarButtonItem(customView: barImageView)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

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

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.movieUIModel?.sections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieUIModel?.sections[section].rows.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sections = viewModel.movieUIModel?.sections else { return UICollectionViewCell() }
        switch sections[indexPath.section].type {
        case .synopsis:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SynopsisCollectionViewCell.reuseIdentifier, for: indexPath) as? SynopsisCollectionViewCell else { return UICollectionViewCell() }
            if let rowData = viewModel.movieUIModel?.sections[indexPath.section].rows[indexPath.row] {
                cell.setup(with: rowData)
            }
            return cell
        case .cast:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.reuseIdentifier, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
            if let rowData = viewModel.movieUIModel?.sections[indexPath.section].rows[indexPath.row] {
                cell.setup(with: rowData)
            }
            return cell
        case .directors:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DirectorsCollectionViewCell.reuseIdentifier, for: indexPath) as? DirectorsCollectionViewCell else { return UICollectionViewCell() }
            if let rowData = viewModel.movieUIModel?.sections[indexPath.section].rows[indexPath.row] {
                cell.setup(with: rowData)
            }
            return cell
        case .genres:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCollectionViewCell.reuseIdentifier, for: indexPath) as? GenresCollectionViewCell else { return UICollectionViewCell() }
            if let rowData = viewModel.movieUIModel?.sections[indexPath.section].rows[indexPath.row] {
                cell.setup(with: rowData)
            }
            return cell
        }
                
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sections = viewModel.movieUIModel?.sections else { return UICollectionReusableView() }
        switch sections[indexPath.section].type {
        case .synopsis:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieDetailsHeaderReusableView.reuseIdentifier, for: indexPath) as? MovieDetailsHeaderReusableView else {
                return UICollectionReusableView()
            }
            
            if let detail = viewModel.movieUIModel?.header {
                header.setup(with: detail)
                viewModel.movieToShare = MovieToShare(image: header.posterImageView.image, title: header.movieTitleLabel.text, time: detail.date)
            }
            header.reminderButtom.addTarget(self, action: #selector(reminderTapped), for: .touchUpInside)
            
            return header
        default:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionTitleReusableHeaderView.reuseIdentifier, for: indexPath) as? SectionTitleReusableHeaderView else {
                return UICollectionReusableView()
            }
            
            if let sectionTitle = sections[indexPath.section].title {
                header.setup(title: sectionTitle)
            }
            
            return header
        }
    }
}

// MARK: - Private methods

extension MovieDetailsViewController {
    
    private func getMovieDetails() {
        viewModel.getMovieDetail()
    }
    
    @objc private func reminderTapped() {
        visualEffectView.alpha = 1
        navigationItem.hidesBackButton = true
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            let coordinator = ReminderMenuCoordinator(navigationController: self.navigationController)
            coordinator.delegate = self
            coordinator.start()
        }
    }
    
    private func showAlert(_ success: Bool) {
        let alert = UIAlertController(
            title: success ? C.LocKeys.alertSuccessTitle.localized() : C.LocKeys.alertFailureTitle.localized(),
            message: success ? C.LocKeys.alertSuccessMessage.localized() : C.LocKeys.alertFailureMessage.localized(),
            preferredStyle: .alert)
        let action = UIAlertAction(title: C.LocKeys.alertActionTitle.localized(), style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}


// MARK: - Reminder Menu Delegate methods

extension MovieDetailsViewController: ReminderMenuDelegate {
    
    func handleDismiss() {
        visualEffectView.alpha = 0
        navigationItem.hidesBackButton = false
    }

    func shareMovie() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            let imageToShare = self?.viewModel.movieToShare?.image
            let titleToShare = self?.viewModel.movieToShare?.title
            let timeToShare = self?.viewModel.movieToShare?.time.getDate.timeText
            let dataToShare = [imageToShare, titleToShare, timeToShare] as [Any?]
            let activityViewController = UIActivityViewController(activityItems: dataToShare as [Any], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self?.view
            self?.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func addReminder() {
        let duration = viewModel.movieUIModel?.header.duration
        let filteredDuration = duration?.filter { $0.isHexDigit }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let date = self?.viewModel.movieToShare?.time.getDate,
                  let text = self?.viewModel.movieToShare?.title,
                  let filteredDuration = filteredDuration,
                  let duration = Double(filteredDuration) else { return }
            let success = CalendarService.shared.checkPermission(startDate: date, duration: duration, eventName: text)
            self?.showAlert(success)
        }
    }
}
