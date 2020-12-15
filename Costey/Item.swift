//
//  Period.swift
//  Costey
//
//  Created by Vadim Colcev on 12/13/20.
//

import Foundation


struct Item {
    
    var name: String
    
    var price: Double
    
    var startDate: Date
    
    enum Period: String, CaseIterable {
        case day
        case month
        case year
    }
    
    
    func calculatePeriod(for period: Period) -> Double {
        let currentDate = Date()
        switch period {
        case .day:
            return round(currentDate.timeIntervalSince(startDate)/86400)
        case .month:
            return round(currentDate.timeIntervalSince(startDate)/2592000)
        case .year:
            return round(currentDate.timeIntervalSince(startDate)/31104000)
        }
    }
    
    
}



