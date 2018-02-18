//
//  MovieViewModel+MovieViewModeling.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension MovieViewModel: MovieViewModeling {
    var releaseDateString: String? {
        guard let date = releaseDate else {
            return nil
        }
        return dateFormater.string(from: date)
    }
}
