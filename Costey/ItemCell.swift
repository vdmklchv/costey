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
    func setLabels(for item: Item) {
        let pricePerPeriod = item.pricePerPeriod
        let periodsPassed = item.passedPeriod
        
        itemNameLabel.text = item.name
        periodsPassedLabel.text = String(Int(periodsPassed))
        pricePerPeriodLabel.text = String(format: "%.2f", pricePerPeriod)
    }
}
