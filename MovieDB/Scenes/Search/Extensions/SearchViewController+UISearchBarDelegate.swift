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
        searchBar.endEditing(true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        recentlyResultContainerView.isHidden = false
        recentlyViewController?.viewModel = viewModel.recentlyResults()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        recentlyResultContainerView.isHidden = true
        recentlyViewController?.viewModel = []
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        viewModel.clearResult()
    }
}
