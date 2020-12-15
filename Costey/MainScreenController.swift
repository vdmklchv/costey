//
//  ViewController.swift
//  Costey
//
//  Created by Vadim Colcev on 12/13/20.
//

import UIKit

class MainScreenController: UITableViewController, DataSendProtocol {
    
    var currentItems: [Item] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemCell {
            let item = currentItems[indexPath.row]
            cell.setLabels(for: item, and: .day)
            return cell
        }
        return cell
    }
    
    func sendDataAndUpdate(myData: Item) {
        currentItems.append(myData)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getDataSegue" {
            let addItemVC: AddItemViewController = segue.destination as? AddItemViewController ?? AddItemViewController()
            addItemVC.delegate = self
        }
    }

}

