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

    lazy var viewModel: SearchViewModel<MovieViewModel>! = {
        let networkProvider = URLSession.shared
        let decoder = JSONDecoder()
        let networkService = NetworkService(networkProvider: networkProvider)
        let loader = RESTPaginatorLoader(networkService: networkService, decoder: decoder)
        let configuration = RESTPaginatorServiceConfiguration(baseURL: URL(string: "http://api.themoviedb.org/3/search/movie")!,
                                                              loader: loader,
                                                              batchSize: 20,
                                                              pageParametrName: "page",
                                                              inializationPage: 1)
        let paginator = RESTPaginatorService<MovieViewModel>(configuration: configuration)
        return SearchViewModel<MovieViewModel>(paginator: paginator)
    }()

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
