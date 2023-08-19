//
//  String+Extension.swift
//  YassirMovieApp
//
//  Created by Medhat Ali on 08/08/2023.
//

import Foundation

public extension String {
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func dataUTF8() -> Data? {
        return data(using: .utf8)?.base64EncodedString().data(using: .utf8)
    }
}
