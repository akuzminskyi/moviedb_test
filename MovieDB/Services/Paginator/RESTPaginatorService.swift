//
//  RESTPaginatorService.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

final class RESTPaginatorService<ItemType: Decodable> {
    //TODO: - move magic numbers to ...
    var numberOfPages: UInt = 1
    var numberOfItems: UInt = 0 {
        didSet {
            guard oldValue != numberOfItems else {
                return
            }
            self.delegate?.paginator(paginator: self, numberOfItemsDidChange: numberOfItems)
        }
    }

    let batchSize: UInt

    weak var delegate: RESTPaginatorDelegate?
    weak var errorDelegate: RESTPaginatorErrorDelegate?

    private let pageParametrName: String
    private let loader: RESTPaginatorLoaderable

    init(configuration: RESTPaginatorServiceConfiguration) {
        batchSize = configuration.batchSize
        pageParametrName = configuration.pageParametrName
        loader = configuration.loader
        try? load(page: configuration.inializationPage, force: true) // ignore case when the initial page is out of range,
    }

    //MARK: - private methods

    private func generateRequestFor(page: UInt) -> RESTPaginatorNetworkRequestable? {
        return RESTPaginatorNetworkRequest(baseURL: loader.baseURL,
                                           page: page,
                                           pageParameterName: pageParametrName)
    }

    private func load(page: UInt, force: Bool) throws {
        guard force || page <= numberOfPages else {
            throw RESTPaginatorError.pageOutOfRange
        }
        guard let request = generateRequestFor(page: page) else {
            throw RESTPaginatorError.creatingRequest
        }
        loader.load(request: request) { [weak self] (responseResult: Result<RESTPaginatorResponse<ItemType>>) in
            guard let `self` = self else {
                return
            }

            switch responseResult {
            case .failure(let error):
                self.errorDelegate?.paginator(paginator: self, caught: error)
            case .success(let response):
                self.numberOfPages = response.numberOfPages
                self.numberOfItems = response.numberOfResults
                self.delegate?.paginator(paginator: self, loaded: response.results, at: page)
            }
        }
    }
}

extension RESTPaginatorService: RESTPaginatorServicing {
    var baseURL: URL {
        return loader.baseURL
    }

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
            throw RESTPaginatorError.itemOutOfRange
        }
        let page = pageForItem(at: index)
        try load(page: page, force: force)
    }

    func load(itemAtIndex index: UInt) throws {
        try load(itemAtIndex: index, force: false)
    }
}
