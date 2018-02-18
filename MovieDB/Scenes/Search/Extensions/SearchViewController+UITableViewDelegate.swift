//
//  SearchViewController+UITableViewDelegate.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import UIKit

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MovieCell,
            case ItemModelState.loaded(let model) = cell.viewModel,
            let url = model.thumbnailURL else {
                return
        }
        self.viewModel.imageDownloadService.downloadImage(from: url) { (image) in
            cell.posterImageView.image = image
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MovieCell,
            case ItemModelState.loaded(let model) = cell.viewModel,
            let url = model.thumbnailURL else {
                return
        }
        self.viewModel.imageDownloadService.cancelDownloadingImage(from: url)
    }
}
