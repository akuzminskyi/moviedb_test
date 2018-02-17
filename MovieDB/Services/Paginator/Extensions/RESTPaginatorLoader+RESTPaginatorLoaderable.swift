//
//  RESTPaginatorLoader+RESTPaginatorLoaderable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension RESTPaginatorLoader: RESTPaginatorLoaderable {
    func load<T: Decodable> (request: RESTPaginatorNetworkRequestable,
                             completionBlock: @escaping (Result<T>) -> ()) {
        load(force: false, request: request, completionBlock: completionBlock)
    }
}
