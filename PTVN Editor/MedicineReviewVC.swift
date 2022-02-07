//
//  MedicineReviewVC.swift
//  PTVN Editor
//
//  Created by Fool on 5/30/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

protocol ChangeMedDelegate: AnyObject {
    var currentMed:String { get set }
    var changedMeds:[String] { get set }
    var theData:PTVN { get set }
    func returnChangedMeds()
}

class MedicineReviewVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource, ChangeMedDelegate {
    
    

    @IBOutlet weak var currentMedsTableView: NSTableView!
    @IBOutlet weak var pharmacyCombo: NSComboBox!
    
    var medListArray = [String]()
    var chosenMeds = [String]()
    
    var currentMed = String()
    var changedMeds = [String]()
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    //This array holds the values for the checkboxes in the table to fix a bug where they checkboxes weren't holding their state when the table was scrolled, or were sharing their state with other rows which hadn't been acted on when scrolling.  The number of values in the array are created based on the number of items in the medListArray
    var checkBoxState = [NSButton.StateValue]()
    
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
        checkBoxState = Array(repeating: NSButton.StateValue.off, count: medListArray.count)
        return medListArray.count
    }
    
    func getArrayFrom(_ medsString:String) -> [String] {
        var returnArray = medsString.removeWhiteSpace().components(separatedBy: "\n").filter { $0 != "" && $0 != "  "}
        returnArray = returnArray.map { $0.replacingOccurrences(of: "- ", with: "") }
        return returnArray
    }
    
    
    //Set up the tableview with the data from the medList array
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
//        vw.textField?.stringValue = medListArray[row]
//        return vw
        
        
        //The simple set up above broke with macOS Monterey and required a more detailed creation of the table
        if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "textViewColumn") {
            let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "textViewCell")
            guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else { return nil }
            cellView.textField?.stringValue = medListArray[row]
            return cellView
        } else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "checkBoxColumn") {
            let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "checkBoxCell")
            guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else { return nil }
            let theCheckBox = cellView.subviews[0] as! NSButton
            theCheckBox.state = checkBoxState[row]
            return cellView
        } else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "changeButtonColumn") {
            let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "changeButtonCell")
            guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else { return nil }
            return cellView
        }
        return nil

    }
    
    
    
    @IBAction func getDataFromSelectedRow(_ sender:Any) {
        let currentRow = currentMedsTableView.row(for: sender as! NSView)
        if (sender as! NSButton).state == .on {
            chosenMeds.append(medListArray[currentRow])
            checkBoxState[currentRow] = .on
        } else if (sender as! NSButton).state == .off {
            checkBoxState[currentRow] = .off
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
        
        let firstVC = presentingViewController as! ViewController
        var results = medListArray.filter { !chosenMeds.contains($0) }.joined(separator: "\n")
        print("Med List Array Results: \(results)")
        if !results.isEmpty {
            //FIX ME: Add method for adding discontinued meds to Plan section
            theData.plan.addToExistingText("DISCONTINUED THIS VIST:\n\(results.addCharacterToBeginningOfEachLine("- "))")
            results = "\n\n DISCONTINUED THIS VIST:\n\(results.addCharacterToBeginningOfEachLine("- "))"
        }
        if !chosenMeds.isEmpty {
            results = "\(chosenMeds.joined(separator: "\n").addCharacterToBeginningOfEachLine("- "))\n\(results)"
        }
        theData.medicines = results
        if !pharmacyCombo.stringValue.isEmpty && pharmacyCombo.stringValue != theData.pharmacy {
            theData.pharmacy = pharmacyCombo.stringValue
        }
        
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        print(sender)
        if let theSender = sender as? NSButton {
            if theSender.title == "Med Check" {
        self.dismiss(self)
            }
        }
    }
    
    func returnChangedMeds() {
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
    }
    
    @IBAction func getRefills(_ sender: Any?) {
        let firstVC = presentingViewController as! ViewController
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
    
    @IBAction func changeMeds(_ sender: Any?) {
        let currentRow = currentMedsTableView.row(for: sender as! NSView)
        let currentCellView = currentMedsTableView.rowView(atRow: currentRow, makeIfNecessary: false)?.view(atColumn: 1) as! NSTableCellView
        guard let currentText = currentCellView.textField?.stringValue else { return }
        currentMed = currentText
        performSegue(withIdentifier: "showChangeMed", sender: self)
        //Take selected med and present a form to adjust their sig or change to a different medication
        //Keep the current sig/med and match it to the changed sig/med
    }
    
    let pharmacies = ["", "Krogers", "Matthewsons", "Walgreens", "Super1", "Walmart", "CVS", "Killions", "Humana", "Express Scripts", "Optum Rx", "Walmart (Carthage)", "Super1 (Tyler)", "Krogers (Longview)", "City Drug", "Well Dynamix", "Davita Rx", "Walmart (4th St.)", "Written script"]
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChangeMed" {
            if let toViewController = segue.destinationController as? ChangeMedsVC {
                toViewController.currentChangeMedDelegate = self
                toViewController.currentMed = self.currentMed
                toViewController.theData = self.theData
            }
        }
    }
}
