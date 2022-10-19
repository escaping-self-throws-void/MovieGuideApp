//
//  SignUpViewController.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/07/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpTableView: UITableView!
    
    var viewModel: SignUpViewModelProtocol!
    
    private lazy var exitButton: UIButton = {
        let bttn = UIButton()
        bttn.frame = CGRect(x: 17, y: 17, width: 19, height: 19)
        bttn.setImage(UIImage(named: C.Images.exit), for: .normal)
        return bttn
    }()
    
    private var dataSource: FormDataSource!
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
        signUpTableView.rowHeight = 65
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
        let signUpNib = UINib(nibName: SignUpTableViewCell.reuseIdentifier, bundle: nil)
        signUpTableView.register(signUpNib, forCellReuseIdentifier: SignUpTableViewCell.reuseIdentifier)
        
        let minorNib = UINib(nibName: SUMinorTableViewCell.reuseIdentifier, bundle: nil)
        signUpTableView.register(minorNib, forCellReuseIdentifier: SUMinorTableViewCell.reuseIdentifier)
        signUpTableView.register(MBCTextFormCell.self, forCellReuseIdentifier: MBCTextFormCell.reuseIdentifier)
        signUpTableView.register(MBCDoubleTextFormCell.self, forCellReuseIdentifier: MBCDoubleTextFormCell.reuseIdentifier)
        configureDataSource()
        createSnapshot(from: viewModel.form)
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

// MARK: - Diffable Data Source Setup

extension SignUpViewController {
    
    fileprivate typealias FormDataSource = UITableViewDiffableDataSource<Section, FormType>
    fileprivate typealias FormSnapshot = UITableViewDiffableDataSource<Section, FormType>

    fileprivate enum Section {
        case main
    }
    
    private func configureDataSource() {
        dataSource = FormSnapshot(tableView: signUpTableView) { [weak self] tableView, indexPath, formItem in
            self?.buildForm(tableView, indexPath: indexPath, formItem: formItem)
        }
    }
    
