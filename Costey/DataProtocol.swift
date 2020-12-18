//
//  DataProtocol.swift
//  Costey
//
//  Created by Vadim Colcev on 12/17/20.
//

import Foundation

protocol DataManager {
    var arrLength: Int { get }
    
    func saveItem(item: Item)
    func getItem(at index: Int) -> Item
    func updateArr(with item: Item, at index: Int)
    func removeItem(at index: Int)
    func readFromPlistAndUpdateCurrentItems()
    func writeToPlist()
}
