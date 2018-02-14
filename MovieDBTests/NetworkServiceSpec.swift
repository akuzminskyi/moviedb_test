//
//  NetworkServiceSpec.swift
//  MovieDBTests
//
//  Created by Andrii Kuzminskyi on 14/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Quick
import Nimble
@testable import MovieDB

final class NetworkServiceSpec: QuickSpec {
    private final class MockNetworkProvider: NetworkProviding {
        struct MockNetworkOperation: NetworkOperationable {
            func cancel() {
            }
            
            func resume() {
            }
        }
        
        var resultData: Data?
        var resultError: Error?
        
        func dataTasks(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkOperationable {
            completionHandler(resultData, nil, resultError)
            return MockNetworkOperation()
        }
    }
    
    override func spec() {
        describe("A NetworkService") {
            var networkService: NetworkServicing!
            var networkProvider: MockNetworkProvider!
            beforeEach {
                networkProvider = MockNetworkProvider()
                networkService = NetworkService(networkProvider: networkProvider)
            }
            @discardableResult func executeMockedRequest(completionBlock: @escaping (Result<Data>) -> ()) -> NetworkOperationCancalable {
                return networkService.execute(request: URL(string: "http://example.com")!, completionBlock: completionBlock)
            }

            context("with provider success result") {
                it("should return .success with the mocked data") {
                    let data = "example".data(using: .utf8)!
                    networkProvider.resultData = data
                    networkProvider.resultError = nil

                    waitUntil { done in
                        executeMockedRequest(completionBlock: { (result) in
                            if case Result<Data>.success(let data) = result, networkProvider.resultData == data {
                            } else {
                                fail("Expecting that the output data should be equal the mocked data")
                            }
                            done()
                        })
                    }
                }
            }
            context("with a provider failure result") {
                it("should return .failure with the mocked error") {
                    networkProvider.resultData = nil
                    networkProvider.resultError = NSError(domain: "example.com", code: 0, userInfo: nil)

                    waitUntil { done in
                        executeMockedRequest(completionBlock: { (result) in
                            if case Result<Data>.failure(_) = result {
                            } else {
                                fail("Expecting that the output error should be equal the mocked error")
                            }
                            done()
                        })
                    }
                }
            }
        }
    }
}

