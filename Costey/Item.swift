//
//  Period.swift
//  Costey
//
//  Created by Vadim Colcev on 12/13/20.
//

import Foundation


struct Item: Codable, Comparable { // needs Codable to be able to serialize it to json
    
    static func < (lhs: Item, rhs: Item) -> Bool { // ДОБАВИЛ РЕАЛИЗАЦИЮ СРАВНЕНИЯ
        lhs.pricePerPeriod < rhs.pricePerPeriod
    }
    
    var name: String
    
    var price: Double
    
    var startDate: Date
    
    var period: Period
    
    var passedPeriod: Int {
        return calculatePeriod(for: period)
    }
    
    var pricePerPeriod: Double {
        if passedPeriod == 0 { // prevent app from crashing because of zero division
            return price
        } else {
            return price / Double(passedPeriod)
        }
    }
    
    enum Period: String, CaseIterable { // Case iterable is used to be able to iterate through provided cases. Cases can be used as strings
        case day
        case month
        case year
    }
    
    // method to calculate period passed for instance item.
    func calculatePeriod(for period: Period) -> Int {
        let currentDate = Date()
        switch period {
        case .day:
            return Int(currentDate.timeIntervalSince(startDate)/86400)
        case .month:
            return Int(currentDate.timeIntervalSince(startDate)/2592000)
        case .year:
            return Int(currentDate.timeIntervalSince(startDate)/31104000)
        }
    }
}



