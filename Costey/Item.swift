//
//  Period.swift
//  Costey
//
//  Created by Vadim Colcev on 12/13/20.
//

import Foundation


struct Item: Codable { // needs Codable to be able to serialize it to json
    
    var name: String
    
    var price: Double
    
    var startDate: Date
    
    enum Period: String, CaseIterable { // Case iterable is used to be able to iterate through provided cases. Cases can be used as strings
        case day
        case month
        case year
    }
    
    // method to calculate period passed for instance item. Should be moved to ItemCell?
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



