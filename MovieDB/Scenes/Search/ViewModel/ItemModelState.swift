//
//  ItemState.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

enum ItemModelState<T> {
    case loaded(T)
    case empty
    case unknown
}
