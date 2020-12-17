//
//  DataProtocol.swift
//  Costey
//
//  Created by Vadim Colcev on 12/17/20.
//

import Foundation

protocol DataManager {
    var arrLength: Int { get set }
    
    func saveItem(item: Item)
    func getItem(at index: Int) -> Item
}
