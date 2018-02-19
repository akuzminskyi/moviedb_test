//
//  RecentlySearchedViewControllerDelegate.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

protocol RecentlySearchedViewControllerDelegate: class {
    func recentlySearched(viewController: RecentlySearchedViewController,
                          didSelectItemAt index: Int)
}
