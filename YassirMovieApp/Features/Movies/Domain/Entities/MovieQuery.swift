//
//  File.swift
//  YassirMovieApp
//
//  Created by Medhat Ali on 19/08/2023.
//

import Foundation

struct MovieQuery: Equatable {
    let query: String
    let include_adult: Bool = false
    let include_video: Bool = false
    let sort_by: String = "popularity.desc"
}

