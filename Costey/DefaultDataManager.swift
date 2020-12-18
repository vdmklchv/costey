//
//  DefaultDataManager.swift
//  Costey
//
//  Created by Vadim Colcev on 12/17/20.
//

import Foundation

class DefaultDataManager: DataManager {
    
    var delegate: MainScreenController?

    private var currentItems: [Item] = [] {
        didSet {
            writeToPlist()
            delegate?.updateUI()
        }
    }
    
    var arrLength: Int {
        currentItems.count
    }
    
    func saveItem(item: Item) {
        currentItems.append(item)
    }
    
    func getItem(at index: Int) -> Item {
        return currentItems[index]
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
