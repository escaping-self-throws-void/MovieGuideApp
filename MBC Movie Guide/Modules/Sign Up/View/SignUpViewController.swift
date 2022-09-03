//
//  SignUpViewController.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpTableView: UITableView!
    
    var viewModel: SignUpViewModelProtocol!
    
    private lazy var exitButton: UIButton = {
        let bttn = UIButton()
        bttn.frame = CGRect(x: 17, y: 17, width: 19, height: 19)
        bttn.setImage(UIImage(named: C.Images.exit), for: .normal)
        return bttn
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        dismissKeyboardOnTap()
        bind()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        signUpTableView.rowHeight = 60
        signUpTableView.layer.cornerRadius = 17
        signUpTableView.layer.borderWidth = 1
        signUpTableView.layer.borderColor = (UIColor(named: C.Colors.dark) ?? .black).cgColor
        
        let backgroundView = UIView(frame: signUpTableView.bounds)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = signUpTableView.bounds
        
        let topColor = UIColor(named: C.Colors.darkBlueGrey) ?? .black
        let bottomColor = UIColor(named: C.Colors.darkGrey ) ?? .black
        gradientLayer.colors = [topColor.cgColor,
                                bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.shouldRasterize = true
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        signUpTableView.backgroundView = backgroundView
        
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: signUpTableView.bounds.width,
                                              height: 56))
        headerView.addSubview(exitButton)
        
        let footerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: signUpTableView.bounds.width,
                                              height: 75))
        
        signUpTableView.tableFooterView = footerView
        signUpTableView.tableHeaderView = headerView
        signUpTableView.contentInsetAdjustmentBehavior = .never
    }
    
    private func setupTableView() {
        signUpTableView.delegate = self
        signUpTableView.dataSource = self
        let signUpNib = UINib(nibName: SignUpTableViewCell.reuseIdentifier, bundle: nil)
        signUpTableView.register(signUpNib, forCellReuseIdentifier: SignUpTableViewCell.reuseIdentifier)
        
        let minorNib = UINib(nibName: SUMinorTableViewCell.reuseIdentifier, bundle: nil)
        signUpTableView.register(minorNib, forCellReuseIdentifier: SUMinorTableViewCell.reuseIdentifier)
    }
    
    private func bind() {
        exitButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel?.exitButtonTapped()
            })
            .disposed(by: disposeBag)
    }
    
    private func dismissKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - TableView Delegate and DataSource methods

extension SignUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.isLogin ? 4 : 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.isLogin
        ? showLogInCells(tableView, indexPath: indexPath)
        : showSignUpCells(tableView, indexPath: indexPath)
    }
    
}

// MARK: - Methods to populate TableView

extension SignUpViewController {
    
