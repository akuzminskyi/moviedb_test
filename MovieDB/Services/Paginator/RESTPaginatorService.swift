//
//  RESTPaginatorService.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

final class RESTPaginatorService {
    var baseURL: URL
    //TODO: - move magic number to ...
    var numberOfPages: UInt = 1
    var numberOfItems: UInt = 0
    let batchSize: UInt
    weak var delegate: RESTPaginatorDelegate?
    private let networkService: NetworkServicing

    init(configuration: RESTPaginatorServiceConfiguration) {
        baseURL = configuration.baseURL
        batchSize = configuration.batchSize
        networkService = configuration.networkService
        try? load(page: configuration.inializationPage, force: true)
    }

    private func load(page: UInt, force: Bool) throws {
        guard force || page <= numberOfPages else {
            throw RESTPaginatorError.OutOfRange.page
        }
    }
}

extension RESTPaginatorService: RESTPaginatorServicing {
    func load(page: UInt) throws {
        try load(page: page, force: false)
    }
}

extension RESTPaginatorService: RESTPaginatorItemLoadable {
    private func load(itemAtIndex index: UInt, force: Bool) throws {
        func pageForItem(at index: UInt) -> UInt {
            return index / batchSize + index % batchSize == 0 ? 1 : 0
        }

        guard index < numberOfItems else {
            throw RESTPaginatorError.OutOfRange.item
        }
        let page = pageForItem(at: index)
        try load(page: page, force: force)
    }

    func load(itemAtIndex index: UInt) throws {
        try load(itemAtIndex: index, force: false)
    }
}
