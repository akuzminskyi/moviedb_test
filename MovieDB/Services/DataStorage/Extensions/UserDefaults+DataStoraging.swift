//
//  UserDefaults+DataStoraging.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension UserDefaults: DataStoraging {
    /// Block in which should be done `write` operations
    ///
    /// - Parameter transaction: the data will be immediately saved to a persistent storage after compliting the transaction
    func write(transaction: () -> ()) {
        transaction()
        synchronize()
    }

    func value<T>(forKey key: String) -> T? {
        return value(forKey: key) as? T
    }

    func save(value: Any?, for key: String) {
        self.set(value, forKey: key)
    }
}
