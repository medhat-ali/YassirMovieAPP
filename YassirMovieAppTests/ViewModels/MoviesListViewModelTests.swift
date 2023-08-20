import XCTest

class MoviesListViewModelTests: XCTestCase {

    private enum SearchMoviesUseCaseError: Error {
        case someError
    }

    let moviesPages: [MoviesPage] = {
        let page1 = MoviesPage(page: 1, totalPages: 2, movies: [
            Movie.stub(id: "1", title: "title1", posterPath: "/1", overview: "overview1"),
            Movie.stub(id: "2", title: "title2", posterPath: "/2", overview: "overview2")])
        let page2 = MoviesPage(page: 2, totalPages: 2, movies: [
            Movie.stub(id: "3", title: "title3", posterPath: "/3", overview: "overview3")])
        return [page1, page2]
    }()

    class SearchMoviesUseCaseMock: SearchMoviesUseCase {
        var executeCallCount: Int = 0

        typealias ExecuteBlock = (
            SearchMoviesUseCaseRequestValue,
            (MoviesPage) -> Void,
            (Result<MoviesPage, Error>) -> Void
        ) -> Void

        lazy var _execute: ExecuteBlock = { _, _, _ in
            XCTFail("not implemented")
        }

        func execute(
            requestValue: SearchMoviesUseCaseRequestValue,
            cached: @escaping (MoviesPage) -> Void,
            completion: @escaping (Result<MoviesPage, Error>) -> Void
        ) -> Cancellable? {
            executeCallCount += 1
            _execute(requestValue, cached, completion)
            return nil
        }
    }

 

    func test_whenSearchMoviesUseCaseRetrievesFirstPage_thenViewModelContainsOnlyFirstPage() {
        // given
        let searchMoviesUseCaseMock = SearchMoviesUseCaseMock()

        searchMoviesUseCaseMock._execute = { requestValue, _, completion in
            XCTAssertEqual(requestValue.page, 1)
            completion(.success(self.moviesPages[0]))
        }
        let viewModel = DefaultMoviesListViewModel(
            searchMoviesUseCase: searchMoviesUseCaseMock,
            mainQueue: DispatchQueueTypeMock()
        )
        // when
        viewModel.didLoadMovies()

        // then
        let expectedItems = moviesPages[0]
            .movies
            .map { MoviesListItemViewModel(movie: $0) }
        XCTAssertEqual(viewModel.items.value, expectedItems)
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertTrue(viewModel.hasMorePages)
        XCTAssertEqual(searchMoviesUseCaseMock.executeCallCount, 1)
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }

    func test_whenSearchMoviesUseCaseReturnsError_thenViewModelContainsError() {
        // given
        let searchMoviesUseCaseMock = SearchMoviesUseCaseMock()

        searchMoviesUseCaseMock._execute = { requestValue, _, completion in
            XCTAssertEqual(requestValue.page, 1)
            completion(.failure(SearchMoviesUseCaseError.someError))
        }
        let viewModel = DefaultMoviesListViewModel.make(
            searchMoviesUseCase: searchMoviesUseCaseMock
        )
        // when
        viewModel.didLoadMovies()

        // then
        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(viewModel.items.value.isEmpty)
        XCTAssertEqual(searchMoviesUseCaseMock.executeCallCount, 1)
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }

    func test_whenLastPage_thenHasNoPageIsTrue() {
        // given
        let searchMoviesUseCaseMock = SearchMoviesUseCaseMock()
        searchMoviesUseCaseMock._execute = { requestValue, _, completion in
            XCTAssertEqual(requestValue.page, 1)
            completion(.success(self.moviesPages[0]))
        }
        let viewModel = DefaultMoviesListViewModel.make(
            searchMoviesUseCase: searchMoviesUseCaseMock
        )
        // when
        viewModel.didLoadMovies()
        XCTAssertEqual(searchMoviesUseCaseMock.executeCallCount, 1)

        searchMoviesUseCaseMock._execute = { requestValue, _, completion in
            XCTAssertEqual(requestValue.page, 2)
            completion(.success(self.moviesPages[1]))
        }

        viewModel.didLoadNextPage()

        // then
        XCTAssertEqual(viewModel.currentPage, 2)
        XCTAssertFalse(viewModel.hasMorePages)
        XCTAssertEqual(searchMoviesUseCaseMock.executeCallCount, 2)
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }

  

}

extension DefaultMoviesListViewModel {
    static func make(
        searchMoviesUseCase: SearchMoviesUseCase
    ) -> DefaultMoviesListViewModel {
        DefaultMoviesListViewModel(
            searchMoviesUseCase: searchMoviesUseCase,
            mainQueue: DispatchQueueTypeMock()
        )
    }
}


