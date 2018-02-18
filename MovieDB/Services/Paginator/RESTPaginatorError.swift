//
//  RESTPaginatorError.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

enum RESTPaginatorError: Error {
    case pageOutOfRange
    case itemOutOfRange
    case unexpected
    case creatingRequest
}
