//
//  FollowUpVC.swift
//  PTVN Editor
//
//  Created by Fool on 2/13/20.
//  Copyright © 2020 Fool. All rights reserved.
//

import Cocoa

class FollowUpVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource, NSTextFieldDelegate, NSControlTextEditingDelegate {


    @IBOutlet weak var assessmentTableView: NSTableView!
    @IBOutlet weak var addReasonView: NSTextField!
    @IBOutlet weak var fu1Stack: NSStackView!
    @IBOutlet weak var fu2Stack: NSStackView!
    @IBOutlet weak var fu3Stack: NSStackView!
    

    var assessmentString = String()
    var assessmentList = [(String, NSControl.StateValue)]()
    var chosenAssessmentList = [String]()
    
    var followupPt1 = String()
    var followupPt2 = String()
    var followupPt3 = String()
    var followupInfo = String()
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the table of previous assessments on the Assessment & Plan tab
        self.assessmentTableView.delegate = self
        self.assessmentTableView.dataSource = self
        self.addReasonView.delegate = self
        
        assessmentList = theData.assessment.convertListToArray().map { ($0, .off)}
        self.assessmentTableView.reloadData()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        //These connections need to be weak or they will create a retention cycle and the presenting view won't close
        //FIXME: Probably a better way to structure this
        weak var firstFUBit = fu1Stack.getButtonsInView().filter {$0.title == "3"}[0]
        if let firstBit = firstFUBit {
            firstBit.state = .on
            getFirstFUPart(firstBit)
        }
        weak var secondFUBit = fu2Stack.getButtonsInView().filter {$0.title == "Month"}[0]
        if let secondBit = secondFUBit {
            secondBit.state = .on
            getSecondFUPart(secondBit)
        }
        weak var thirdFUBit = fu3Stack.getButtonsInView().filter {$0.title == "20"}[0]
        if let thirdBit = thirdFUBit {
            thirdBit.state = .on
            getThirdFUPart(thirdBit)
        }
    }
    
    func controlTextDidEndEditing(_ obj: Notification) {
        //Capture the tapped key, see if it's the Return key
        //and if it is, process all the data into the results field
        if let sendingKey = obj.userInfo?["NSTextMovement"] as? Int {
            if sendingKey == NSReturnTextMovement {
                addReasonToTable(self)
            }
        }
    }
    
    //MARK: Table Handling Functions
    func numberOfRows(in tableView: NSTableView) -> Int {
        //print("Table row count = \(assessmentList.count)")
        return assessmentList.count
    }
    
    //Set up the tableview with the data from the assessmentList array
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else {
            return nil }
        if tableColumn?.identifier.rawValue == "clmAssessment" {
            vw.textField?.stringValue = assessmentList[row].0
        } else if tableColumn?.identifier.rawValue == "clmCheckbox" {
//            let buttonvw = vw.objectValue as? NSButton
//            buttonvw?.state = assessmentList[row].1
            vw.getButtonsInView()[0].state = assessmentList[row].1
        }
//        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
//        vw.textField?.stringValue = assessmentList[row].0
        return vw
    }
    
    
    @IBAction func addReasonToTable(_ sender: Any) {
        if !addReasonView.stringValue.isEmpty {
            assessmentList.append((addReasonView.stringValue, .on))
            chosenAssessmentList.append(addReasonView.stringValue)
            self.assessmentTableView.reloadData()
            addReasonView.stringValue = ""
            //FIXME: Newly added rows should be checked by default
        }
    }
    @IBAction func getDataFromSelectedRowsText(_ sender:Any) {
        let currentRow = assessmentTableView.row(for: sender as! NSView)
        let currentCellView = assessmentTableView.rowView(atRow: currentRow, makeIfNecessary: false)?.view(atColumn: 1) as! NSTableCellView
        guard let currentText = currentCellView.textField?.stringValue else { return }


        if (sender as! NSButton).state == .on {
            chosenAssessmentList.append(currentText)
            assessmentList[currentRow].1 = .on
        } else if (sender as! NSButton).state == .off {
            chosenAssessmentList = chosenAssessmentList.filter { $0 != currentText}
            assessmentList[currentRow].1 = .off
        }
    }
    
    @IBAction func getDataFromSelectedCheckboxes(_ sender: NSButton) {
        if sender.state == .on {
            chosenAssessmentList.append(sender.title)
        } else if sender.state == .off {
            chosenAssessmentList = chosenAssessmentList.filter { $0 != sender.title}
        }
    }
    
    @IBAction func processAssessmentTable(_ sender: Any) {
        var followupData = String()
        if !followupInfo.isEmpty {
            followupData = followupInfo
        }
        if !chosenAssessmentList.isEmpty {
            followupData += " Followup will be for: \(chosenAssessmentList.joined(separator: ", "))"
        }
        if !followupData.isEmpty {
            let firstVC = presentingViewController as! ViewController
            theData.plan.addToExistingText(followupData)
            firstVC.theData = theData
            currentPTVNDelegate?.returnPTVNValues(sender: self)
        }
        self.dismiss(self)
    }
    
        func createFollowup() {
            var results = String()
            var plural = String()
            if let isNumber = Int(followupPt1) {
                if isNumber != 1 {
                    plural = "s"
                }
            }
            if !followupPt1.isEmpty && !followupPt2.isEmpty && !followupPt3.isEmpty {
                results = "`•Schedule follow up appointment in \(followupPt1) \(followupPt2)\(plural) for \(followupPt3) minutes."
            }
    //        if !followupPt3.isEmpty {
    //            results += " for \(followupPt3) minutes."
    //        }
            
            if followupPt2 == "keep" {
                let nextApt = theData.plan.getLinesStartingWith("Next apt: ")[0].replacingOccurrences(of: "Next apt: ", with: "")
                results = "`•Keep previously scheduled appointment (\(nextApt))."
            } else if followupPt2 == "prn" {
                results = "`•Patient will schedule appointment as needed."
            }
            followupInfo = results
        }
    
    
    @IBAction func getFirstFUPart(_ sender: NSButton) {
        followupPt1 = sender.title.lowercased()
        createFollowup()
//        if !followupInfo.isEmpty {
//            theData.plan.addToExistingText(followupInfo)
//        }
    }
    @IBAction func getSecondFUPart(_ sender: NSButton) {
        followupPt2 = sender.title.lowercased()
        createFollowup()
//        if !followupInfo.isEmpty {
//            theData.plan.addToExistingText(followupInfo)
//        }
    }
    @IBAction func getThirdFUPart(_ sender: NSButton) {
        followupPt3 = sender.title.lowercased()
        createFollowup()
//        if !followupInfo.isEmpty {
//            theData.plan.addToExistingText(followupInfo)
//        }
    }
}
