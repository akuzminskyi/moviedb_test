//
//  MovieViewModeling.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol MovieViewModeling: Decodable {
    var overview: String? { get }
    var posterRelativePath: String? { get }
    var releaseDateString: String? { get }
    var name: String? { get }
}

extension MovieViewModeling {
    func posterURLWith(domain: URL, for size: PosterSize) -> URL? {
        guard let relativePath = posterRelativePath, var component = URLComponents(url: domain, resolvingAgainstBaseURL: true) else {
            return nil
        }

        var additionalPath: String!
        switch size {
        case .w92:
            additionalPath = "w92/"
        case .w185:
            additionalPath = "w185/"
        case .w500:
            additionalPath = "w500/"
        case .w780:
            additionalPath = "w780/"
        }

        component.path.append(contentsOf: additionalPath)
        component.path.append(contentsOf: relativePath)
        return component.url
    }
}
