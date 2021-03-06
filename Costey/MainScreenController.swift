//
//  ViewController.swift
//  Costey
//
//  Created by Vadim Colcev on 12/13/20.
//

import UIKit

class MainScreenController: UITableViewController, DataSendProtocol  {
    
    
    
    @IBOutlet weak var periodSegmentedControl: UISegmentedControl!
    
    let data = DefaultDataManager()
    var period: Item.Period = .day
    
    override func viewDidLoad() {
        super.viewDidLoad()
        periodSegmentedControl.removeAllSegments() // remove default segments of segmented control
        // for every enum case, create separate segmented control segment
        for (index, item) in Item.Period.allCases.enumerated() {
            setSegmentedControlTitle(for: index, title: item.rawValue.capitalized)
        }
        periodSegmentedControl.selectedSegmentIndex = 0 // select the first segmented control by default
        data.sortItems(per: .day)
        self.title = "All items" // set title for table view controller
        data.onDataRefresh = {
            self.tableView.reloadData()
        }
    }
    
    // return number of rows needed
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.arrLength
    }
    
    // create cells for table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemCell else { return UITableViewCell() }
        
        let item = data.getItem(at: indexPath.row)
        cell.setLabels(for: item, in: period) // set labels for cell
        return cell
    }
    
    
    // Method to set title for single segment of segmented control
    func setSegmentedControlTitle(for position: Int, title: String) {
        periodSegmentedControl.insertSegment(withTitle: title, at: position, animated: true)
    }
    
    // Implementation of needed protocol methods
    func sendDataAndUpdate(myData: Item) {
        data.saveItem(item: myData)
    }
    
    // method to update item and refresh table after update
    func updateDataAndRefresh(myData: Item, updateIndex: Int) {
        data.updateArr(with: myData, at: updateIndex)
    }
    
    // action for + item tapped
    @IBAction func addButtonTapped(_ sender: Any) {
        // check if UIViewController can be downcasted to AddItemViewController and store it in addItemVc
        if let addItemVc: AddItemViewController = storyboard?.instantiateViewController(identifier: "addUpdateVC") as? AddItemViewController {
            navigationController?.pushViewController(addItemVc, animated: true) // push stored view controller
            addItemVc.delegate = self // set pushed controller as delegate
            addItemVc.title = "Add Item" // set pushed controller title
            addItemVc.onItemAdd = {
                self.resetSegmentedControl()
                self.data.sortItems(per: .day)
            }
            addItemVc.data = data
        }
    }
    
    // method to perform code when certain table row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data.getItem(at: indexPath.row) // store item corresponding to selected row
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
            data.removeItem(at: indexPath.row)
        }
    }
    
    // method for segmented control that checks chosen segment and updates period accordingly
    @IBAction func onSegmentChange(_ sender: Any) {
        if periodSegmentedControl.selectedSegmentIndex == 0 {
            period = .day
        } else if periodSegmentedControl.selectedSegmentIndex == 1 {
            period = .month
        } else if periodSegmentedControl.selectedSegmentIndex == 2 {
            period = .year
        }
        data.sortItems(per: period)
    }
        
    @IBAction func refreshButtonTapped(_ sender: Any) {
        tableView.reloadData()
    }
    
    func resetSegmentedControl() {
        periodSegmentedControl.selectedSegmentIndex = 0
    }
}


