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
    var thumbnailURL: URL? { get }
    var name: String? { get }
}

extension MovieViewModeling {
    var thumbnailURL: URL? {
        guard let imageRelatedPath = posterRelativePath else {
            return nil
        }
        return ApiProvider.shared.imageURL(withRelativePath: imageRelatedPath, withSize: .w185)
    }
}
