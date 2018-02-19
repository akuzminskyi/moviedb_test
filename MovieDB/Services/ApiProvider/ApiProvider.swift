//
//  ApiProvider.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

struct ApiProvider {
    var apiKey: (paramert: String, value: String)
    let apiDomain: URL
    let imageDomain: URL
    private var apiVersion: ApiVersion

    init(apiDomain: URL, imageDomain: URL, apiKey: (paramert: String, value: String), apiVersion: ApiVersion) {
        self.apiDomain = apiDomain
        self.imageDomain = imageDomain
        self.apiKey = apiKey
        self.apiVersion = apiVersion
    }

    fileprivate func apiDomainURLWith(version: ApiVersion) -> URL? {
        guard var component = URLComponents(url: apiDomain, resolvingAgainstBaseURL: true) else {
            return nil
        }
        component.path.append(version.path)
        component.queryItems = [URLQueryItem(name: apiKey.paramert, value: apiKey.value)]
        return component.url
    }
}

extension ApiProvider: ApiProviderable {
    /// The metod create an url that based on the current server settings(apikey, domain, path) for API service
    ///
    /// - Parameter path: relatedPath to APi, the `path` shouldn't be empty or returns nil
    /// - Returns: url with domain+apiversion+path
    func apiURL(withRelativePath path: String) -> URL? {
        guard !path.isEmpty else {
            return nil
        }
        guard let baseURL = apiDomainURLWith(version: apiVersion),
            var componentApiURL = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
                return nil
        }
        componentApiURL.path.append(path)
        return componentApiURL.url
    }

    /// The metod create an url that based on the current server settings(domain, path) for image domain
    ///
    /// - Parameters:
    ///   - path:  relatedPath to APi, the `path` shouldn't be empty or returns nil
    ///   - size: image size
    /// - Returns: Returns: url with domain+size+path
    func imageURL(withRelativePath path: String, withSize size: ImageSize) -> URL? {
        guard !path.isEmpty else {
            return nil
        }
        guard var componentImageURL = URLComponents(url: imageDomain, resolvingAgainstBaseURL: true) else {
            return nil
        }
        componentImageURL.path.append(size.path)
        componentImageURL.path.append(path)
        return componentImageURL.url
    }
}
