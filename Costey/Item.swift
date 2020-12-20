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
    
    var pricePerPeriod: Double { // ЗДЕСЬ ПРОСТО ПОСТАВИЛ ЗАГЛУШКУ. ПРОБЛЕМА В ТОМ
        // ЧТО ЭТО ДОЛЖНО СЧИТАТЬСЯ КАК PRICE (это есть) ДЕЛЕННОЕ НА PERIOD. А ВОТ ТУТ
        // ПРОБЛЕМА ПОТОМУ ЧТО PERIOD СЧИТАЕТСЯ МЕТОДОМ calculatePeriod(for: ). ЭТОТ
        // МЕТОД ПОЛУЧАЕТ period ИЗ MainController, ПОЭТОМУ Я НЕ ПОНИМАЮ КАК МНЕ
        // ПОСЧИТАТЬ ЭТОТ СOMPUTED PROPERTY, САМ PRICE PER PERIOD СЕЙЧАС СЧИТАЕТСЯ В ItemCell ПОТОМУ ЧТО РАНЕЕ ИСПОЛЬЗОВАЛСЯ ТОЛЬКО ДЛЯ ОТОБРАЖЕНИЯ. С ItemCell ПРОБЛЕМ НЕ БУДЕТ Я ДУМАЮ, ТАМ МОЖНО БУДЕТ ПРОСТО ИЗ ПЕРЕДАННОГО ITEM подтягивать ЭТОТ computed property
        return 3.33
    }
    
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



