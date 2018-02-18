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
        return dateFormatter.string(from: date)
    }
}

extension MovieViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case overview
        case name = "title"
        case posterRelativePath = "poster_path"
        case releaseDate = "release_date"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        posterRelativePath = try container.decodeIfPresent(String.self, forKey: .posterRelativePath)
        dateFormatter = DateFormatter.yyyyMMdd

        if let stringDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            releaseDate = DateFormatter.yyyyMMdd.date(from: stringDate)
        } else {
            releaseDate = nil
        }
    }
}
