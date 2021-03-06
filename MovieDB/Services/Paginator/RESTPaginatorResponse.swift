//
//  RESTPaginatorResponse.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

struct RESTPaginatorResponse<T: Decodable>: RESTPaginatorResponsable {
    typealias ResultItemType = T

    var page: Int
    var numberOfResults: Int
    var numberOfPages: Int
    var results: [ResultItemType]
}
