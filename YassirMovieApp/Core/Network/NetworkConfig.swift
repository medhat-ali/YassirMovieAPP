//
//  NetworkConfigurable.swift
//  YassirMovieApp
//
//  Created by Medhat Ali on 16/07/2023.
//

import Foundation

protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
    var tokenParameters: [String: String] { get }
}

struct ApiDataNetworkConfig: NetworkConfigurable {
    let baseURL: URL
    let headers: [String: String]
    let queryParameters: [String: String]
    let tokenParameters: [String: String]
    
     init(
        baseURL: URL,
        headers: [String: String] = [:],
        queryParameters: [String: String] = [:],
        tokenParameters: [String: String] = [:]
     ) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
        self.tokenParameters = tokenParameters

    }
}



