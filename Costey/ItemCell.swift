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
    
    
    func setLabels(for item: Item, and period: Item.Period) {
        let passedPeriod = item.calculatePeriod(for: period)
        let pricePerPeriod = String(item.price / passedPeriod)
        itemNameLabel.text = item.name
        periodsPassedLabel.text = String(passedPeriod)
        pricePerPeriodLabel.text = pricePerPeriod
    }
}
