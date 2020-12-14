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
    
    func setLabels(name: String, period: String, pricePerPeriod: String) {
        itemNameLabel.text = name
        periodsPassedLabel.text = period
        pricePerPeriodLabel.text = pricePerPeriod
    }
}
