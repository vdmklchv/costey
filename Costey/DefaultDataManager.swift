//
//  DefaultDataManager.swift
//  Costey
//
//  Created by Vadim Colcev on 12/17/20.
//

import Foundation

class DefaultDataManager: DataManager {
    internal var currentItems: [Item] = [] {
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
    
    func updateArr(with item: Item, at index: Int) {
        currentItems[index] = item
    }
    
    func removeItem(at index: Int) {
        currentItems.remove(at: index)
    }
    
    func readFromPlistAndUpdateCurrentItems() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Items.plist")
           
            do {
                let plistData = try Data(contentsOf: path)
                let jsonDecoder = JSONDecoder()
                let array = try jsonDecoder.decode([Item].self, from: plistData)
                currentItems = array
                } catch {
                    print("Error while updating current items.")
            }
    }
    
    func writeToPlist() {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Items.plist")
            do {
                let jsonEncoder = JSONEncoder()
                let receivedData = try jsonEncoder.encode(currentItems)
                try receivedData.write(to: path)
            } catch {
                print("Error writing to plist")
            }
    }
    
}
