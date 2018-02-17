//
//  RESTPaginatorResponse.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

struct RESTPaginatorResponse<T>: RESTPaginatorResponsable {
    typealias ResultType = T
    
    var page: UInt
    var numberOfResults: UInt
    var numberOfPages: UInt
    var results: [ResultType]
}
