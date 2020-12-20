//
//  DefaultDataManager.swift
//  Costey
//
//  Created by Vadim Colcev on 12/17/20.
//

import Foundation

class DefaultDataManager: DataManager, UpdateUIProtocol {    
    
    init() {
        readFromPlistAndUpdateCurrentItems()
    }
    
    var onDataRefresh: (() -> Void)?
        
    private var currentItems: [Item] = [] {
        didSet {
            writeToPlist()
            currentItems.sort(by: <)
            onDataRefresh?()
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
    
    func updatePeriod(to period: Item.Period) {
        for i in 0..<currentItems.count {
            currentItems[i].period = period
        }
    }
    
}
