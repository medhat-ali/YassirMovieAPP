//
//  MoviesSceneDIContainer.swift
//  YassirMovieApp
//
//  Created by Medhat Ali on 19/08/2023.
//

import UIKit
import SwiftUI

final class MoviesSceneDIContainer: MoviesSearchFlowCoordinatorDependencies {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Repositories
    func makeMoviesRepository() -> MoviesRepository {
        DefaultMoviesRepository(
            dataTransferService: dependencies.apiDataTransferService
        )
    }
   
    func makePosterImagesRepository() -> PosterImagesRepository {
        DefaultPosterImagesRepository(
            dataTransferService: dependencies.imageDataTransferService
        )
    }
    
    // MARK: - Use Cases
    func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
        DefaultSearchMoviesUseCase(
            moviesRepository: makeMoviesRepository()
        )
    }
    
    // MARK: - Movies List View model and controller
    func makeMoviesListViewModel(actions: MoviesListViewModelActions) -> MoviesListViewModel {
        DefaultMoviesListViewModel(
            searchMoviesUseCase: makeSearchMoviesUseCase(),
            actions: actions
        )
    }
    
    func makeMoviesListViewController(actions: MoviesListViewModelActions) -> MoviesListViewController {
        MoviesListViewController.create(
            with: makeMoviesListViewModel(actions: actions),
            posterImagesRepository: makePosterImagesRepository()
        )
    }
    
    
    
    // MARK: - Movie Details View model and controller
    func makeMoviesDetailsViewModel(movie: Movie) -> MovieDetailsViewModel {
        DefaultMovieDetailsViewModel(
            movie: movie,
            posterImagesRepository: makePosterImagesRepository()
        )
    }
    
    func makeMoviesDetailsViewController(movie: Movie) -> UIViewController {
        MovieDetailsViewController.create(
            with: makeMoviesDetailsViewModel(movie: movie)
        )
    }

    // MARK: - Flow Coordinators
    func makeMoviesSearchFlowCoordinator(navigationController: UINavigationController) -> MoviesSearchFlowCoordinator {
        MoviesSearchFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}

