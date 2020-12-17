//
//  DefaultDataManager.swift
//  Costey
//
//  Created by Vadim Colcev on 12/17/20.
//

import Foundation

class DefaultDataManager: DataManager {
    var currentItems: [Item] = [] {
        didSet {
            setArrLength()
        }
    }
    
    var arrLength: Int = 0
    
    func saveItem(item: Item) {
        currentItems.append(item)
    }
    
    func getItem(at index: Int) -> Item {
        return currentItems[index]
    }
    
    func setArrLength() {
        arrLength = currentItems.count
    }
    
}
