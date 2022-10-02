//
//  MovieDetailsCoordinator.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 20/07/2022.
//

import UIKit

private struct MovieDetailsStoryboard {
    static let name = "MovieDetails"
    static let storyboard = UIStoryboard(name: name, bundle: nil)
    let viewController = storyboard.instantiateViewController(identifier: "MovieDetailsViewControllerID") as? MovieDetailsViewController ?? MovieDetailsViewController()
    let navigationController = storyboard.instantiateViewController(identifier: "MovieDetailsNavigationControllerID") as? UINavigationController ?? UINavigationController()
}

final class MovieDetailsCoordinator {
    var viewController: MovieDetailsViewController?
    
    private let navigationController: UINavigationController
    private let movieId: String

    init(navigationController: UINavigationController? = nil, id: String) {
        if let navigationController = navigationController {
            self.navigationController = navigationController
        } else {
            self.navigationController = MovieDetailsStoryboard().navigationController
        }
        self.viewController = MovieDetailsStoryboard().viewController
        movieId = id
    }

    func start() {
        guard let viewController = viewController else {
            return
        }
        let viewModel = MovieDetailsViewModel(service: MockFetcher(), id: movieId)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }

    func stop() {
        _ = navigationController.popViewController(animated: true)
    }
}

