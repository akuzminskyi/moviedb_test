//
//  Result+Equatable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 14/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension Result where Value: Equatable {
    static func == (lhs: Result<Value>, rhs: Result<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.success(let lval), .success(let rval)) where lval == rval:
            return true
        case (.failure(let lval), .failure(let rval)) where lval.localizedDescription == rval.localizedDescription:
            return true
        default:
            return false
        }
    }
}
