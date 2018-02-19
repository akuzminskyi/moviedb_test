//
//  RecentlySearchServicing.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RecentlySearchServicing {
    associatedtype SearchElement
    var dataStorage: DataStoraging { get }
    func saveSearch(element: SearchElement)

    /// The method returns recently the letest `count` elements
    ///
    /// - Parameter count: max number of items that should be
    /// - Returns: returns array of SearchElement
    func recentlyItems(withCount count: Int) -> [SearchElement]
}
