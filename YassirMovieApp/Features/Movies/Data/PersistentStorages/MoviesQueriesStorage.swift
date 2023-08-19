//
//  MoviesQueriesStorage.swift
//  YassirMovieApp
//
//  Created by Medhat Ali on 19/08/2023.
//

import Foundation

protocol MoviesQueriesStorage {
    func fetchRecentsQueries(
        maxCount: Int,
        completion: @escaping (Result<[MovieQuery], Error>) -> Void
    )
    func saveRecentQuery(
        query: MovieQuery,
        completion: @escaping (Result<MovieQuery, Error>) -> Void
    )
}

