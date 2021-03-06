//
//  SearchViewModeling.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol SearchViewModeling: Searchable, SearchViewModelingDataSource, RecentlySearchable {
    var itemsDidChange: (() -> ())? { set get }
    var itemsDidChangeAt: (([IndexPath]) -> ())? { set get }
    func loadItems(at indexPaths: [IndexPath])
    func clearResult()
}

extension SearchViewModeling {
    func loadItem(at indexPath: IndexPath) {
        loadItems(at: [indexPath])
    }
}
