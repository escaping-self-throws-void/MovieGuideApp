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
        if navigationController.viewControllers.contains(where: { $0 is SettingsViewController }) {
            navigationController.popViewController(animated: true)
        }
        parentCoordinator?.didFinish(self)
    }
    
    func startLanding() {
        parentCoordinator?.parentCoordinator?.start()
        finish()
    }
    
    func startSettings() {
        let viewController = SettingsViewController.instantiate()
        let viewModel = SettingsViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        viewController.delegate = self.delegate
        
        navigationController.pushViewController(viewController, animated: false)
        navigationController.dismiss(animated: false)
    }
}
