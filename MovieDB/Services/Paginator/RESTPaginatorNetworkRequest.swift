//
//  RESTPaginatorNetworkRequest.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

struct RESTPaginatorNetworkRequest {
    let baseURL: URL
    let page: UInt
    let pageParameterName: String

    fileprivate let _url: URL

    init?(baseURL: URL, page: UInt, pageParameterName: String) {
        func add(queryItem: URLQueryItem, to baseUrl: URL) -> URL? {
            guard var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
                return nil
            }
            if urlComponent.queryItems == nil {
                urlComponent.queryItems = [queryItem]
            } else {
                urlComponent.queryItems?.append(queryItem)
            }
            return urlComponent.url
        }

        self.baseURL = baseURL
        self.page = page
        self.pageParameterName = pageParameterName

        let pageQueryItem = URLQueryItem(name: pageParameterName, value: String(page))

        guard let generatedUrl = add(queryItem: pageQueryItem, to: self.baseURL) else {
            return nil
        }
        _url = generatedUrl
    }
}

extension RESTPaginatorNetworkRequest: RESTPaginatorNetworkRequestable {
    var url: URL {
        return _url
    }
}
