//
//  MockedNetworkProvider.swift
//  MovieDBTests
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

@testable import MovieDB

final class MockedNetworkProvider: NetworkProviding {
    struct MockNetworkOperation: NetworkOperationable {
        func cancel() {
        }

        func resume() {
        }
    }

    var resultData: Data?
    var resultError: Error?
    var delay = 0.0

    func dataTasks(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkOperationable {
        if delay == 0.0 {
            completionHandler(self.resultData, nil, self.resultError)
        } else {
            let after = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: after) {
                completionHandler(self.resultData, nil, self.resultError)
            }
        }
        return MockNetworkOperation()
    }
}
