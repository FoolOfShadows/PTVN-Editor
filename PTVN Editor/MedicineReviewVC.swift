//
//  MedicineReviewVC.swift
//  PTVN Editor
//
//  Created by Fool on 5/30/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

class MedicineReviewVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var currentMedsTableView: NSTableView!
    @IBOutlet weak var pharmacyCombo: NSComboBox!
    
    var medListArray = [String]()
    var chosenMeds = [String]()
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(theData.medicines)
        medListArray = getArrayFrom(theData.medicines)
        //print(medListArray)
        pharmacyCombo.clearComboBox(menuItems: pharmacies)
        self.currentMedsTableView.reloadData()
        if !theData.pharmacy.isEmpty {
            pharmacyCombo.stringValue = theData.pharmacy
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        //print("medListArray Count = \(medListArray.count)")
        return medListArray.count
    }
    
    func getArrayFrom(_ medsString:String) -> [String] {
        var returnArray = medsString.removeWhiteSpace().components(separatedBy: "\n").filter { $0 != "" && $0 != "  "}
        returnArray = returnArray.map { $0.replacingOccurrences(of: "- ", with: "") }
        
        return returnArray
    }
    
    
    //Set up the tableview with the data from the medList array
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        
        vw.textField?.stringValue = medListArray[row]
        
        
        return vw
    }
    
    
    
    @IBAction func getDataFromSelectedRow(_ sender:Any) {
        let currentRow = currentMedsTableView.row(for: sender as! NSView)
        
        if (sender as! NSButton).state == .on {
            chosenMeds.append(medListArray[currentRow])
        } else if (sender as! NSButton).state == .off {
            chosenMeds = chosenMeds.filter { $0 != medListArray[currentRow] }
        }
        //print(chosenMeds)
        
    }
    
    @IBAction func getDataFromSelectedRowsText(_ sender:Any) {
        let currentRow = currentMedsTableView.row(for: sender as! NSView)
        let currentCellView = currentMedsTableView.rowView(atRow: currentRow, makeIfNecessary: false)?.view(atColumn: 1) as! NSTableCellView
        guard let currentText = currentCellView.textField?.stringValue else { return }


        if (sender as! NSButton).state == .on {
            chosenMeds.append(currentText)
            //chosenMeds.append(medListArray[currentRow])
        } else if (sender as! NSButton).state == .off {
            chosenMeds = chosenMeds.filter { $0 != currentText}
            //chosenMeds = chosenMeds.filter { $0 != medListArray[currentRow] }
        }
    }
    
    @IBAction func returnResults(_ sender:Any) {
        let firstVC = presenting as! ViewController
        var results = "\n\n DISCONTINUED THIS VIST:\n\(medListArray.filter { !chosenMeds.contains($0) }.joined(separator: "\n"))"
        if !chosenMeds.isEmpty {
            results = "\(chosenMeds.joined(separator: "\n"))\n\(results)"
        }
        theData.medicines = results
        if !pharmacyCombo.stringValue.isEmpty && pharmacyCombo.stringValue != theData.pharmacy {
            theData.pharmacy = pharmacyCombo.stringValue
        }
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
    }
    
    @IBAction func getRefills(_ sender: Any?) {
        let firstVC = presenting as! ViewController
//        if !chosenMeds.isEmpty {
//            var refillItems = [String]()
//            for item in chosenMeds {
//                refillItems.append("~~\(item)")
//            }
            let refillItems = chosenMeds.map { $0.prependCharacter("~~") }
            
            theData.plan.addToExistingText("REFILLS REQUESTED:\n\(refillItems.joined(separator: "\n"))")
            firstVC.theData = theData
            currentPTVNDelegate?.returnPTVNValues(sender: self)
        //}
        self.dismiss(self)
    }
    
    let pharmacies = ["", "Krogers", "Matthewsons", "Walgreens", "Super1", "Walmart", "CVS", "Killions", "Humana", "Express Scripts", "Optum Rx", "Walmart (Carthage)", "Super1 (Tyler)", "Krogers (Longview)", "City Drug", "Well Dynamix", "Davita Rx", "Walmart (4th St.)", "Written script"]
    
}
