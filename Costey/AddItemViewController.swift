//
//  AddItemViewController.swift
//  Costey
//
//  Created by Vadim Colcev on 12/13/20.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet var addItemTextField: [UITextField]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let name = addItemTextField[0].text
        let price = addItemTextField[1].text
        let day = addItemTextField[2].text
        let month = addItemTextField[3].text
        let year = addItemTextField[4].text
        
        if let day = day, let month = month, let year = year, let price = price, let name = name {
            if let date = getDateObject(for: Int(day), month: Int(month), year: Int(year)) {
                if let price = Double(price) {
                    let item = Item(name: name, price: price, startDate: date)
                    Item.currentItems.append(item)
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
    
    func getDateObject(for day: Int?, month: Int?, year: Int?) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        if let date = Calendar.current.date(from: components) {
            return date
        }
        else {
            return nil
        }
    
    
}
}
