//
//  SignUpViewModel.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/07/2022.
//

import Foundation
import RxSwift

protocol SignUpViewModelProtocol: AnyObject {
    var isLogin: Bool { get }
    var termsAccepted: Bool { get set }
    var adsAccepted: Bool { get set }
    
    var userFirstName: BehaviorSubject<String> { get set }
    var userLastName: BehaviorSubject<String> { get set }
    var userEmail: BehaviorSubject<String> { get set }
    var userPassword: BehaviorSubject<String> { get set }
    var userConfirmPassword: BehaviorSubject<String> { get set }
    var userBirthday: BehaviorSubject<String> { get set }
    var userGender: BehaviorSubject<String> { get set }
    var userCountry: BehaviorSubject<String> { get set }
    var userTermsAccepted: BehaviorSubject<Bool> { get set }
    var userAdsAccepted: BehaviorSubject<Bool> { get set }
    
    var loginEmail: BehaviorSubject<String> { get set }
    var loginPassword: BehaviorSubject<String> { get set }
    
    func isValid() -> Observable<Bool>
    func isLoginValid() -> Observable<Bool>
    func getUser() -> Observable<User>
    
    func exitButtonTapped()
    func acceptTermsTapped()
    func privacyPolicyTapped()
    func bigSignUpButtonTapped()
    func loginButtonTapped()
}

final class SignUpViewModel: SignUpViewModelProtocol {
    var isLogin = false
    
    var termsAccepted = false {
        didSet {
            userTermsAccepted.onNext(termsAccepted)
        }
    }
    var adsAccepted = false {
        didSet {
            userAdsAccepted.onNext(adsAccepted)
        }
    }
    
    weak var coordinator: SignUpCoordinator?
    
    var userFirstName = BehaviorSubject<String>(value: "")
    var userLastName = BehaviorSubject<String>(value: "")
    var userEmail = BehaviorSubject<String>(value: "")
    var userPassword = BehaviorSubject<String>(value: "")
    var userConfirmPassword = BehaviorSubject<String>(value: "")
    var userBirthday = BehaviorSubject<String>(value: "")
    var userGender = BehaviorSubject<String>(value: "")
    var userCountry = BehaviorSubject<String>(value: "")
    
    var userTermsAccepted = BehaviorSubject<Bool>(value: false)
    var userAdsAccepted = BehaviorSubject<Bool>(value: false)
    
    var loginEmail = BehaviorSubject<String>(value: "")
    var loginPassword = BehaviorSubject<String>(value: "")
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(userFirstName, userLastName, userEmail, userPassword, userConfirmPassword, userTermsAccepted)
            .map { firstName, lastName, email, password, confirm, terms in
                (firstName.validate(by: .name) &&
                 lastName.validate(by: .name) &&
                 email.validate(by: .email) &&
                 password.validate(by: .password) && terms) && (confirm == password)
            }
            .startWith(false)
    }
    
    func isLoginValid() -> Observable<Bool> {
        return Observable.combineLatest(loginEmail, loginPassword)
            .map { email, password in
                email == UserSession.shared.user?.email &&
                password == UserSession.shared.user?.password
            }
            .startWith(false)
    }
        
        
    func getUser() -> Observable<User> {
        Observable.combineLatest(userFirstName, userLastName, userEmail, userPassword, userBirthday, userGender, userCountry, userAdsAccepted)
            .map { name, lastName, email, password, birthday, gender, country, ads in
                User(firstName: name, lastName: lastName, email: email, password: password, birthday: birthday, gender: gender, country: country, adsAccepted: ads)
            }
    }
    
    
    func exitButtonTapped() {
        coordinator?.finish(animated: true)
    }
    
    func acceptTermsTapped() {
        coordinator?.startWebView(with: C.Links.terms)
    }
    
    func privacyPolicyTapped() {
        coordinator?.startWebView(with: C.Links.privacy)
    }
    
    func bigSignUpButtonTapped() {
        coordinator?.startTimeline()
        coordinator?.finish(animated: false)
    }
    
    func loginButtonTapped() {
        coordinator?.startTimeline()
        coordinator?.finish(animated: false)
    }

}

