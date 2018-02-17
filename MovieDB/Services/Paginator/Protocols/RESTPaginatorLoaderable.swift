//
//  RESTPaginatorLoaderable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RESTPaginatorLoaderable {
    var baseURL: URL { get }
    var networkService: NetworkServicing { get }
    var decoder: Decoderable { get }
    func load<T: Decodable> (request: RESTPaginatorNetworkRequestable,
                             completionBlock: @escaping (Result<T>) -> ())
}
