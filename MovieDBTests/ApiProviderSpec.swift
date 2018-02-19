//
//  ApiProviderSpec.swift
//  MovieDBTests
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Quick
import Nimble
@testable import MovieDB

final class ApiProviderSpec: QuickSpec {
    override func spec() {
        describe("A ApiProvider") {
            var provider: ApiProviderable!
            beforeEach {
                let apiDomain = URL(string: "http://api.example.com/")!
                let imageDomain = URL(string: "http://image.example.com/")!
                provider = ApiProvider(apiDomain: apiDomain,
                                       imageDomain: imageDomain,
                                       apiKey: ("api_key", "6f945eae9d2242da80c39f6232c1ad45"),
                                       apiVersion: .v3)
            }

            context("for Image url") {
                context("with a custom path") {
                    it("should return url with this path") {
                        expect(provider.imageURL(withRelativePath: "/2DtPSyODKWXluIRV7PVru0SSzja.jpg",
                                                 withSize: .w185)?.absoluteString)
                            .to(equal("http://image.example.com/w185/2DtPSyODKWXluIRV7PVru0SSzja.jpg"))

                        expect(provider.imageURL(withRelativePath: "/2DtPSyODKWXluIRV7PVru0SSzja.jpg",
                                                 withSize: .w500)?.absoluteString)
                            .to(equal("http://image.example.com/w500/2DtPSyODKWXluIRV7PVru0SSzja.jpg"))

                        expect(provider.imageURL(withRelativePath: "/images/2DtPSyODKWXluIRV7PVru0SSzja.jpg",
                                                 withSize: .w780)?.absoluteString)
                            .to(equal("http://image.example.com/w780/images/2DtPSyODKWXluIRV7PVru0SSzja.jpg"))
                    }
                }

                context("without path") {
                    it("should return nil") {
                        expect(provider.imageURL(withRelativePath: "",
                                                 withSize: .w185)?.absoluteString)
                            .to(beNil())
                    }
                }
            }

            context("for API url") {
                context("without path") {
                    it("should return nil") {
                        expect(provider.apiURL(withRelativePath: "")?.absoluteString)
                            .to(beNil())
                    }
                }
                context("with root path") {
                    it("should return url only with domain+apiverion+apikey") {
                        expect(provider.apiURL(withRelativePath: "/")?.absoluteString)
                            .to(equal("http://api.example.com/3/?api_key=6f945eae9d2242da80c39f6232c1ad45"))
                    }
                }

                context("with a custom path") {
                    it("should return url with this path") {
                        expect(provider.apiURL(withRelativePath: "/movie/search")?.absoluteString)
                            .to(equal("http://api.example.com/3/movie/search?api_key=6f945eae9d2242da80c39f6232c1ad45"))
                        expect(provider.apiURL(withRelativePath: "/movie")?.absoluteString)
                            .to(equal("http://api.example.com/3/movie?api_key=6f945eae9d2242da80c39f6232c1ad45"))

                    }
                }
            }
        }
    }
}
