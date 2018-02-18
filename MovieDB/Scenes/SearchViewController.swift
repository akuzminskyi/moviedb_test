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

    var viewModel: SearchViewModel<MovieViewModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: MovieCell.self)
        viewModel.itemsDidChange = { [unowned self] in
            self.tableView.reloadData()
        }
        viewModel.itemsDidChangeAt = { [unowned self] (indexPaths) in
            self.tableView.reloadRows(at: indexPaths, with: .automatic)
        }
    }
}
