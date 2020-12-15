//
//  AddItemViewController.swift
//  Costey
//
//  Created by Vadim Colcev on 12/13/20.
//

import UIKit

protocol DataSendProtocol {
    func sendData(myData: Item)
    func updateTable()
}

class AddItemViewController: UIViewController {
    
    var delegate: DataSendProtocol? = nil

    @IBOutlet var addItemTextField: [UITextField]!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let name = addItemTextField[0].text
        let price = addItemTextField[1].text
        let day = addItemTextField[2].text
        let month = addItemTextField[3].text
        let year = addItemTextField[4].text
        
        if let day = day, let month = month, let year = year, let price = price, let name = name {

            if let date = Item.getDateObject(for: Int(day), month: Int(month), year: Int(year)) {

                if let price = Double(price) {

                    let item = Item(name: name, price: price, startDate: date)
                    
                    if delegate != nil {
                        let dataToSend = item
                        self.delegate?.sendData(myData: dataToSend)
                        self.delegate?.updateTable()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
        
}

