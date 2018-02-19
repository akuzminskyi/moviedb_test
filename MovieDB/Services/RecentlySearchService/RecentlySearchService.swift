//
//  RecentlySearchService.swift
//  MovieDB
//
//  Created by Andrii Kuzminskyi on 19/02/2018.
//  Copyright © 2018 A.Kuzminskyi. All rights reserved.
//

import Foundation

struct RecentlySearchService<T>: RecentlySearchServicing {
    typealias SearchElement = T
    let dataStorage: DataStoraging

    private static var dataStorageRecentlyKey: String{
        return "DataStorageRecentlyKey"
    }
    
    private func storedItems() -> [SearchElement] {
        if let items: [SearchElement] = dataStorage.value(forKey: RecentlySearchService.dataStorageRecentlyKey) {
            return items
        } else {
            return [SearchElement]()
        }
    }

    func saveSearch(element: SearchElement) {
        var storedItems = self.storedItems()
        storedItems.insert(element, at: 0)
        dataStorage.write {
            dataStorage.save(value: storedItems, for: RecentlySearchService.dataStorageRecentlyKey)
        }
    }

    func recentlyItems(withCount count: Int) -> [SearchElement] {
        let storedItems = self.storedItems()
        let cutIndex = min(count, storedItems.count)
        return storedItems[0..<cutIndex].map { $0 }
    }
}
