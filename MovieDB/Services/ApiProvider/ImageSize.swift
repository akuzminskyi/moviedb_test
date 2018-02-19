//
//  ImageSize.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

enum ImageSize: String {
    case w92 = "w92"
    case w185 = "w185"
    case w500 = "w500"
    case w780 = "w780"

    var path: String {
        return "\(self.rawValue)"
    }
}
