//
//  NetworkProviding.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 14/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol NetworkProviding {
    func dataTasks(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> NetworkOperationable
}
