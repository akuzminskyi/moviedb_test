//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

final class SearchViewModel<T> {
    let imageDownloadService: ImageDownloadServicing
    typealias Item = T

    var itemsDidChange: (() -> ())?
    var itemsDidChangeAt: (([IndexPath]) -> ())?

    var items = [ItemModelState<Item>]()
    let paginator: RESTPaginatorServicing

    init(paginator: RESTPaginatorServicing, imageDownloadService: ImageDownloadServicing) {
        self.paginator = paginator
        self.imageDownloadService = imageDownloadService

        self.paginator.delegate = self
    }

    func newItemsHaveFetched(forRequest url: URL) {
        DispatchQueue.main.async { [weak self] in
            self?.itemsDidChange?()
        }
        print()
    }

    func loadData(withSearchTerm searchTerm: String?) {
        func searchQueryItem(withValue value: String?) -> URLQueryItem {
            return URLQueryItem(name: "query", value: value)
        }

        func searchMoviewURL(withTerm term: String?) -> URL? {
            guard let url = ApiProvider.shared.apiURL(withAPI: .searchMovie),
                let term = term?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                var component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    return nil
            }
            let queryItem = searchQueryItem(withValue: term)
            component.queryItems?.append(queryItem)

            return component.url
        }

        do {
            guard let url = searchMoviewURL(withTerm: searchTerm) else {
                return
            }

            paginator.baseURL = url
            try paginator.loadFirstPage()
        } catch let error {
            print("cought an error: \(error)")
        }
    }
}
