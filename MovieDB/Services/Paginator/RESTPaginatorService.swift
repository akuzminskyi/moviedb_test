//
//  RESTPaginatorService.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

final class RESTPaginatorService<ItemType: Decodable> {
    var baseURL: URL?

    //TODO: - move magic numbers to ...
    private(set) var numberOfPages: Int = 1
    private(set) var numberOfItems: Int = 0
    let batchSize: Int

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

    private func generateRequestFor(page: Int) -> RESTPaginatorNetworkRequestable? {
        guard let url = baseURL else {
            return nil
        }

        return RESTPaginatorNetworkRequest(baseURL: url,
                                           page: page,
                                           pageParameterName: pageParametrName)
    }
}

extension RESTPaginatorService: RESTPaginatorServicing {
    func load(page: Int) throws {
        try load(page: page, force: false)
    }

    func load(page: Int, force: Bool) throws {
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
                func compaund(result: [ItemType], atPage page: Int, withBatchSize batchSize: Int) -> [Int: ItemType] {
                    var compaundedResult = [Int: ItemType]()
                    let pageOffsetIndex = (page-1) * batchSize

                    for (index, item) in result.enumerated() {
                        let itemIndex = pageOffsetIndex + index
                        compaundedResult[itemIndex] = item
                    }
                    return compaundedResult
                }

                self.numberOfPages = response.numberOfPages
                if self.numberOfItems != response.numberOfResults {
                    self.numberOfItems = response.numberOfResults
                    self.delegate?.paginator(paginator: self,
                                             numberOfItemsDidChange: self.numberOfItems,
                                             forRequest: request.url)
                }

                let compaundedResult = compaund(result: response.results,
                                                atPage: page,
                                                withBatchSize: self.batchSize)

                self.delegate?.paginator(paginator: self,
                                         loaded: request.url,
                                         with: compaundedResult,
                                         at: page)
            }
        }
    }
}
