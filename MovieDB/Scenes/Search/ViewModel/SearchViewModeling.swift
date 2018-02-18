//
//  SearchViewModeling.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol SearchViewModeling {
    func search(term: String)
    func loadItem(at indexPaths: [IndexPath])
    var numberOfSection: Int { get }

    func itemAt(index: IndexPath) -> MovieViewModeling
    func numberOfItems(in seaction: Int) -> Int
}

extension SearchViewModeling {
    func loadItem(at indexPath: IndexPath) {
        loadItem(at: [indexPath])
    }
}
