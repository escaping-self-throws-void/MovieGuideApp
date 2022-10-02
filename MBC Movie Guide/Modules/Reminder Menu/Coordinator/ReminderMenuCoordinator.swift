//
//  ReminderMenuCoordinator.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 22/07/2022.
//

import UIKit

private struct ReminderMenuStoryboard {
    static let name = "ReminderMenu"
    static let storyboard = UIStoryboard(name: name, bundle: nil)
    let viewController = storyboard.instantiateViewController(identifier: "ReminderMenuViewControllerID") as? ReminderMenuViewController ?? ReminderMenuViewController()
    let navigationController = storyboard.instantiateViewController(identifier: "ReminderMenuNavigationControllerID") as? UINavigationController ?? UINavigationController()
}

final class ReminderMenuCoordinator {
    var viewController: ReminderMenuViewController?
    weak var delegate: ReminderMenuDelegate?
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController? = nil) {
        if let navigationController = navigationController {
            self.navigationController = navigationController
        } else {
            self.navigationController = ReminderMenuStoryboard().navigationController
        }
        self.viewController = ReminderMenuStoryboard().viewController
    }

    func start() {
        guard let viewController = viewController else {
            return
        }
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        viewController.delegate = delegate
        navigationController.present(viewController, animated: true)
    }

    func stop() {
        _ = navigationController.popViewController(animated: true)
    }
}

