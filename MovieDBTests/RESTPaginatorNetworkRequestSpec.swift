//
//  RESTPaginatorNetworkRequestSpec.swift
//  MovieDBTests
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Quick
import Nimble
@testable import MovieDB

final class RESTPaginatorNetworkRequestSpec: QuickSpec {
    let urlSamples: [URL] = [
        URL(string: "http://www.example.com")!,
        URL(string: "https://www.example.com")!,
        URL(string: "http://www.example.com/path?section=17")!,
        URL(string: "ftp://www.example.com")!,
        URL(string: "www.example.com/foo")!,
        URL(string: "example.com")!
    ]

    override func spec() {
        describe("A RESTPaginatorNetworkRequest") {
            context("for each url") {
                for url in urlSamples {
                    var request: RESTPaginatorNetworkRequest?
                    beforeEach {
                        request = RESTPaginatorNetworkRequest(baseURL: url, page: 4, pageParameterName: "page")
                    }
                    it("should consist the page as a parametr of URL") {
                        expect(request?.url.absoluteString).to(contain("page=4"))
                    }
                }
            }
        }
    }
}
