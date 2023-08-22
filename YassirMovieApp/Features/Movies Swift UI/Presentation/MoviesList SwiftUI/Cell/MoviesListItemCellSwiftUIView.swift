//
//  MoviesListItemCellSwiftUIView.swift
//  YassirMovieApp
//
//  Created by Medhat Ali on 20/08/2023.
//

import SwiftUI
import UIKit

struct MoviesListItemCellSwiftUIView: View {
    
    @ObservedObject var viewModelWrapper: MoviesListItemCellViewModelWrapper
    
    var body: some View {
        HStack {
            
            Image(uiImage: self.viewModelWrapper.imageData ?? UIImage())
                .resizable()
                .frame(width: 80, height: 110)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(self.viewModelWrapper.viewModel?.title ?? "")
                    .font(.headline)
                Text(self.viewModelWrapper.viewModel?.releaseDate ?? "")
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding()
        .onAppear {
            
        }
    }
    
    
}

final class MoviesListItemCellViewModelWrapper: ObservableObject {
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


