//
//  RecentlySearchedViewController.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import UIKit

class RecentlySearchedViewController: UITableViewController {
    typealias RecentyItem = String
    weak var delegate: RecentlySearchedViewControllerDelegate?

    var viewModel = [String]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = viewModel[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.recentlySearched(viewController: self, didSelectItemAt: indexPath.row)
    }
}
