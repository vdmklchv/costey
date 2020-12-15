//
//  AddItemViewController.swift
//  Costey
//
//  Created by Vadim Colcev on 12/13/20.
//

import UIKit

protocol DataSendProtocol {
    func sendDataAndUpdate(myData: Item)
    func updateDataAndRefresh(myData: Item, updateIndex: Int)
}

class AddItemViewController: UIViewController {
    
    
    var delegate: DataSendProtocol? = nil
    var updateIndex: Int = 0
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    func prepopulateItemData(from item: Item) {
        nameTextField.text = item.name
        priceTextField.text = String(item.price)
        datePicker.setDate(item.startDate, animated: true)
        self.title = "Edit Item"
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = nameTextField.text,
        let price = priceTextField.text {
            if let price = Double(price) {
                let date = datePicker.date
                let item = Item(name: name, price: price, startDate: date)
                if delegate != nil {
                    let dataToSend = item
                    if self.title == "Add Item" {
                        self.delegate?.sendDataAndUpdate(myData: dataToSend)
                    } else {
                        self.delegate?.updateDataAndRefresh(myData: dataToSend, updateIndex: updateIndex)
                    }
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
}


