//
//  MovieDetailsViewModelTests.swift
//  YassirMovieAppTests
//
//  Created by Medhat Ali on 20/08/2023.
//
import Foundation
import XCTest

class PosterImagesRepositoryMock: PosterImagesRepository {
    var completionCalls = 0
    var error: Error?
    var image = Data()
    var validateInput: ((String, Int) -> Void)?
    
    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        validateInput?(imagePath, width)
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(image))
        }
        completionCalls += 1
        return nil
    }
}

class MovieDetailsViewModelTests: XCTestCase {
    
    private enum PosterImageDownloadError: Error {
        case someError
    }
    
    func test_updatePosterImageWithWidthEventReceived_thenImageWithThisWidthIsDownloaded() {
        // given
        let posterImagesRepository = PosterImagesRepositoryMock()

        let expectedImage = "image data".data(using: .utf8)!
        posterImagesRepository.image = expectedImage

        let viewModel = DefaultMovieDetailsViewModel(
            movie: Movie.stub(posterPath: "posterPath"),
            posterImagesRepository: posterImagesRepository,
            mainQueue: DispatchQueueTypeMock()
        )
        
        posterImagesRepository.validateInput = { (imagePath: String, width: Int) in
            XCTAssertEqual(imagePath, "posterPath")
            XCTAssertEqual(width, 200)
        }
        
        // when
        viewModel.updatePosterImage(width: 200)
        
        // then
        XCTAssertEqual(viewModel.posterImage.value, expectedImage)
        XCTAssertEqual(posterImagesRepository.completionCalls, 1)
    }
}

