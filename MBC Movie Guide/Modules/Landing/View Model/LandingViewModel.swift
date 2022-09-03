//
//  LandingViewModel.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 06/07/2022.
//

import Foundation

protocol LandingViewModelProtocol {
    func skipButtonTapped()
    func signUpButtonTapped()
    func logInButtonTapped()
}

final class LandingViewModel: LandingViewModelProtocol {
    
    weak var coordinator: LandingCoordinator?
    
    func skipButtonTapped() {
        coordinator?.startTimelineAsGuest()
    }
    
    func signUpButtonTapped() {
        coordinator?.startSignUp()
    }
    
    func logInButtonTapped() {
        coordinator?.startLogIn()
    }
    
}
