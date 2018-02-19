//
//  RESTPaginatorDelegate.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RESTPaginatorDelegate: class {
    ///
    ///
    /// - Parameters:
    ///   - paginator: a paginator that handled loading
    ///   - request: a send request
    ///   - items: [Int: ItemType] where key is index of item and value is item that was loaded
    ///   - page: page that was loaded
    func paginator<ItemType>(paginator: RESTPaginatorServicing,
                             loaded request: URL,
                             with items: [Int: ItemType],
                             at page: Int)
    
    func paginator(paginator: RESTPaginatorServicing,
                   numberOfItemsDidChange numberOfItems: Int,
                   forRequest request: URL)
}