    private func createSnapshot(from data: [FormType]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,FormType>()
        snapshot.appendSections([.main])
        snapshot.reloadSections([.main])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - Build Form for TableView

extension SignUpViewController {
    private func buildForm(_ tableView: UITableView, indexPath: IndexPath, formItem: FormType) -> UITableViewCell {
                
        switch formItem {
            
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: MBCDoubleTextFormCell.reuseIdentifier, for: indexPath) as? MBCDoubleTextFormCell ?? MBCDoubleTextFormCell()
            
            cell.configure(left: .name, right: .lastName)
            
            cell.leftTextField.rx.text.compactMap { $0 }.bind(to: viewModel.userFirstName).disposed(by: disposeBag)
            cell.rightTextField.rx.text.compactMap { $0 }.bind(to: viewModel.userLastName).disposed(by: disposeBag)
            
            return cell
            
        case .email:
            let cell = tableView.dequeueReusableCell(withIdentifier: MBCTextFormCell.reuseIdentifier, for: indexPath) as? MBCTextFormCell ?? MBCTextFormCell()
            
            cell.configure(as: formItem)
            
            cell.textField.rx.text.compactMap { $0 }.bind(to: viewModel.userEmail).disposed(by: disposeBag)
            
            return cell
            
        case .loginEmail:
            let cell = tableView.dequeueReusableCell(withIdentifier: MBCTextFormCell.reuseIdentifier, for: indexPath) as? MBCTextFormCell ?? MBCTextFormCell()
            
            cell.configure(as: formItem)
            
            cell.textField.rx.text.compactMap { $0 }.bind(to: viewModel.loginEmail).disposed(by: disposeBag)
            
            return cell
            
        case .password:
            let cell = tableView.dequeueReusableCell(withIdentifier: MBCTextFormCell.reuseIdentifier, for: indexPath) as? MBCTextFormCell ?? MBCTextFormCell()
            
            cell.configure(as: formItem)
            
            cell.textField.rightView?.rx.tapGesture()
                .when(.recognized)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { _ in
                    if let bttn = cell.textField.rightView as? UIButton {
                        cell.textField.isSecureTextEntry.toggle()
                        bttn.setImage(cell.textField.isSecureTextEntry
                                      ? UIImage(named: C.Images.eyeClosed)
                                      : UIImage(named: C.Images.eyeOpened ),
                                      for: .normal)
                    }
                }).disposed(by: disposeBag)
            
            cell.textField.rx.text.compactMap { $0 }.bind(to: viewModel.userPassword).disposed(by: disposeBag)
            
            return cell
            
        case .confirm:
            let cell = tableView.dequeueReusableCell(withIdentifier: MBCTextFormCell.reuseIdentifier, for: indexPath) as? MBCTextFormCell ?? MBCTextFormCell()
            
            cell.configure(as: formItem)
            
            cell.textField.rightView?.rx.tapGesture()
                .when(.recognized)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { _ in
                    if let bttn = cell.textField.rightView as? UIButton {
                        cell.textField.isSecureTextEntry.toggle()
                        bttn.setImage(cell.textField.isSecureTextEntry
                                      ? UIImage(named: C.Images.eyeClosed)
                                      : UIImage(named: C.Images.eyeOpened ),
                                      for: .normal)
                    }
                }).disposed(by: disposeBag)
            
            cell.textField.rx.text.compactMap { $0 }.bind(to: viewModel.userConfirmPassword).disposed(by: disposeBag)
            
            return cell

        case .birthday:
            let cell = tableView.dequeueReusableCell(withIdentifier: MBCTextFormCell.reuseIdentifier, for: indexPath) as? MBCTextFormCell ?? MBCTextFormCell()
            
            cell.configure(as: formItem)
            
            cell.textField.rx.text.compactMap { $0 }.bind(to: viewModel.userBirthday).disposed(by: disposeBag)
            
            return cell
            
        case .gender:
            let cell = tableView.dequeueReusableCell(withIdentifier: MBCTextFormCell.reuseIdentifier, for: indexPath) as? MBCTextFormCell ?? MBCTextFormCell()
            
            cell.configure(as: formItem)
            
            cell.textField.rx.text.compactMap { $0 }.bind(to: viewModel.userGender).disposed(by: disposeBag)
            
            return cell
            
        case .country:
            let cell = tableView.dequeueReusableCell(withIdentifier: MBCTextFormCell.reuseIdentifier, for: indexPath) as? MBCTextFormCell ?? MBCTextFormCell()
            
            cell.configure(as: formItem)
            
            cell.textField.rx.tapGesture()
                .when(.recognized)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak cell, weak self] _ in
                    guard let cell = cell, let self = self else { return }
                    cell.cpv.showCountriesList(from: self)
                }).disposed(by: disposeBag)

            cell.textField.rx.text.compactMap { $0 }.bind(to: viewModel.userCountry).disposed(by: disposeBag)
            
            return cell
            
        case .loginPassword:
            let cell = tableView.dequeueReusableCell(withIdentifier: MBCTextFormCell.reuseIdentifier, for: indexPath) as? MBCTextFormCell ?? MBCTextFormCell()
            
            cell.configure(as: formItem)
            
            cell.textField.rx.text.compactMap { $0 }.bind(to: viewModel.loginPassword).disposed(by: disposeBag)
            
            return cell
            
        case .login:
            let cell = tableView.dequeueReusableCell(withIdentifier: SignUpTableViewCell.reuseIdentifier, for: indexPath) as? SignUpTableViewCell ?? SignUpTableViewCell()
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
            
        case .privacyAndTerms:
            let cell = tableView.dequeueReusableCell(withIdentifier: SUMinorTableViewCell.reuseIdentifier, for: indexPath) as? SUMinorTableViewCell ?? SUMinorTableViewCell()
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
            
        case .termsCheck:
            let cell = tableView.dequeueReusableCell(withIdentifier: SUMinorTableViewCell.reuseIdentifier, for: indexPath) as? SUMinorTableViewCell ?? SUMinorTableViewCell()
            
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
            
        case .signUp:
            let cell = tableView.dequeueReusableCell(withIdentifier: SignUpTableViewCell.reuseIdentifier, for: indexPath) as? SignUpTableViewCell ?? SignUpTableViewCell()
            
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
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
