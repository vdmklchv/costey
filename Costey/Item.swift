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
    
    enum Period: String, CaseIterable, Codable {
        case day
        case month
        case year
    }
    
    func getCount(for period: Period) -> Double {
        let currentDate = Date()
        switch period {
        case .day:
            return  currentDate.timeIntervalSince(startDate)/86400
        case .month:
            return currentDate.timeIntervalSince(startDate)/2592000
        case .year:
            return currentDate.timeIntervalSince(startDate)/31104000
        }
    }
    
    func calculatePrice(for period: Period) -> Double {
        let count = getCount(for: period)
        return price / max(1.0, floor(count))
    }
}



