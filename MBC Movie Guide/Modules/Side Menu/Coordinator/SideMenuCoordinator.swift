//
//  sCoordinator.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 19/07/2022.
//

import Foundation

final class SideMenuCoordinator: BaseCoordinator {
    
    weak var delegate: SideMenuDelegate?
    
    override func start() {
        let viewController = SideMenuViewController.instantiate()
        let viewModel = SideMenuViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        viewController.delegate = delegate
    
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen

        navigationController.present(viewController, animated: true)
    }

    func finish() {
        navigationController.dismiss(animated: false)
        parentCoordinator?.didFinish(self)
    }
    
    func startLanding() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func startSettings() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let coordinator = SettingsCoordinator(navigationController: self.navigationController)
            coordinator.delegate = self.delegate
            coordinator.start()
        }
    }
}
