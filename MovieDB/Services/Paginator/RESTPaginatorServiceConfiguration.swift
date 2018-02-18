//
//  RESTPaginatorServiceConfiguration.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

struct RESTPaginatorServiceConfiguration {
    let loader: RESTPaginatorLoaderable
    let batchSize: UInt
    let pageParametrName: String
    let inializationPage: UInt
}
