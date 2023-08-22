//
//  MoviesListSwiftUIView.swift
//  YassirMovieApp
//
//  Created by Medhat Ali on 20/08/2023.
//

import SwiftUI
import UIKit

struct MoviesListSwiftUIView: View {
    
    @ObservedObject var viewModelWrapper: MoviesListViewModelWrapper
    
    var body: some View {
        List {
            ForEach(Array(zip(viewModelWrapper.items , viewModelWrapper.items.indices)),  id: \.0) { item, index in
                NavigationLink(destination: MovieDetailsSwiftUIView(title: item.title, subtitle: item.releaseDate, description: item.overview, image: item.posterImagePath ?? "", viewModelWrapper: MoviesDetailsItemCellViewModelWrapper(viewModel: item, posterImagesRepository: viewModelWrapper.posterImagesRepository))) {
                    MoviesListItemCellSwiftUIView(viewModelWrapper: MoviesListItemCellViewModelWrapper(viewModel: item, posterImagesRepository: viewModelWrapper.posterImagesRepository)
                    )
                } .onAppear {
                    // load next pages
                    if index == Int(viewModelWrapper.items.count - 1) {
                        self.viewModelWrapper.viewModel?.didLoadNextPage()
                    }
                }
            }
        }
        .accessibilityIdentifier(AccessibilityIdentifier.moviesTableList)
        .navigationBarTitle("Movies")
        .onAppear {
            self.viewModelWrapper.viewModel?.didLoadMovies()
        }
        
    }
    
    
}

final class MoviesListViewModelWrapper: ObservableObject {
    var viewModel: MoviesListViewModel?
    var posterImagesRepository: PosterImagesRepository?
    
    @Published var items: [MoviesListItemViewModel] = []
    
    init(viewModel: MoviesListViewModel?,
         posterImagesRepository: PosterImagesRepository?
    ) {
        self.viewModel = viewModel
        self.posterImagesRepository = posterImagesRepository
        
        viewModel?.items.observe(on: self) { [weak self] values in self?.items = values }
    }
    
}


#if DEBUG
//struct MoviesListSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        var previewViewModelWrapper: MoviesListViewModelWrapper = {
//            var viewModel = MoviesListViewModelWrapper(viewModel: nil, posterImagesRepository: nil)
//           
//            return viewModel
//        }()
//        
//        MoviesListSwiftUIView(viewModelWrapper: previewViewModelWrapper)
//
//    }
//}
#endif
