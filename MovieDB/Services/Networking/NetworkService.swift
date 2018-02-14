//
//  NetworkService.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 14/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

struct NetworkService {
    private let networkProvider: NetworkProviding

    init(networkProvider: NetworkProviding) {
        self.networkProvider = networkProvider
    }
}

extension NetworkService: NetworkServicing {
    func execute(request: NetworkRequesting, completionBlock: @escaping (Result<Data>) -> ()) -> NetworkOperationCancalable {
        let task = networkProvider.dataTasks(with: request.url) { (data, _, error) in
            guard let data = data else {
                let errorType = error ?? NetworkServiceError.unexpactedError
                DispatchQueue.main.async {
                    completionBlock(Result.failure(errorType))
                }
                return
            }

            DispatchQueue.main.async {
                completionBlock(Result.success(data))
            }
        }
        task.resume()

        return task
    }
}
