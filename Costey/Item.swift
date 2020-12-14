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
    
    enum Period {
        case day, month, year
    }
    
    
    func calculatePeriod(for period: Period) -> Double {
        switch period {
        case .day:
            print(startDate.timeIntervalSinceNow)
            return startDate.timeIntervalSinceNow
        case .month:
            return startDate.timeIntervalSinceNow
        case .year:
            return startDate.timeIntervalSinceNow
        }
    }
}



