//
//  SearchViewModel+RESTPaginatorDelegate.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension SearchViewModel: RESTPaginatorDelegate {
    func paginator<Item>(paginator: RESTPaginatorServicing, loaded items: [Int: Item], at page: Int) {
        items.forEach { (arg) in
            let (index, item) = arg
            self.items[index] = ItemModelState.loaded(item) as! ItemModelState
        }

        let indexPaths = items.keys.map { (index) in
            IndexPath(row: index, section: 0)
        }

        DispatchQueue.main.async { [weak self] in
            self?.itemsDidChangeAt?(indexPaths)
        }
    }

    func paginator(paginator: RESTPaginatorServicing, numberOfItemsDidChange numberOfItems: Int) {
        items = [ItemModelState<Item>](repeatElement(.empty,
                                                     count: numberOfItems))
        DispatchQueue.main.async { [weak self] in
            self?.itemsDidChange?()
        }
    }
}
