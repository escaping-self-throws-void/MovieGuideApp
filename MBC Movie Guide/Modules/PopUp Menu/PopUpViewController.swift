//
//  PopUpViewController.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 16/07/2022.
//

import UIKit

protocol PopUpDelegate: AnyObject {
    func handleDismiss()
    func getSelectedDate(_ date: Date, and row: Int)
}

final class PopUpViewController: UIViewController {
    
    @IBOutlet weak var popUpTableView: UITableView! {
        didSet {
            setupTableView()
        }
    }
    
    weak var delegate: PopUpDelegate?
    
    var selectedRow: Int?
    var dates: [Date] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func tapOutsideScreen() {
        delegate?.handleDismiss()
        dismiss(animated: true)
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: PopUpTableViewCell.reuseIdentifier, bundle: nil)
        popUpTableView.register(nib, forCellReuseIdentifier: PopUpTableViewCell.reuseIdentifier)
        popUpTableView.delegate = self
        popUpTableView.dataSource = self
    }
    
    private func setupUI() {
        popUpTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        popUpTableView.separatorInset = UIEdgeInsets(top: 0, left: 7.5, bottom: 0, right: 9.5)
        popUpTableView.separatorColor = UIColor(named: C.Colors.greyishBrownThree)
        popUpTableView.showsVerticalScrollIndicator = false
        popUpTableView.layer.cornerRadius = 23
        popUpTableView.layer.maskedCorners = LanguageService.shared.isEn
            ? [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            : [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        popUpTableView.layer.borderWidth = 1
        popUpTableView.layer.borderColor = UIColor(named: C.Colors.dark)?.cgColor
        popUpTableView.backgroundColor = UIColor(named: C.Colors.nightBlue)
        popUpTableView.rowHeight = 56
        let indexPath = IndexPath(row: selectedRow ?? 0, section: 0)
        popUpTableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
    }
    
    private func selectDate(_ date: Date, row: Int) {
        // Small throttle for better UX
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.delegate?.getSelectedDate(date, and: row)
            self?.delegate?.handleDismiss()
            self?.dismiss(animated: true)
        }
    }
}

// MARK: - TableView Delegate and DataSource methods

extension PopUpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopUpTableViewCell.reuseIdentifier, for: indexPath) as? PopUpTableViewCell else {
            return UITableViewCell()
        }
        
        let date = dates[indexPath.row]
        cell.setup(with: date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDate = dates[indexPath.row]
        selectDate(selectedDate, row: indexPath.row)
    }
}
