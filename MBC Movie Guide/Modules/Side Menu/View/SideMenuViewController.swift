//
//  SideMenuViewController.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 19/07/2022.
//

import UIKit

protocol SideMenuDelegate: AnyObject {
    func handleDismiss()
    func reloadTimeline()
}

final class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var sideMenuTableView: UITableView! {
        didSet {
            setupTableView()
        }
    }
    
    weak var delegate: SideMenuDelegate?
    var viewModel: SideMenuViewModel!
    
    private let lan = LanguageService.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
     
    @IBAction func tapOutsideScreen() {
        delegate?.handleDismiss()
        viewModel.backToTimeline()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: SideMenuTableViewCell.reuseIdentifier, bundle: nil)
        sideMenuTableView.register(nib, forCellReuseIdentifier: SideMenuTableViewCell.reuseIdentifier)
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
     
        let image = UIImage(named: C.Images.sideMenuBg)
        sideMenuTableView.backgroundView = UIImageView(image: image)
        sideMenuTableView.layer.cornerRadius = 23
        sideMenuTableView.layer.maskedCorners = lan.isEn
            ? [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            : [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        sideMenuTableView.separatorStyle = .none
        sideMenuTableView.showsVerticalScrollIndicator = false
        sideMenuTableView.rowHeight = 50
        
        // Fix Floating Header Section
        let dummyViewHeight = CGFloat(40)
        sideMenuTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: sideMenuTableView.bounds.size.width, height: dummyViewHeight))
        sideMenuTableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - UITableViewDataSoruce

extension SideMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sideMenuModel?.section.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sideMenuModel?.section[section].rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.reuseIdentifier, for: indexPath) as? SideMenuTableViewCell else {
            return UITableViewCell()
        }
        
        if let row = viewModel.sideMenuModel?.section[indexPath.section].rows[indexPath.row] {
            cell.sideMenuImageView.image = row.iconImage
            cell.sideMenuLabel.font = row.labelTextFont
            
            switch row.type {
            case .userInfo:
                cell.sideMenuLabel.text = UserSession.shared.isGuest ? row.title : UserSession.shared.user?.fullName
            case .settings:
                cell.sideMenuLabel.text = row.title
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != 0 else { return nil }
        let header = UIView()
        header.backgroundColor = .clear
        header.frame = CGRect(x: 0, y: 0, width: sideMenuTableView.frame.width, height: 1)
        let line = UIView()
        let xPosition = lan.isEn ? 20 : sideMenuTableView.frame.width - 194
        line.frame = CGRect(x: xPosition, y: 0, width: 174, height: 0.5)
        line.backgroundColor = UIColor(named: C.Colors.warmGrey)
        
        header.addSubview(line)

        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }

}

// MARK: - UITableViewDelegate

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let row = viewModel.sideMenuModel?.section[indexPath.section].rows[indexPath.row] {
            switch row.rowType {
            case .account:
                print(row.rowType)
            case .timeline:
                tapOutsideScreen()
            case .genres:
                print(row.rowType)
            case .watchlist:
                print(row.rowType)
            case .quiz:
                print(row.rowType)
            case .settings:
                openSettings()
            case .logout:
                logOut()
            }
        }
    }
}

// MARK: - Private methods

extension SideMenuViewController {
    private func logOut() {
        viewModel.goToLanding()
    }
    
    private func openSettings() {
        viewModel.goToSettings()
        delegate?.handleDismiss()
//        viewModel.backToTimeline()
    }
}
