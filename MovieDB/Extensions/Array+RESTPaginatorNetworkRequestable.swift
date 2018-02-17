//
//  Array+RESTPaginatorNetworkRequestable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension Array where Element == RESTPaginatorNetworkRequestable {
    func indexOf(item: RESTPaginatorNetworkRequestable) -> Int? {
        return index(where: { (element: RESTPaginatorNetworkRequestable) -> Bool in
            return element.url == item.url
        })
    }

    func contains(item: RESTPaginatorNetworkRequestable) -> Bool {
        return indexOf(item: item) == nil ? false : true
    }
}
