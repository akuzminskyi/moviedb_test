//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

final class SearchViewModel<T> {
    typealias Item = T

    var itemsDidChange: (() -> ())?
    var itemsDidChangeAt: (([IndexPath]) -> ())?
    
    var items = [ItemModelState<Item>]()
    let paginator: RESTPaginatorServicing

    init(paginator: RESTPaginatorServicing) {
        self.paginator = paginator
        self.paginator.delegate = self
    }
}
