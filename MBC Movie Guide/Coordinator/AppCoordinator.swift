//
//  AppCoordinator.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/07/2022.
//

import UIKit


final class AppCoordinator: BaseCoordinator {
     
    private let window: UIWindow
        
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        navigationController.navigationBar.isHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let coordinator = LandingCoordinator()
        coordinator.navigationController = navigationController
        start(coordinator)
    }
}
