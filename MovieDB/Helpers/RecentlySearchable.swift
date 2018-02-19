//
//  RecentlySearchable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RecentlySearchable {
    associatedtype SearchElement
    //TODO: - must replace RecentlySearchService<String> to RecentlySearchServicing. A problem with associatedtype in the protocol
    var recentlySearch: RecentlySearchService<SearchElement> { get }
    var numberOfRecentlyItems: Int { get }
}

extension RecentlySearchable {
    func recentlyResults() -> [SearchElement] {
        return recentlySearch.recentlyItems(withCount: numberOfRecentlyItems)
    }
}
