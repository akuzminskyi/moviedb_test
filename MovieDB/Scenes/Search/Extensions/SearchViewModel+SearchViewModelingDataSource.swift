//
//  SearchViewModel+SearchViewModelingDataSource.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension SearchViewModel: SearchViewModelingDataSource {
    var numberOfSection: Int {
        //MAKR: - magic number ...
        return 1
    }

    func itemAt(indexPath: IndexPath) -> ItemModelState<Item> {
        guard indexPath.section < numberOfSection else {
            return .unknown
        }
        return items[indexPath.row]

    }

    func numberOfItems(in section: Int) -> Int {
        guard section < numberOfSection else {
            return NSNotFound
        }
        return items.count
    }
}
