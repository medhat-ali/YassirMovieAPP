//
//  MoviesSwiftUISceneDIContainer.swift
//  YassirMovieApp
//
//  Created by Medhat Ali on 22/08/2023.
//

import UIKit
import SwiftUI

final class MoviesSwiftUISceneDIContainer: MoviesSwiftUISearchFlowCoordinatorDependencies {
    
    
    
    
    
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
    
    func makeMoviesListSwiftUIViewController(actions: MoviesListViewModelActions) -> MoviesListSwiftUIView? {
        let viewModelWrapper = MoviesListViewModelWrapper(viewModel: makeMoviesListViewModel(actions: actions), posterImagesRepository: makePosterImagesRepository())
        return MoviesListSwiftUIView(viewModelWrapper: viewModelWrapper)
       // let movieView = MoviesListSwiftUIView(viewModel: makeMoviesListViewModel(actions: actions), posterImagesRepository: makePosterImagesRepository())
       // return movieView
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

    
    // MARK: - Flow Swift UI Coordinators
    func makeMoviesSwiftUISearchFlowCoordinator(navigationController: UINavigationController) -> MoviesSwiftUISearchFlowCoordinator {
        MoviesSwiftUISearchFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
    
}


