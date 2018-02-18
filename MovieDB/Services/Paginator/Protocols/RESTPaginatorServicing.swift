//
//  RESTPaginatorServicing.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RESTPaginatorServicing: class {
    var baseURL: URL { get set }
    var numberOfPages: Int { get }
    var numberOfItems: Int { get }

    var delegate: RESTPaginatorDelegate? { set get }
    var errorDelegate: RESTPaginatorErrorDelegate? { set get }

    func load(page: Int) throws
}
