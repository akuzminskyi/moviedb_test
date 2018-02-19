//
//  MovieCell.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Reusable

class MovieCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDataLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!

    var viewModel: ItemModelState<MovieViewModel> = .empty {
        didSet {
            updateUI(with: viewModel)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = .empty
    }

    private func updateUI(with viewModel: ItemModelState<MovieViewModel>) {
        switch viewModel {
        case .loaded(let model):
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
