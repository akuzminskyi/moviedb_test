//
//  ApiProvider+Shared.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension ApiProvider {
    static let shared: ApiProviderable = {
        let apiKey: String! = nil
        precondition(apiKey != nil, "The apikey shouldn't be nil. Please copy the apikey to the property")

        // TODO: - move apiurl to xconfig
        return ApiProvider(apiDomain: URL(string: "http://api.themoviedb.org/")!,
                           imageDomain: URL(string: "http://image.tmdb.org/t/p/")!,
                           apiKey: ("api_key", apiKey),
                           apiVersion: .v3)
    }()
}
