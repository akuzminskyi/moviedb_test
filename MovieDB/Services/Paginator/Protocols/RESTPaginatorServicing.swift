//
//  RESTPaginatorServicing.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RESTPaginatorServicing: class, RESTPaginatorItemLoadable {
    var baseURL: URL? { set get }
    var numberOfPages: Int { get }
    var numberOfItems: Int { get }
    var batchSize: Int { get }

    var delegate: RESTPaginatorDelegate? { set get }
    var errorDelegate: RESTPaginatorErrorDelegate? { set get }

    func load(page: Int, force: Bool) throws
    func load(page: Int) throws
}

extension RESTPaginatorServicing {
    func loadFirstPage() throws {
        let firstPage = 1 // as init page
        try load(page: firstPage)
    }
}
