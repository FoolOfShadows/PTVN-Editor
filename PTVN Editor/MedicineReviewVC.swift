//
//  MedicineReviewVC.swift
//  PTVN Editor
//
//  Created by Fool on 5/30/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

protocol ChangeMedDelegate: class {
    var currentMed:String { get set }
    var changedMeds:[String] { get set }
    var theData:PTVN { get set }
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
        print("Changed Meds: \(changedMeds.joined(separator: "/n"))")
        let firstVC = presentingViewController as! ViewController
        var results = medListArray.filter { !chosenMeds.contains($0) }.joined(separator: "\n")
        if !results.isEmpty {
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
        if sender is MedicineReviewVC {
        self.dismiss(self)
        }
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
