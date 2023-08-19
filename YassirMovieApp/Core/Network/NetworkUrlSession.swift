//
//  NetworkUrlSession.swift
//  YassirMovieApp
//
//  Created by Medhat Ali on 16/07/2023.
//

import Foundation

protocol NetworkUrlSession {
    var sessionDelegate: URLSessionDelegate? { get }
    var piningDelegate: URLSessionDelegate? { get }
    var urlSession: URLSession? { get }
}

final class DefaultNetworkUrlSession: NetworkUrlSession {
    var urlSession: URLSession?
    let sessionDelegate: URLSessionDelegate?
    let piningDelegate: URLSessionDelegate?
    

     init(
        sessionDelegate: URLSessionDelegate? ,
        piningDelegate: URLSessionDelegate?
     ) {
        self.sessionDelegate = sessionDelegate
        self.piningDelegate = piningDelegate
      
        self.urlSession = URLSession(configuration: .default, delegate: piningDelegate, delegateQueue: nil)
    }
    
    convenience init() {
        self.init(sessionDelegate: nil, piningDelegate: nil)
    }
    
    
}

