//
//  Decoderable.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 17/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol Decoderable {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}
