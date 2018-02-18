//
//  ImageDownloadServicing.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import UIKit

protocol ImageDownloadServicing {
    func cachedImage(from url: URL) -> UIImage?

    func downloadImage(from url: URL, completionBlock: @escaping (UIImage?) -> ())
    func cancelDownloadingImage(from url: URL)
}
