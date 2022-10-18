//
//  SignUpCoordinator.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 08/07/2022.
//

import UIKit

final class SignUpCoordinator: BaseCoordinator {
    
    var isLogin = false
    private let viewController = SignUpViewController.instantiate()
    
    override func start() {
        let viewModel = SignUpViewModel(isLogin: isLogin)
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        viewController.isModalInPresentation = false
//        if let sheet = viewController.sheetPresentationController {
//            sheet.detents = [ .large(), .medium()]
//            sheet.selectedDetentIdentifier = .large
//            navigationController.present(viewController, animated: true)
//        } else {
            viewController.modalPresentationStyle = .overCurrentContext
            navigationController.present(viewController, animated: true)
//        }
    }
    
    func startWebView(with link: String) {
        let viewController = WebViewController(link)
        self.viewController.present(viewController, animated: true)
    }
    
    func startTimeline() {
        UserSession.shared.isGuest = false
        let coordinator = TimelineCoordinator()
        coordinator.navigationController = navigationController
        start(coordinator)
    }
    
    func finish(animated: Bool) {
        navigationController.dismiss(animated: animated)
        parentCoordinator?.didFinish(self)
    }
}
