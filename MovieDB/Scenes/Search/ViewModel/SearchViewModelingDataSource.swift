//
//  SearchViewModelingDataSource.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol SearchViewModelingDataSource {
    associatedtype Item
 
    var numberOfSection: Int { get }
    func numberOfItems(in section: Int) -> Int
    func itemAt(indexPath: IndexPath) -> ItemModelState<Item>
}
