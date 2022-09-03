//
//  LandingCoordinator.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/07/2022.
//

import UIKit

final class LandingCoordinator: BaseCoordinator {
        
    override func start() {
        let viewController = LandingViewController.instantiate()
        let viewModel = LandingViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func startSignUp() {
        let coordinator = SignUpCoordinator()
        coordinator.navigationController = navigationController
        start(coordinator)
    }
    
    func startLogIn() {
        let coordinator = SignUpCoordinator()
        coordinator.isLogin = true
        coordinator.navigationController = navigationController
        start(coordinator)
    }
    
    func startTimelineAsGuest() {
        UserSession.shared.isGuest = true
        let coordinator = TimelineCoordinator()
        coordinator.navigationController = navigationController
        start(coordinator)
    }
}
