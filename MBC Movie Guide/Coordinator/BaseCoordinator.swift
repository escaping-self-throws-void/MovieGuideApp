//
//  BaseCoordinator.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 08/07/2022.
//

import UIKit

protocol MyCoordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: MyCoordinator? { get set }
    
    func start()
    func start(_ coordinator: MyCoordinator)
    func didFinish(_ coordinator: MyCoordinator)
}

class BaseCoordinator: MyCoordinator {
    
    var childCoordinators: [MyCoordinator] = []
    var parentCoordinator: MyCoordinator?
    var navigationController = UINavigationController()
    
    func start() {
        fatalError("Start method must be implemented")
    }
    
    func start(_ coordinator: MyCoordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func didFinish(_ coordinator: MyCoordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
    
}
