//
//  SearchViewController.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Reusable

class SearchViewController: UIViewController {
    private enum Segues: String {
        case SearchToRecentySegue
    }

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!

    weak var recentlyViewController: RecentlySearchedViewController? {
        didSet {
            recentlyViewController?.delegate = self
        }
    }
    @IBOutlet weak var recentlyResultContainerView: UIView!

    //TODO: - replace to protocol(the same problem with RecentlySearchService)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        switch identifier {
        case Segues.SearchToRecentySegue.rawValue:
            recentlyViewController = (segue.destination as! RecentlySearchedViewController)
            recentlyViewController?.delegate = self
        default:
            break
        }
    }
}
