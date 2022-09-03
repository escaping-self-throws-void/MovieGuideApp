//
//  SettingsCoordinator.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 23/07/2022.
//

import UIKit

private struct SettingsStoryboard {
    static let name = "Settings"
    static let storyboard = UIStoryboard(name: name, bundle: nil)
    let viewController = storyboard.instantiateViewController(identifier: "SettingsViewControllerID") as? SettingsViewController ?? SettingsViewController()
    let navigationController = storyboard.instantiateViewController(identifier: "SettingsNavigationControllerID") as? UINavigationController ?? UINavigationController()
}

final class SettingsCoordinator {
    weak var viewController: SettingsViewController?
    weak var delegate: SideMenuDelegate?

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController? = nil) {
        if let navigationController = navigationController {
            self.navigationController = navigationController
        } else {
            self.navigationController = SettingsStoryboard().navigationController
        }
        self.viewController = SettingsStoryboard().viewController
    }

    func start() {
        guard let viewController = viewController else {
            return
        }
        viewController.delegate = delegate
        navigationController.pushViewController(viewController, animated: true)
    }

    func stop() {
        _ = navigationController.popViewController(animated: true)
    }
}

