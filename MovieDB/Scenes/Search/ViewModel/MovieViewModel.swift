//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

struct MovieViewModel {
    let overview: String?
    let name: String?
    let posterUrl: URL?
    let releaseDate: Date?
    var dateFormater: DateFormatter
}
