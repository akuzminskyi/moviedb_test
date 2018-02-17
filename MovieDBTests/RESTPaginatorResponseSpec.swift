//
//  RESTPaginatorResponseSpec.swift
//  MovieDBTests
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

import Quick
import Nimble
@testable import MovieDB

final class RESTPaginatorResponseSpec: QuickSpec {
    enum JSONSamples {
        enum Valide: String {
            case structureWithArrayOfStringResults = "{\"page\":2,\"total_results\":105,\"total_pages\":6,\"results\":[\"val1\",\"val2\"]}"
            case structureWithArrayOfIntResults = "{\"page\":2,\"total_results\":105,\"total_pages\":6,\"results\":[1,2,3]}"
        }
        enum Invalide: String {
            case structure = "{\"pagination\":{\"page\":2,\"total_results\":105,\"total_pages\":6},\"results\":[\"val1\",\"val2\"]}"
        }
    }

    override func spec() {
        describe("A RESTPaginatorResponse") {
            let decoder: Decoderable = JSONDecoder()

            func decode<T>(string: String) throws -> RESTPaginatorResponse<T> {
                let data = string.data(using: .utf8)!
                return try decoder.decode(RESTPaginatorResponse<T>.self, from: data)
            }

            context("<String>") {
                var response: RESTPaginatorResponse<String>?


                afterEach {
                    response = nil
                }
                context("is Decodable when") {
                    beforeEach {
                        response = try? decode(string: JSONSamples.Valide.structureWithArrayOfStringResults.rawValue)
                    }

                    it("structure is valide") {
                        expect(response).toNot(beNil())
                    }

                    it("input values is the same as serialized") {
                        expect(response?.page).to(equal(2))
                        expect(response?.numberOfPages).to(equal(6))
                        expect(response?.numberOfResults).to(equal(105))
                    }
                    it("input results type is the same as serialized") {
                        expect(response?.results).to(equal(["val1", "val2"]))
                    }
                    it("input values is the same as serialized") {
                        expect(response?.page).to(equal(2))
                        expect(response?.numberOfPages).to(equal(6))
                        expect(response?.numberOfResults).to(equal(105))
                        expect(response?.results).to(equal(["val1", "val2"]))
                    }
                }
                context("isn't Decodable when") {
                    beforeEach {
                        response = try? decode(string: JSONSamples.Invalide.structure.rawValue)
                    }

                    it("structure is invalide") {
                        expect(response).to(beNil())
                    }
                }
            }
            context("<Int>") {
                var response: RESTPaginatorResponse<Int>?
                afterEach {
                    response = nil
                }
                context("is Decodable when") {
                    beforeEach {
                        response = try? decode(string: JSONSamples.Valide.structureWithArrayOfIntResults.rawValue)
                    }
                    it("structure is valide") {
                        expect(response).toNot(beNil())
                    }
                    it("input results type is the same as serialized") {
                        expect(response?.results).to(equal([1, 2, 3]))
                    }
                }
            }
        }
    }
}

