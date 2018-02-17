//
//  RESTPaginatorLoader.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

final class RESTPaginatorLoader {
    let baseURL: URL
    let networkService: NetworkServicing
    let decoder: Decoderable

    init(baseURL: URL, networkService: NetworkServicing, decoder: Decoderable) {
        self.baseURL = baseURL
        self.networkService = networkService
        self.decoder = decoder
    }

    fileprivate func decode<T: Decodable>(data: Data) throws -> T {
        return try self.decoder.decode(T.self, from: data)
    }
}

extension RESTPaginatorLoader: RESTPaginatorLoaderable {
    func load<T: Decodable> (request: RESTPaginatorNetworkRequestable,
                             completionBlock: @escaping (Result<T>) -> ()) {
        networkService.execute(request: request) { [weak self] (result, request) in
            guard let `self` = self else {
                completionBlock(Result.failure(RESTPaginatorLoaderError.unexpected))
                return
            }

            guard case Result.success(let data) = result else {
                if case Result.failure(let error) = result {
                    completionBlock(Result.failure(error))
                } else {
                    completionBlock(Result.failure(RESTPaginatorLoaderError.unexpected))
                }
                return
            }

            do {
                let response: T = try self.decode(data: data)
                completionBlock(Result.success(response))
            }
            catch let error {
                completionBlock(Result.failure(error))
            }
        }
    }
}
