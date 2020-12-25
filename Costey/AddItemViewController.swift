//
//  AddItemViewController.swift
//  Costey
//
//  Created by Vadim Colcev on 12/13/20.
//

import UIKit

// define protocol to send data to main screen controller
protocol DataSendProtocol {
    func sendDataAndUpdate(myData: Item) // method needed to send data from add screen
    func updateDataAndRefresh(myData: Item, updateIndex: Int) // method needed to send data from edit screen. We send also index to know what to update
}

class AddItemViewController: UIViewController {
    
    
    var delegate: DataSendProtocol? = nil // delegate variable
    var updateIndex: Int = 0 // updateIndex variable needed to first receive it and then send it back
    var data: DefaultDataManager?
    var onItemAdd: (() -> Void)? = nil
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // method to pre-populate text fields and date picker
    func prepopulateItemData(from item: Item) {
        nameTextField.text = item.name
        priceTextField.text = String(format: "%.2f", item.price)
        datePicker.setDate(item.startDate, animated: true)
    }
    
    // Method used on Save button tapped
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = nameTextField.text, // check if everything exists and of the needed type
        let price = priceTextField.text {
            if let price = Double(price) {
                let date = datePicker.date
                let item = Item(name: name, price: price, startDate: date)
                let dataToSend = item
                if self.title == "Add Item" { // check if we are at Add Item or Edit Item flow and call corresponding methods as delegate
                    self.delegate?.sendDataAndUpdate(myData: dataToSend)
                } else {
                    self.delegate?.updateDataAndRefresh(myData: dataToSend, updateIndex: updateIndex)
                }
                    self.navigationController?.popViewController(animated: true) // remove add/update controller after job is done
                }
            }
        onItemAdd?()
    }
}


