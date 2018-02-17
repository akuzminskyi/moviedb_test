//
//  RESTPaginatorNetworkRequestable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RESTPaginatorNetworkRequestable: NetworkRequesting {
    var baseURL: URL { get }
    var page: UInt { get }
    var pageParameterName: String { get }
}
