//
//  DataStoraging.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol DataStoraging {
    /// Block in which should be done `write` operations
    ///
    /// - Parameter transaction: the data will be immediately saved to a persistent storage after compliting the transaction
    func write(transaction: () -> ())

    func value<T>(forKey key: String) -> T?
    func save(value: Any?, for key: String)
}