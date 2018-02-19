//
//  ApiVersion.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

enum ApiVersion: String {
    case v3 = "3"
    case v4 = "4"

    var path: String {
        return "\(self.rawValue)"
    }
}
