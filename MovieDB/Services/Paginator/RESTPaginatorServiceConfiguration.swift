//
//  RESTPaginatorServiceConfiguration.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

struct RESTPaginatorServiceConfiguration {
    let baseURL: URL
    let batchSize: UInt
    let networkService: NetworkServicing
    let inializationPage: UInt
}
