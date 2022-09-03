//
//  SettingsViewController.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 23/07/2022.
//

import UIKit

final class SettingsViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: SideMenuTableViewCell.reuseIdentifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: SideMenuTableViewCell.reuseIdentifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    // MARK: - Vars / Values
    private lazy var navBarTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = C.LocKeys.settingsTitle.localized()
        lbl.font = UIFont(name: C.Fonts.almaraiExtraBold, size: 23)
        lbl.textAlignment = .left
        return lbl
    }()
    
    weak var delegate: SideMenuDelegate?
    private var viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupView() {
        setupUI()
        setupTableView()
    }
     
    private func setupUI() {
        let backgroundView = UIView(frame: view.bounds)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        let topColor = UIColor(named: C.Colors.navy) ?? .blue
        let bottomColor = UIColor(named: C.Colors.darkishBlue ) ?? .black
        gradientLayer.colors = [topColor.cgColor,
                                bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.shouldRasterize = true
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        
        view.insertSubview(backgroundView, at: 0)
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
        
        let burgerImage = UIImage(named: C.Images.burgerMenu)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: burgerImage, style: .plain, target: self, action: #selector(burgerButtonTapped))
        
        let containerView = UIView()
        containerView.addSubview(navBarTitleLabel)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        navBarTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        navBarTitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: -10).isActive = true
        navBarTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 1).isActive = true
        
        navigationItem.titleView = containerView
    }
    
    private func setupTableView() {
        tableView.separatorColor = UIColor(named: C.Colors.dark)
        tableView.backgroundColor = UIColor(named: C.Colors.blackZero)
        
        tableView.separatorInset = .init(top: 0, left: -10, bottom: 3, right: 0)
        tableView.rowHeight = 60
    }

}

// MARK: - UITableViewDataSoruce
extension SettingsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingsModel?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.reuseIdentifier, for: indexPath) as? SideMenuTableViewCell else {
            return SideMenuTableViewCell()
        }
        cell.backgroundColor = UIColor(named: C.Colors.darkTwo)

        if let row = viewModel.settingsModel?.rows[indexPath.row] {
            cell.sideMenuLabel.text = row.title
            cell.sideMenuImageView.image = row.iconImage
            
            switch row.type {
            case .language:
                cell.accessoryView = createSegControl()
            case .privacy:
                cell.accessoryView = createDisclosure()
            case .timeFormat:
                let switcher = createTimeSwitcher()
                cell.accessoryView = switcher
            case .notification:
                let switcher = createNotificationSwitcher()
                cell.accessoryView = switcher
            }
        }
        
        return cell
    }
}

// MARK: - Private Methods

extension SettingsViewController {
    
    @objc private func burgerButtonTapped() {
        let coordinator = SettingsCoordinator(navigationController: navigationController)
        coordinator.stop()
    }
    
    private func createSegControl() -> MBCSegmentedControl {
        let items = ["ع", "EN"]
        let segControl = MBCSegmentedControl(items: items)
        
        segControl.frame = CGRect(x: 0, y: 0, width: 80, height: 27)
        segControl.selectedSegmentIndex = LanguageService.shared.isEn ? 1 : 0
        segControl.cornerRadius = 13
        segControl.layer.borderWidth = 1
        segControl.layer.borderColor = UIColor(named: C.Colors.greyishBrownFour)?.cgColor
        segControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
                     
        segControl.setTitleTextAttributes([.font: UIFont(name: C.Fonts.almaraiBold, size: 14) as Any,
                                           .baselineOffset: 0.3,
                                           .foregroundColor : UIColor(named: C.Colors.brownishGreyTwo) as Any],
                                          for: .normal)
        segControl.setTitleTextAttributes([.font: UIFont(name: C.Fonts.almaraiBold, size: 14) as Any,
                                           .baselineOffset: 0.3,
                                           .foregroundColor : UIColor.white],
                                          for: .selected)
        
        segControl.selectedSegmentTintColor = UIColor(named: C.Colors.waterBlue)
        segControl.backgroundColor = UIColor(named: C.Colors.darkTwo)
        segControl.ensureiOS12Style()
        return segControl
    }
    
    private func createNotificationSwitcher() -> UISwitch {
        let switchView = UISwitch()
        switchView.sizeToFit()
        switchView.setOn(false, animated: true)
        switchView.addTarget(self, action: #selector(notificationSwitchChanged), for: .valueChanged)
        return switchView
    }
    
    private func createTimeSwitcher() -> UISwitch {
        let switchView = UISwitch()
        switchView.sizeToFit()
        let is24 = CalendarService.shared.is24
        switchView.setOn(is24 ? true : false, animated: true)
        switchView.addTarget(self, action: #selector(timeSwitchChanged), for: .valueChanged)
        return switchView
    }
    
    private func createDisclosure() -> UIButton {
        let privacyButton = UIButton()
        privacyButton.sizeToFit()
        privacyButton.setImage(UIImage(named: C.Images.rightDisclosure), for: .normal)
        privacyButton.addTarget(self, action: #selector(privacyButtonTapped), for: .touchUpInside)
        return privacyButton
    }
    
    @objc private func segmentAction(_ sender: UISegmentedControl) {
        LanguageService.shared.isEn.toggle()
        LanguageService.shared.changeLanguage()
    }
    
    @objc private func timeSwitchChanged(){
        CalendarService.shared.is24.toggle()
        delegate?.reloadTimeline()
    }
    
    @objc private func notificationSwitchChanged(){
        print("switched")
    }
    
    @objc private func privacyButtonTapped() {
        let webVC = WebViewController(C.Links.privacy)
        navigationController?.pushViewController(webVC, animated: true)
    }
}



