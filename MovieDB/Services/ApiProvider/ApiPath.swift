//
//  ApiPath.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

enum ApiPath: String {
    case searchMovie = "/search/movie"

    var path: String {
        return "\(self.rawValue)"
    }
}
