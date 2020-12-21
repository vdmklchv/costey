//
//  Period.swift
//  Costey
//
//  Created by Vadim Colcev on 12/13/20.
//

import Foundation


struct Item: Codable, Comparable { // needs Codable to be able to serialize it to json
    
    static func < (lhs: Item, rhs: Item) -> Bool { 
        lhs.pricePerPeriod < rhs.pricePerPeriod
    }
    
    var name: String
    
    var price: Double
    
    var startDate: Date
    
    var period: Period = .day
    
    var passedPeriod: Int {
        return calculatePeriod(for: period)
    }
    
    var pricePerPeriod: Double {
        if passedPeriod == 0 {
            return price
        } else {
            return price / Double(passedPeriod)
        }
    }
    
    enum Period: String, CaseIterable, Codable {
        case day
        case month
        case year
    }
    
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



