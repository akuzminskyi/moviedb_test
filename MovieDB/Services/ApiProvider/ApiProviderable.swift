//
//  ApiProviderable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol ApiProviderable {
    var apiDomain: URL { get }
    var apiKey: (paramert: String, value: String) { get set }

    func apiURL(withRelativePath path: String) -> URL?
    func imageURL(withRelativePath path: String, withSize size: ImageSize) -> URL?
}

extension ApiProviderable {
    func apiURL(withAPI type: ApiPath) -> URL? {
        return apiURL(withRelativePath: type.path)
    }
}
