//
//  AddItemViewController.swift
//  Costey
//
//  Created by Vadim Colcev on 12/13/20.
//

import UIKit

protocol DataSendProtocol {
    func sendDataAndUpdate(myData: Item)
}

class AddItemViewController: UIViewController {
    
    var delegate: DataSendProtocol? = nil

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = nameTextField.text,
        let price = priceTextField.text {
            if let price = Double(price) {
                let date = datePicker.date
                let item = Item(name: name, price: price, startDate: date)
                if delegate != nil {
                    let dataToSend = item
                    self.delegate?.sendDataAndUpdate(myData: dataToSend)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
}


