//
//  DispatchQueueTypeMock.swift
//  YassirMovieAppTests
//
//  Created by Medhat Ali on 20/08/2023.
//

import Foundation

final class DispatchQueueTypeMock: DispatchQueueType {
    func async(execute work: @escaping () -> Void) {
        work()
    }
}
