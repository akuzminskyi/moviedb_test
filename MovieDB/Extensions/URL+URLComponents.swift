//
//  URL+URLComponents.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension URL {
    func valueFor(queryItem key: String) -> String? {
        guard let component = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        return component.queryItems?.filter({ (query) -> Bool in
            query.name == key
        }).first?.value
    }
}
