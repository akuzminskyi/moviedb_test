//
//  RESTPaginatorServicing.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RESTPaginatorServicing {
    var baseURL: URL { get }
    var numberOfPages: UInt { get }
    var numberOfItems: UInt { get }

    var delegate: RESTPaginatorDelegate? { set get }
    func load(page: UInt) throws
}
