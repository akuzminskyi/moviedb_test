//
//  MovieViewModeling.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol MovieViewModeling {
    var overview: String? { get }
    var releaseDateString: String? { get }
    var name: String? { get }
    var posterUrl: URL? { get }
}
