//
//  ReminderMenuViewController.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 22/07/2022.
//

import UIKit

protocol ReminderMenuDelegate: AnyObject {
    func handleDismiss()
    func shareMovie()
    func addReminder()
}

final class ReminderMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: SideMenuTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SideMenuTableViewCell.reuseIdentifier)
            tableView.delegate = self
            tableView.dataSource = self
            setupTableView()
        }
    }
    
    weak var delegate: ReminderMenuDelegate?
    private let viewModel =  ReminderMenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    @IBAction func tapOutsideScreen() {
        delegate?.handleDismiss()
        dismiss(animated: true)
    }
    
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 5, left: -10, bottom: -10, right: 0)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5)
        tableView.separatorColor = UIColor(named: C.Colors.greyishBrownThree)
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 23
        tableView.layer.maskedCorners = LanguageService.shared.isEn
            ? [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            : [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor(named: C.Colors.dark)?.cgColor
        tableView.backgroundColor = UIColor(named: C.Colors.nightBlue)
        tableView.rowHeight = 50
    }
    
}

// MARK: - UITableViewDataSoruce
extension ReminderMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reminderMenuModel?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.reuseIdentifier, for: indexPath) as? SideMenuTableViewCell else { return UITableViewCell() }
        
        if let row = viewModel.reminderMenuModel?.rows[indexPath.row] {
            cell.sideMenuImageView.image = row.rowIcon
            cell.sideMenuLabel.font = row.font
            cell.sideMenuLabel.text = row.title
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ReminderMenuViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let row = viewModel.reminderMenuModel?.rows[indexPath.row] {
            switch row.type {
            case .watch:
                print(row.type)
            case .reminder:
                delegate?.handleDismiss()
                delegate?.addReminder()
                dismiss(animated: false)
            case .share:
                delegate?.handleDismiss()
                delegate?.shareMovie()
                dismiss(animated: false)
            }
        }
    }
}
