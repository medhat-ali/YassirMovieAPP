//
//  MovieDetailsSwiftUIView.swift
//  YassirMovieApp
//
//  Created by Medhat Ali on 21/08/2023.
//

import SwiftUI


struct MovieDetailsSwiftUIView: View {
    let title: String
    let subtitle: String
    let description: String
    let image: String

    @ObservedObject var viewModelWrapper: MoviesDetailsItemCellViewModelWrapper

    var body: some View {
        ScrollView {
            VStack {
                Image(uiImage: self.viewModelWrapper.imageData ?? UIImage())
                    .resizable()
                    .frame(width: 160, height: 220)
                    .cornerRadius(20)
                    .accessibilityIdentifier(AccessibilityIdentifier.movieDetailsView)
                Text(title)
                    .font(.largeTitle)
                Text(subtitle)
                    .font(.title)
                Text(description)
                    .font(.title)
                    .multilineTextAlignment(.leading)
                
                
            }
            .padding()
        }
        .navigationBarTitle(title)
    }
        
}

final class MoviesDetailsItemCellViewModelWrapper: ObservableObject {
    var viewModel: MoviesListItemViewModel?
    var posterImagesRepository: PosterImagesRepository?
    
    @Published var item: MoviesListItemViewModel?
    @Published var imageData: UIImage? = UIImage(named: "")
    
    private let mainQueue: DispatchQueueType = DispatchQueue.main
    
    init(viewModel: MoviesListItemViewModel?,
         posterImagesRepository: PosterImagesRepository?
    ) {
        self.viewModel = viewModel
        self.posterImagesRepository = posterImagesRepository
        
        updatePosterImage(width: 50)
        
    }
    
    private func updatePosterImage(width: Int) {
        //posterImageView.image = nil
        guard let posterImagePath = viewModel?.posterImagePath else { return }
        
        _ = posterImagesRepository?.fetchImage(
            with: posterImagePath,
            width: width
        ) { [weak self] result in
            self?.mainQueue.async {
                guard self?.viewModel?.posterImagePath == posterImagePath else { return }
                if case let .success(data) = result {
                    self?.imageData = UIImage(data: data)
                }
            }
        }
    }
    
}

