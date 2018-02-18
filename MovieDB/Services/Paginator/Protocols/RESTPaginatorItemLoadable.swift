//
//  RESTPaginatorItemLoadable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RESTPaginatorItemLoadable {
    func load(itemAtIndex index: Int) throws
}
