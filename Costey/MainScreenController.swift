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
    
    var currentItems: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        periodSegmentedControl.removeAllSegments()
        for (index, item) in Item.Period.allCases.enumerated() {
            setSegmentedControlTitle(for: index, title: item.rawValue.capitalized)
        }
        periodSegmentedControl.selectedSegmentIndex = 0
        self.title = "All items"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemCell else { return UITableViewCell() }
        
        let item = currentItems[indexPath.row]
        cell.setLabels(for: item, and: period)
        return cell
    }
    
    func sendDataAndUpdate(myData: Item) {
        currentItems.append(myData)
        tableView.reloadData()
    }
    
    func updateDataAndRefresh(myData: Item, updateIndex: Int) {
        currentItems[updateIndex] = myData
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if let addItemVc: AddItemViewController = storyboard?.instantiateViewController(identifier: "addUpdateVC") as? AddItemViewController {
            navigationController?.pushViewController(addItemVc, animated: true)
            addItemVc.delegate = self
            addItemVc.title = "Add Item"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = currentItems[indexPath.row]
        if let vc = storyboard?.instantiateViewController(identifier: "addUpdateVC") as? AddItemViewController {
            navigationController?.pushViewController(vc, animated: true)
            _ = vc.view
            vc.prepopulateItemData(from: item)
            vc.updateIndex = indexPath.row
            vc.delegate = self
        }
        
        
    }
    
    func setSegmentedControlTitle(for position: Int, title: String) {
        periodSegmentedControl.insertSegment(withTitle: title, at: position, animated: true)
    }
    
    func setPeriodAndReload(for passedPeriod: Item.Period) {
        period = passedPeriod
        tableView.reloadData()
    }
    
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
    
    
}

