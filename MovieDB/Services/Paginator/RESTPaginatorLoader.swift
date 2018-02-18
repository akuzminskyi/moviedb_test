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

    //TODO: - replace Array to Set. A problem with Hashable
    private var requestsInProgress = [RESTPaginatorNetworkRequestable]()

    init(baseURL: URL, networkService: NetworkServicing, decoder: Decoderable) {
        self.baseURL = baseURL
        self.networkService = networkService
        self.decoder = decoder
    }

    //MARK: - private methods

    private func decode<T: Decodable>(data: Data) throws -> T {
        return try self.decoder.decode(T.self, from: data)
    }

    private func execute<T: Decodable>(request: RESTPaginatorNetworkRequestable,
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

    //MARK: - interal methods

    /// The method load the request and returns result in `completionBlock`.
    /// The method track the requests that's inprogress and return `Result.failure(RESTPaginatorLoaderError.requestAlreadyInProgress)`
    /// if that same request going to load while executing request.
    ///
    /// - Parameters:
    ///   - force: if `true` the loader excecute the request even if the same request is executing,
    ///            if `false` the loader verify the request in progress and
    ///               if exist the method complete with `Result.failure(RESTPaginatorLoaderError.requestAlreadyInProgress)`
    /// Result.failure(RESTPaginatorLoaderError.requestAlreadyInProgress
    ///   - request: a reqeust that should be executed
    ///   - completionBlock: returns the result of executing request,
    ///                      if loading complete with error it returns `Result.error<T>` owerwise `Result.success<T>`
    func load<T: Decodable>(force: Bool,
                            request: RESTPaginatorNetworkRequestable,
                            completionBlock: @escaping (Result<T>) -> ()) {
        guard force || !requestsInProgress.contains(item: request) else {
            return completionBlock(Result.failure(RESTPaginatorLoaderError.requestAlreadyInProgress))
        }
        requestsInProgress.append(request)

        execute(request: request) { [weak self] (result: Result<T>) in
            let requestIndex = self?.requestsInProgress.indexOf(item: request)

            if let indexToRemove = requestIndex {
                self?.requestsInProgress.remove(at: indexToRemove)
            }

            completionBlock(result)
        }
    }
}