    private func showSignUpCells(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SignUpTableViewCell.reuseIdentifier, for: indexPath) as? SignUpTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SUMinorTableViewCell.reuseIdentifier, for: indexPath) as? SUMinorTableViewCell else {
                return UITableViewCell()
            }
            cell.tag = indexPath.row
            
            if cell.tag == indexPath.row {
                cell.cNameTextField.rx.text.compactMap { $0 }
                    .observe(on: MainScheduler.instance).subscribe(onNext: { [weak cell] text in
                        guard let cell = cell else { return }
                        if text != "" {
                            text.isValid(.name)
                            ? cell.showNameError(false) : cell.showNameError(true)
                        }
                    }).disposed(by: disposeBag)
                
                cell.cNameTextField.rx.text.compactMap { $0 }.bind(to: viewModel.userFirstName).disposed(by: disposeBag)
                
                cell.cLastNameTextField.rx.text.compactMap { $0 }
                    .observe(on: MainScheduler.instance).subscribe(onNext: { [weak cell] text in
                        guard let cell = cell else { return }
                        if text != "" {
                            text.isValid(.name)
                            ? cell.showLastNameError(false) : cell.showLastNameError(true)
                        }
                    }).disposed(by: disposeBag)
                
                cell.cLastNameTextField.rx.text.compactMap { $0 }.bind(to: viewModel.userLastName).disposed(by: disposeBag)
            }
            return cell
        case 1:
            cell.style = .email
            cell.signUpCellTextField.rx.text.compactMap { $0 }
                .observe(on: MainScheduler.instance).subscribe(onNext: { [weak cell] text in
                    guard let cell = cell else { return }
                    if text != "" {
                        text.isValid(.email)
                        ? cell.showError(false) : cell.showError(true)
                    }
                }).disposed(by: disposeBag)
            
            cell.signUpCellTextField.rx.text.compactMap { $0 }.bind(to: viewModel.userEmail).disposed(by: disposeBag)
            
            return cell
        case 2:
            cell.style = .password
            cell.signUpCellButton.rx.tap
                .observe(on: MainScheduler.instance).subscribe(onNext: { [weak cell] in
                    guard let cell = cell else { return }
                    cell.isSecure.toggle()
                    cell.signUpCellButton.setImage(cell.isSecure
                                                    ? UIImage(named: C.Images.eyeClosed)
                                                    : UIImage(named: C.Images.eyeOpened ),
                                                    for: .normal)
                    cell.signUpCellTextField.isSecureTextEntry = cell.isSecure
                }).disposed(by: disposeBag)
            
            cell.signUpCellTextField.rx.text.compactMap { $0 }
                .observe(on: MainScheduler.instance).subscribe(onNext: { [weak cell] text in
                    guard let cell = cell else { return }
                    if text != "" {
                        text.isValid(.password)
                        ? cell.showError(false) : cell.showError(true)
                    }
                }).disposed(by: disposeBag)
            
            cell.signUpCellTextField.rx.text.compactMap { $0 }.bind(to: viewModel.userPassword).disposed(by: disposeBag)
            
            return cell
        case 3:
            cell.style = .confirm
            cell.signUpCellButton.rx.tap
                .observe(on: MainScheduler.instance).subscribe(onNext: { [weak cell] in
                    guard let cell = cell else { return }
                    cell.isSecure.toggle()
                    cell.signUpCellButton.setImage(cell.isSecure
                                                    ? UIImage(named: C.Images.eyeClosed)
                                                    : UIImage(named: C.Images.eyeOpened ),
                                                    for: .normal)
                    cell.signUpCellTextField.isSecureTextEntry = cell.isSecure
                }).disposed(by: disposeBag)
            
            cell.signUpCellTextField.rx.text.compactMap { $0 }
                .observe(on: MainScheduler.instance).subscribe(onNext: { [weak cell] text in
                    guard let cell = cell else { return }
                    if text != "" {
                        text.isValid(.password)
                        ? cell.showError(false) : cell.showError(true)
                    }
                }).disposed(by: disposeBag)
            
            cell.signUpCellTextField.rx.text.compactMap { $0 }.bind(to: viewModel.userConfirmPassword).disposed(by: disposeBag)
            
            return cell
        case 4:
            cell.style = .birthday
            
            cell.signUpCellTextField.rx.text.compactMap { $0 }.bind(to: viewModel.userBirthday).disposed(by: disposeBag)
            
            return cell
        case 5:
            cell.style = .gender
            
            cell.signUpCellTextField.rx.text.compactMap { $0 }.bind(to: viewModel.userGender).disposed(by: disposeBag)
            
            return cell
        case 6:
            cell.style = .country
            
            cell.signUpCellButton.rx.tap.observe(on: MainScheduler.instance).subscribe(onNext: { [weak cell, weak self] in
                guard let cell = cell, let self = self else { return }
                cell.cpv.showCountriesList(from: self)
            }).disposed(by: disposeBag)
            
            cell.signUpCellTextField.rx.text.compactMap { $0 }.bind(to: viewModel.userCountry).disposed(by: disposeBag)
            
            return cell
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SUMinorTableViewCell.reuseIdentifier, for: indexPath) as? SUMinorTableViewCell else {
                return UITableViewCell()
            }
            
            cell.style = .termsCheck
            
            cell.termsCheck.rx.tap.observe(on: MainScheduler.instance).subscribe(onNext: { [weak cell, weak self] in
                guard let cell = cell, let self = self else { return }
                self.viewModel.termsAccepted.toggle()
                self.viewModel.userTermsAccepted
                    .map { $0 ? UIImage(named: C.Images.check) : UIImage(named: C.Images.circle) }
                    .bind(to: cell.termsCheck.rx.image())
                    .disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
            
            cell.adsCheck.rx.tap.observe(on: MainScheduler.instance).subscribe(onNext: { [weak cell, weak self] in
                guard let cell = cell, let self = self else { return }
                self.viewModel.adsAccepted.toggle()
                self.viewModel.userAdsAccepted
                    .map { $0 ? UIImage(named: C.Images.check) : UIImage(named: C.Images.circle) }
                    .bind(to: cell.adsCheck.rx.image())
                    .disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
            
            cell.acceptTermsButton.rx.tap.observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.acceptTermsTapped()
                }).disposed(by: disposeBag)
            
            return cell
        default:
            cell.tag = indexPath.row
            if cell.tag == indexPath.row {
                cell.style = .signUp
                
                viewModel.isValid()
                    .bind(to: cell.bigSignUpButton.rx.isEnabled)
                    .disposed(by: disposeBag)
                viewModel.isValid()
                    .map { $0 ? 1 : 0.5 }
                    .bind(to: cell.bigSignUpButton.rx.alpha)
                    .disposed(by: disposeBag)
                cell.bigSignUpButton.rx.tap.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] in
                    // TODO: implement sign up button pressed logic
                    UserSession.shared.currentUser = self?.viewModel.getUser()
                    self?.viewModel.bigSignUpButtonTapped()
                }).disposed(by: disposeBag)
            }
            return cell
        }
    }
    
    private func showLogInCells(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SignUpTableViewCell.reuseIdentifier, for: indexPath) as? SignUpTableViewCell else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.style = .email
            cell.signUpCellTextField.rx.text.compactMap { $0 }.bind(to: viewModel.loginEmail).disposed(by: disposeBag)
            return cell
        case 1:
            cell.style = .logInPassword
            cell.signUpCellTextField.rx.text.compactMap { $0 }.bind(to: viewModel.loginPassword).disposed(by: disposeBag)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SUMinorTableViewCell.reuseIdentifier, for: indexPath) as? SUMinorTableViewCell else { return UITableViewCell() }
            cell.style = .privacyAndTerms
            
            cell.termsAndConditionsButton.rx.tap.observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.acceptTermsTapped()
                }).disposed(by: disposeBag)
            
            cell.privacyPolicyButton.rx.tap.observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.privacyPolicyTapped()
                }).disposed(by: disposeBag)
            return cell
        default:
            cell.style = .logIn
            
            viewModel.isLoginValid()
                .bind(to: cell.bigSignUpButton.rx.isEnabled)
                .disposed(by: disposeBag)
            viewModel.isLoginValid()
                .map { $0 ? 1 : 0.5 }
                .bind(to: cell.bigSignUpButton.rx.alpha)
                .disposed(by: disposeBag)
            cell.bigSignUpButton.rx.tap.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] in
                self?.viewModel.loginButtonTapped()
            }).disposed(by: disposeBag)
            return cell
        }
    }
}
