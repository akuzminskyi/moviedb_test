//
//  RESTPaginatorDelegate.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 16/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RESTPaginatorDelegate: class {
    func loaded<Element: Decodable>(items: [Element], at page: UInt)
}
