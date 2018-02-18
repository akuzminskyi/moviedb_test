//
//  RESTPaginatorDelegate.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RESTPaginatorDelegate: class {
    func paginator<ItemType>(paginator: RESTPaginatorServicing, loaded items: [ItemType], at page: Int)
    func paginator(paginator: RESTPaginatorServicing, numberOfItemsDidChange numberOfItems: Int)
}
