//
//  RESTPaginatorService+RESTPaginatorItemLoadable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension RESTPaginatorService: RESTPaginatorItemLoadable {
    func loadItem(at index: Int, force: Bool) throws {
        func pageForItem(at index: Int) -> Int {
            return index / batchSize + index % batchSize == 0 ? 1 : 0
        }

        guard index < numberOfItems else {
            throw RESTPaginatorError.itemOutOfRange
        }
        let page = pageForItem(at: index)
        try load(page: page, force: force)
    }

    func loadItem(at index: Int) throws {
        try loadItem(at: index, force: false)
    }
}
