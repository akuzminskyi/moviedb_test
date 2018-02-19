//
//  SearchViewModel+Searchable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension SearchViewModel: Searchable {
    private func searchQueryItem(withValue value: String?) -> URLQueryItem {
        return URLQueryItem(name: "query", value: value)
    }

    private func searchMoviewURL(withTerm term: String?) -> URL? {
        guard let url = ApiProvider.shared.apiURL(withAPI: .searchMovie),
            let term = term?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            var component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                return nil
        }
        let queryItem = searchQueryItem(withValue: term)
        component.queryItems?.append(queryItem)

        return component.url
    }

    func search(term: String?) {
        do {
            guard let url = searchMoviewURL(withTerm: term) else {
                return
            }

            paginator.baseURL = url
            try paginator.loadFirstPage()
        } catch let error {
            print("cought an error: \(error)")
        }
    }
}