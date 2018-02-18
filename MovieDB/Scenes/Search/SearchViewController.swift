//
//  SearchViewController.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Reusable

class SearchViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: SearchViewModeling!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: MovieCell.self)
    }
}