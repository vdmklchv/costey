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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        let item = currentItems[indexPath.row]
        let period = item.calculatePeriod(for: .day)
        let pricePerPeriod = String(item.price / period)
        
        cell.setLabels(name: item.name, period: String(period), pricePerPeriod: pricePerPeriod)
        
        
        return cell
    }
    
    func sendData(myData: Item) {
        currentItems.append(myData)
    }
    
    func updateTable() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getDataSegue" {
            let addItemVC: AddItemViewController = segue.destination as! AddItemViewController
            addItemVC.delegate = self
        }
    }

}

