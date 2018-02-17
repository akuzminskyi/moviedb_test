//
//  RESTPaginatorLoaderError.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

enum RESTPaginatorLoaderError: Error {
    case unexpected
    case requestAlreadyInProgress
}
