//
//  Cell.swift
//  Costey
//
//  Created by Vadim Colcev on 12/14/20.
//

import Foundation
import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var periodsPassedLabel: UILabel!

    @IBOutlet weak var pricePerPeriodLabel: UILabel!
    
    // method to create labels
    func setLabels(for item: Item, and period: Item.Period) {
        let passedPeriod = item.calculatePeriod(for: period)
        let pricePerPeriod: String
        if passedPeriod == 0 { // prevent app from crashing because of zero division
            pricePerPeriod = String(Int(item.price))
        } else {
            pricePerPeriod = String(Int(item.price/Double(passedPeriod)))
        }
        
        itemNameLabel.text = item.name
        periodsPassedLabel.text = String(Int(passedPeriod))
        pricePerPeriodLabel.text = pricePerPeriod
    }
}
