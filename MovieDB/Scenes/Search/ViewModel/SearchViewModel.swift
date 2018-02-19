//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

final class SearchViewModel<T> {
    typealias Item = T

    var itemsDidChange: (() -> ())?
    var itemsDidChangeAt: (([IndexPath]) -> ())?

    var items = [ItemModelState<Item>]()
    let paginator: RESTPaginatorServicing
    let imageDownloadService: ImageDownloadServicing
    //TODO: - must replace RecentlySearchService<String> to RecentlySearchServicing. A problem with associatedtype in the protocol
    let recentlySearch: RecentlySearchService<String>
    let numberOfRecentlyItems: Int

    init(paginator: RESTPaginatorServicing,
         imageDownloadService: ImageDownloadServicing,
         recentlySearch: RecentlySearchService<String>,
         recentlyDisplayedItems: Int
    ) {
        self.paginator = paginator
        self.imageDownloadService = imageDownloadService
        self.recentlySearch = recentlySearch
        self.numberOfRecentlyItems = recentlyDisplayedItems
        self.paginator.delegate = self
    }

    func newItemsHaveFetched(forRequest url: URL) {
        DispatchQueue.main.async { [weak self] in
            self?.itemsDidChange?()
        }
        // TODO: - magic string
        if let searchTerm = url.valueFor(queryItem: "query") {
            recentlySearch.saveSearch(element: searchTerm)
        }
    }

    func loadData(withSearchTerm searchTerm: String?) {
        func searchQueryItem(withValue value: String?) -> URLQueryItem {
            // TODO: - magic string
            return URLQueryItem(name: "query", value: value)
        }

        func searchMoviewURL(withTerm term: String?) -> URL? {
            guard let term = term?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                clearResult()
                return nil
            }
            guard let url = ApiProvider.shared.apiURL(withAPI: .searchMovie),
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
