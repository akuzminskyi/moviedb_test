//
//  SearchViewModel+SearchViewModeling.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension SearchViewModel: SearchViewModeling {
    func loadItems(at indexPaths: [IndexPath]) {
        let emptyIndexPaths = indexPaths.filter { (indexPath) -> Bool in
            guard case ItemModelState.empty = itemAt(indexPath: indexPath) else {
                return false
            }
            return true
        }
        guard !emptyIndexPaths.isEmpty else {
            return
        }

        let pagesToLoad = emptyIndexPaths.reduce(Set<Int>()) { (set, indexPath) -> Set<Int> in
            let page = indexPath.row / paginator.batchSize + 1
            var muttableSet = set
            muttableSet.insert(page)
            return muttableSet
        }

        print("Load pages: \(pagesToLoad)")
        pagesToLoad.forEach { (page) in
            do {
                try paginator.load(page: page)
            }
            catch let error {
                print("cought an error \(error)")
            }
        }
    }

    func clearResult() {
        paginator.baseURL = nil
        items.removeAll()
        itemsDidChange?()
    }
}
