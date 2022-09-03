//
//  ViewController.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 06/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class LandingViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var alreadyLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    
    var viewModel: LandingViewModelProtocol!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setText()
    }

}

// MARK: - Private methods

extension LandingViewController {
    private func bind() {
        skipButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel?.skipButtonTapped()
        }).disposed(by: disposeBag)
        
        signUpButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel?.signUpButtonTapped()
        }).disposed(by: disposeBag)
        
        logInButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel?.logInButtonTapped()
        }).disposed(by: disposeBag)
    }
    
    @objc func setText() {
        skipButton.setTitle(C.LocKeys.skipBttn.localized(), for: .normal)
        signUpButton.setTitle(C.LocKeys.signBttn.localized(), for: .normal)
        logInButton.setTitle(C.LocKeys.logInBttn.localized(), for: .normal)
        alreadyLabel.text = C.LocKeys.alreadyLbl.localized()
        orLabel.text = C.LocKeys.orLbl.localized()
    }
}

