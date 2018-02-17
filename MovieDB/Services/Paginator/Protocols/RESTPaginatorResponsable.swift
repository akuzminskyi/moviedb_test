//
//  RESTPaginatorResponsable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RESTPaginatorResponsable: Decodable {
    associatedtype ResultItemType: Decodable

    var page: UInt { get }
    var numberOfResults: UInt { get }
    var numberOfPages: UInt { get }
    var results: [ResultItemType] { get }
}
