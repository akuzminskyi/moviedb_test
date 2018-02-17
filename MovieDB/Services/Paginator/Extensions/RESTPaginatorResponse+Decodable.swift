//
//  RESTPaginatorResponse+Decodable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension RESTPaginatorResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        page = try container.decode(UInt.self, forKey: .page)
        numberOfResults = try container.decode(UInt.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(UInt.self, forKey: .numberOfPages)
        results = try container.decode([ResultItemType].self, forKey: .results)
    }
}
