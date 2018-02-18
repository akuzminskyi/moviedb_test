//
//  MovieCell.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Reusable

class MovieCell: UITableViewCell {
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDataLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!

    func configCell(with viewModel: ItemModelState<MovieViewModel>) {
        switch viewModel {
        case .loaded(let model):
            posterImageView.image = nil
            titleLabel.text = model.name
            releaseDataLabel.text = model.releaseDateString
            overviewLabel.text = model.overview
        default:
            posterImageView.image = nil
            titleLabel.text = nil
            releaseDataLabel.text = nil
            overviewLabel.text = nil
        }
    }
}
