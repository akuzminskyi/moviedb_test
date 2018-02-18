//
//  NetworkServicing.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 14/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol NetworkServicing {
    @discardableResult func execute(request: NetworkRequesting,
                                    completionBlock: @escaping (Result<Data>, NetworkRequesting) -> ()) -> NetworkOperationCancalable
}
