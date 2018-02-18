//
//  ImageDownloadService.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import UIKit

class ImageDownloadService {
    private let cache: NSCache<NSURL, UIImage>
    private let networkService: NetworkServicing
    private var downloadingList = [URL: NetworkOperationCancalable]()

    deinit {
        cache.removeAllObjects()
        downloadingList.removeAll()
    }

    init(cache: NSCache<NSURL, UIImage>, networkService: NetworkServicing) {
        self.cache = cache
        self.networkService = networkService
    }
}

extension ImageDownloadService: ImageDownloadServicing {
    func cachedImage(from url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }

    func downloadImage(from url: URL, completionBlock: @escaping (UIImage?) -> ()) {
        if let image = cachedImage(from: url) {
            completionBlock(image)
            return // unexpected return
        }

        let task = networkService.execute(request: url) { [weak self] (result, _) in
            guard case .success(let data) = result, let image = UIImage(data: data) else {
                completionBlock(nil)
                self?.downloadingList.removeValue(forKey: url)
                return
            }
            self?.cache.setObject(image, forKey: url as NSURL)
            completionBlock(image)
            self?.downloadingList.removeValue(forKey: url)
        }
        downloadingList[url] = task
    }

    func cancelDownloadingImage(from url: URL) {
        downloadingList[url]?.cancel()
        downloadingList.removeValue(forKey: url)
    }
}
