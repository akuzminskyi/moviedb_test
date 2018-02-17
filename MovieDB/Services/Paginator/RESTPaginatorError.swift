//
//  RESTPaginatorError.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

enum RESTPaginatorError: Error {
    enum OutOfRange: Error {
        case page
        case item
    }
}
