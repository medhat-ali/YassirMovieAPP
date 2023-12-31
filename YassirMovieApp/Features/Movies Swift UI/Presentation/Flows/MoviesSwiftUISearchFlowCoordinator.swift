//
//  MoviesSwiftUISearchFlowCoordinator.swift
//  YassirMovieApp
//
//  Created by Medhat Ali on 22/08/2023.
//

import UIKit
import SwiftUI

protocol MoviesSwiftUISearchFlowCoordinatorDependencies  {
    func makeMoviesListSwiftUIViewController(
        actions: MoviesListViewModelActions
    ) -> MoviesListSwiftUIView?
}

final class MoviesSwiftUISearchFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: MoviesSwiftUISearchFlowCoordinatorDependencies

    init(navigationController: UINavigationController,
         dependencies: MoviesSwiftUISearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
        let actions = MoviesListViewModelActions(showMovieDetails: showMovieDetails)
        let vc = dependencies.makeMoviesListSwiftUIViewController(actions: actions)

        navigationController?.pushViewController(UIHostingController(rootView: vc), animated: false)
    }

    private func showMovieDetails(movie: Movie) {
    }
}

