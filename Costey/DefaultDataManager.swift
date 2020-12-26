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
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Items.plist")
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: fileURL.path) else { return }
        do {
            let plistData = try Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            let array = try jsonDecoder.decode([Item].self, from: plistData)
            currentItems = array
            sortItems(per: .day)
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
    
    func sortItems(per period: Item.Period) {
        var sortedItems: [Item] = []
        if period == .day {
            sortedItems = currentItems.sorted(by: { $0.calculatePrice(for: .day) < $1.calculatePrice(for: .day) })
        } else if period == .month {
            sortedItems = currentItems.sorted(by: { $0.calculatePrice(for: .month) < $1.calculatePrice(for: .month) })
        } else if period == .year {
            sortedItems = currentItems.sorted(by: { $0.calculatePrice(for: .day) < $1.calculatePrice(for: .day) })
        }
        currentItems = sortedItems
    }
}
