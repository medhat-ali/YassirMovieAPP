import XCTest

class SearchMoviesUseCaseTests: XCTestCase {
    
    static let moviesPages: [MoviesPage] = {
        let page1 = MoviesPage(page: 1, totalPages: 2, movies: [
            Movie.stub(id: "1", title: "title1", posterPath: "/1", overview: "overview1"),
            Movie.stub(id: "2", title: "title2", posterPath: "/2", overview: "overview2")])
        let page2 = MoviesPage(page: 2, totalPages: 2, movies: [
            Movie.stub(id: "3", title: "title3", posterPath: "/3", overview: "overview3")])
        return [page1, page2]
    }()
    
    enum MoviesRepositorySuccessTestError: Error {
        case failedFetching
    }
    
    class MoviesRepositoryMock: MoviesRepository {
        var result: Result<MoviesPage, Error>
        var fetchCompletionCallsCount = 0

        init(result: Result<MoviesPage, Error>) {
            self.result = result
        }

        func fetchMoviesList(
            query: MovieQuery,
            page: Int,
            cached: @escaping (MoviesPage) -> Void,
            completion: @escaping (Result<MoviesPage, Error>
            ) -> Void
        ) -> Cancellable? {
            completion(result)
            fetchCompletionCallsCount += 1
            return nil
        }
    }
    
    func testSearchMoviesUseCase_whenSuccessfullyFetchesMoviesForQuery_thenQueryIsSavedInRecentQueries() {
        // given
        var useCaseCompletionCallsCount = 0
        let moviesRepository = MoviesRepositoryMock(
            result: .success(SearchMoviesUseCaseTests.moviesPages[0])
        )
        let useCase = DefaultSearchMoviesUseCase(
            moviesRepository: moviesRepository
        )

        // when
        let requestValue = SearchMoviesUseCaseRequestValue(
            query: MovieQuery(query: "title1"),
            page: 0
        )
        _ = useCase.execute(
            requestValue: requestValue,
            cached: { _ in }
        ) { _ in
            useCaseCompletionCallsCount += 1
        }
        // then
        
        XCTAssertEqual(useCaseCompletionCallsCount, 1)
    }
    
    func testSearchMoviesUseCase_whenFailedFetchingMoviesForQuery_thenQueryIsNotSavedInRecentQueries() {
        // given
        var useCaseCompletionCallsCountCount = 0
        let useCase = DefaultSearchMoviesUseCase(moviesRepository: MoviesRepositoryMock(result: .failure(MoviesRepositorySuccessTestError.failedFetching))
        )
        
        // when
        let requestValue = SearchMoviesUseCaseRequestValue(query: MovieQuery(query: "title1"),
                                                           page: 0)
        _ = useCase.execute(requestValue: requestValue, cached: { _ in }) { _ in
            useCaseCompletionCallsCountCount += 1
        }
        // then
        XCTAssertEqual(useCaseCompletionCallsCountCount, 1)
    }
}
