//
//  ViewController.swift
//  Costey
//
//  Created by Vadim Colcev on 12/13/20.
//

import UIKit

class MainScreenController: UITableViewController, DataSendProtocol {
    
    
    @IBOutlet weak var periodSegmentedControl: UISegmentedControl!
    
    var period: Item.Period = .day
    
    //var currentItems: [Item] = []
    var currentItems: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        periodSegmentedControl.removeAllSegments() // remove default segments of segmented control
        // for every enum case, create separate segmented control segment
        for (index, item) in Item.Period.allCases.enumerated() {
            setSegmentedControlTitle(for: index, title: item.rawValue.capitalized)
        }
        periodSegmentedControl.selectedSegmentIndex = 0 // select the first segmented control by default
        self.title = "All items" // set title for table view controller
        readFromPlistAndUpdateCurrentItems()
        tableView.reloadData()
    }
    
    // return number of rows needed
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentItems.count
    }
    
    // create cells for table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemCell else { return UITableViewCell() }
        
        let item = currentItems[indexPath.row]
        cell.setLabels(for: item, and: period) // set labels for cell
        return cell
    }
    
    
    // Method to set title for single segment of segmented control
    func setSegmentedControlTitle(for position: Int, title: String) {
        periodSegmentedControl.insertSegment(withTitle: title, at: position, animated: true)
    }
    
    // Implementation of needed protocol methods
    func sendDataAndUpdate(myData: Item) {
        currentItems.append(myData)
        writeToPlist()
        tableView.reloadData()
    }
    
    // method to update item and refresh table after update
    func updateDataAndRefresh(myData: Item, updateIndex: Int) {
        currentItems[updateIndex] = myData
        tableView.reloadData()
    }
    
    // action for + item tapped
    @IBAction func addButtonTapped(_ sender: Any) {
        // check if UIViewController can be downcasted to AddItemViewController and store it in addItemVc
        if let addItemVc: AddItemViewController = storyboard?.instantiateViewController(identifier: "addUpdateVC") as? AddItemViewController {
            navigationController?.pushViewController(addItemVc, animated: true) // push stored view controller
            addItemVc.delegate = self // set pushed controller as delegate
            addItemVc.title = "Add Item" // set pushed controller title
        }
    }
    
    // method to perform code when certain table row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = currentItems[indexPath.row] // store item corresponding to selected row
        if let vc = storyboard?.instantiateViewController(identifier: "addUpdateVC") as? AddItemViewController {
            navigationController?.pushViewController(vc, animated: true)
            _ = vc.view  // use this to load the vc view fully
            vc.prepopulateItemData(from: item) // populate textfields and date picker with existing data of current item
            vc.updateIndex = indexPath.row // set updateIndex property of pushed vc
            vc.delegate = self
            vc.title = "Edit Item"
        }
        
    }
    
    // delete item functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            currentItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    // method to switch period and reload table data after it
    func setPeriodAndReload(for passedPeriod: Item.Period) {
        period = passedPeriod
        tableView.reloadData()
    }
    
    // method for segmented control that checks chosen segment and updates period accordingly
    @IBAction func onSegmentChange(_ sender: Any) {
        switch periodSegmentedControl.selectedSegmentIndex {
        case 0:
            setPeriodAndReload(for: .day)
        case 1:
            setPeriodAndReload(for: .month)
        case 2:
            setPeriodAndReload(for: .year)
        default:
            period = Item.Period.day
        }
    }
    
    // READ FROM PLIST METHOD
    func readFromPlistAndUpdateCurrentItems() {
        if let path = Bundle.main.url(forResource: "Items", withExtension: "plist") {
            do {
                let plistData = try Data(contentsOf: path)
                if let array = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: nil) as? [Item] {
                    currentItems = array
                }
                } catch {
                    print("Error while updating current items.")
            }
        }
    }
    
    func writeToPlist() {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Items.plist")
            do {
                let data = try PropertyListEncoder().encode(currentItems)
                try data.write(to: path)
            } catch {
                print("Error writing to plist")
            }
    }
    
}


