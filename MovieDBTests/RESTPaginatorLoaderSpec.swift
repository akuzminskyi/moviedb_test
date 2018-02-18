//
//  RESTPaginatorLoaderSpec.swift
//  MovieDBTests
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Quick
import Nimble
@testable import MovieDB


final class RESTPaginatorLoaderSpec: QuickSpec {
    enum JSONSamples {
        enum Valide: String {
            case structureWithStringResults = "{\"page\":2,\"total_results\":105,\"total_pages\":6,\"results\":[\"val1\",\"val2\"]}"
        }
        enum Invalide: String {
            case structure = "{\"pagination\":{\"page\":2,\"total_results\":105,\"total_pages\":6},\"results\":[\"val1\",\"val2\"]}"
        }
    }

    override func spec() {
        describe("A RESTPaginatorLoader") {
            var loader: RESTPaginatorLoader!
            var networkProvider: MockedNetworkProvider!
            var request: RESTPaginatorNetworkRequestable!

            beforeEach {
                let decoder = JSONDecoder()
                networkProvider = MockedNetworkProvider()
                let networkService = NetworkService(networkProvider: networkProvider)

                loader = RESTPaginatorLoader(networkService: networkService,
                                             decoder: decoder)

            }

            beforeEach {
                networkProvider.delay = 0
                networkProvider.resultError = nil
                networkProvider.resultData = nil
                request = RESTPaginatorNetworkRequest(baseURL: baseUrl,
                                                      page: 2,
                                                      pageParameterName: "page")!
            }

            context("should be Result.success") {
                it("Result.success if valude structure") {
                    networkProvider.resultData = JSONSamples.Valide.structureWithStringResults.rawValue.data(using: .utf8)
                    waitUntil { (done) in
                        loader.load(request: request, completionBlock: { (result: Result<RESTPaginatorResponse<String>>) in
                            expect({
                                guard case Result.success(_) = result else {
                                    return .failed(reason: "Wrong result status")
                                }
                                return .succeeded
                            }).to(succeed())
                            done()
                        })
                    }
                }
            }
            context("should be Result.failure") {
                it("if invalide structure") {
                    networkProvider.resultData = JSONSamples.Invalide.structure.rawValue.data(using: .utf8)
                    waitUntil { (done) in
                        loader.load(request: request, completionBlock: { (result: Result<RESTPaginatorResponse<String>>) in
                            expect({
                                guard case Result.failure(_) = result else {
                                    return .failed(reason: "Wrong result status")
                                }
                                return .succeeded
                            }).to(succeed())
                            done()
                        })
                    }
                }
                it("if network service have an error") {
                    networkProvider.resultError = RESTPaginatorError.unexpected
                    waitUntil { (done) in

                        loader.load(request: request, completionBlock: { (result: Result<RESTPaginatorResponse<String>>) in
                            expect({
                                guard case Result.failure(_) = result else {
                                    return .failed(reason: "Wrong result status")
                                }
                                return .succeeded
                            }).to(succeed())
                            done()
                        })
                    }
                }
            }

            context("track in progress requests") {
                it("it should return RESTPaginatorLoaderError.requestAlreadyInProgress if a request existing") {
                    networkProvider.delay = 0.1
                    networkProvider.resultData = JSONSamples.Valide.structureWithStringResults.rawValue.data(using: .utf8)

                    waitUntil(timeout: 1.0, action: { (done) in
                        let group = DispatchGroup()

                        group.enter()
                        loader.load(force: false, request: request, completionBlock: { (result: Result<RESTPaginatorResponse<String>>) in
                            expect({
                                guard case Result.success(_) = result else {
                                    return .failed(reason: "Wrong result status")
                                }
                                return .succeeded
                            }).to(succeed())
                            group.leave()
                        })

                        group.enter()
                        loader.load(force: false, request: request, completionBlock: { (result: Result<RESTPaginatorResponse<String>>) in
                            expect({
                                guard case Result.failure(let error) = result,
                                    let loaderError = error as? RESTPaginatorLoaderError,
                                    RESTPaginatorLoaderError.requestAlreadyInProgress == loaderError else {
                                        return .failed(reason: "Wrong result status")
                                }
                                return .succeeded
                            }).to(succeed())
                            group.leave()
                        })
                        group.notify(queue: DispatchQueue.main, execute: {
                            done()
                        })
                    })
                }
                it("it should return Result.success if a request existing but have to be load as force") {
                    networkProvider.delay = 0.1
                    networkProvider.resultData = JSONSamples.Valide.structureWithStringResults.rawValue.data(using: .utf8)

                    waitUntil(timeout: 1.0, action: { (done) in
                        let group = DispatchGroup()

                        group.enter()
                        loader.load(force: false, request: request, completionBlock: { (result: Result<RESTPaginatorResponse<String>>) in
                            expect({
                                guard case Result.success(_) = result else {
                                    return .failed(reason: "Wrong result status")
                                }
                                return .succeeded
                            }).to(succeed())
                            group.leave()
                        })

                        group.enter()
                        loader.load(force: true, request: request, completionBlock: { (result: Result<RESTPaginatorResponse<String>>) in
                            expect({
                                guard case Result.success(_) = result else {
                                    return .failed(reason: "Wrong result status")
                                }
                                return .succeeded
                            }).to(succeed())
                            group.leave()
                        })
                        group.notify(queue: DispatchQueue.main, execute: {
                            done()
                        })
                    })
                }
            }
        }
    }
}

