//
//  TimelineCoordinator.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 13/07/2022.
//

import Foundation

final class TimelineCoordinator: BaseCoordinator {
        
    override func start() {
        let viewController = TimelineViewController.instantiate()
        let viewModel = TimelineViewModel(service: MockFetcher())
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }

    func startSideMenu(_ delegate: SideMenuDelegate?) {
        let coordinator = SideMenuCoordinator()
        coordinator.navigationController = navigationController
        coordinator.delegate = delegate
        start(coordinator)
    }
    
    
    func finish() {
        navigationController.popViewController(animated: true)
        parentCoordinator?.didFinish(self)
    }
}
