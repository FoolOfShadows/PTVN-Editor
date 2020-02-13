//
//  FollowUpVC.swift
//  PTVN Editor
//
//  Created by Fool on 2/13/20.
//  Copyright © 2020 Fool. All rights reserved.
//

import Cocoa

class FollowUpVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource {


    @IBOutlet weak var assessmentTableView: NSTableView!
    @IBOutlet weak var addReasonView: NSTextField!
    

    var assessmentString = String()
    var assessmentList = [String]()
    var chosenAssessmentList = [String]()
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the table of previous assessments on the Assessment & Plan tab
        self.assessmentTableView.delegate = self
        self.assessmentTableView.dataSource = self
        
        assessmentList = theData.assessment.convertListToArray()
        print("Assessment Text: \(theData.assessment)")
        print("Assessment List: \(assessmentList)")
        self.assessmentTableView.reloadData()
    }
    
    
    //MARK: Table Handling Functions
    func numberOfRows(in tableView: NSTableView) -> Int {
        //print("Table row count = \(assessmentList.count)")
        return assessmentList.count
    }
    
    //Set up the tableview with the data from the assessmentList array
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result:NSTableCellView
        result = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as! NSTableCellView
        result.textField?.stringValue = assessmentList[row]
        
        return result
    }
    
    @IBAction func addReasonToTable(_ sender: Any) {
        if !addReasonView.stringValue.isEmpty {
            assessmentList.append(addReasonView.stringValue)
            self.assessmentTableView.reloadData()
            let newView = self.assessmentTableView
        }
    }
    
    @IBAction func processAssessmentTable(_ sender: Any) {
    
//    let results = Assessment().processAssessmentUsingArray(chosenAssessmentList, and: visitLevelView.getListOfButtons().filter {$0.state == .on}.map {$0.title})
        
//        theData.plan.addToExistingText(results, withSpace: false)
    }
}
