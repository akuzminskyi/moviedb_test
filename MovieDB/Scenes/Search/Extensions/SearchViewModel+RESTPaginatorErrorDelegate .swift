//
//  SearchViewModel+RESTPaginatorErrorDelegate .swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 18/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

extension SearchViewModel: RESTPaginatorErrorDelegate {
    func paginator(paginator: RESTPaginatorServicing, caught error: Error) {
        print("Detected an error:\(error)")
    }
}
