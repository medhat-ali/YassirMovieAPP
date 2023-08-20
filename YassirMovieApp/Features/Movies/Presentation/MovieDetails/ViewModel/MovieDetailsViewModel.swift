import Foundation

protocol MovieDetailsViewModelInput {
    func updatePosterImage(width: Int)
}

protocol MovieDetailsViewModelOutput {
    var title: String { get }
    var releaseDate: String { get }
    var posterImage: Observable<Data?> { get }
    var isPosterImageHidden: Bool { get }
    var overview: String { get }
}

protocol MovieDetailsViewModel: MovieDetailsViewModelInput, MovieDetailsViewModelOutput { }

final class DefaultMovieDetailsViewModel: MovieDetailsViewModel {
    
    private let posterImagePath: String?
    private let posterImagesRepository: PosterImagesRepository
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }
    private let mainQueue: DispatchQueueType

    // MARK: - OUTPUT
    let title: String
    var releaseDate: String = ""
    let posterImage: Observable<Data?> = Observable(nil)
    let isPosterImageHidden: Bool
    let overview: String
    
    init(
        movie: Movie,
        posterImagesRepository: PosterImagesRepository,
        mainQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.title = movie.title ?? ""
        if let releaseDate = movie.releaseDate {
            self.releaseDate = dateFormatter.string(from: releaseDate)
        }
        self.overview = movie.overview ?? ""
        self.posterImagePath = movie.posterPath
        self.isPosterImageHidden = movie.posterPath == nil
        self.posterImagesRepository = posterImagesRepository
        self.mainQueue = mainQueue
    }
}

// MARK: - INPUT. View event methods
extension DefaultMovieDetailsViewModel {
    
    func updatePosterImage(width: Int) {
        guard let posterImagePath = posterImagePath else { return }

        imageLoadTask = posterImagesRepository.fetchImage(
            with: posterImagePath,
            width: width
        ) { [weak self] result in
            self?.mainQueue.async {
                guard self?.posterImagePath == posterImagePath else { return }
                switch result {
                case .success(let data):
                    self?.posterImage.value = data
                case .failure: break
                }
                self?.imageLoadTask = nil
            }
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter
}()
