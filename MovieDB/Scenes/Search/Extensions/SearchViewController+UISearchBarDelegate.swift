//
//  SearchViewController+UISearchBarDelegate.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(term: searchBar.text)
    }

    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        //TODO: - a magic number
        let lastSearchedItem = viewModel.recentlyResults()
        print("Recently search item: \(lastSearchedItem)")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.clearResult()
    }
}
