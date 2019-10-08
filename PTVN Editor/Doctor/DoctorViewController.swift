//
//  DoctorViewController.swift
//  LIROS
//
//  Created by Fool on 10/20/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

//Protocol to set up for accepting data back from the CurrentAssessmentController
//protocol assessmentTableDelegate: class {
//    func currentAssessmentWillBeDismissed(sender: CurrentAssessmentController)
//}

class DoctorViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet var doctorTabView: NSView!
    @IBOutlet weak var dataReviewView: NSBox!
    @IBOutlet weak var labView: NSBox!
    @IBOutlet weak var proceduresView: NSBox!
    @IBOutlet weak var educationView: NSBox!
    @IBOutlet weak var injectionsView: NSBox!
    @IBOutlet weak var preOpView: NSBox!
//    @IBOutlet weak var commonMedsPopup: NSPopUpButton!
    //@IBOutlet weak var medicationView: NSTextView!
//    @IBOutlet weak var medicationScroll: NSScrollView!
    @IBOutlet weak var arthPopup: NSPopUpButton!
    @IBOutlet weak var synvPopup: NSPopUpButton!
//    @IBOutlet weak var assessmentTableView: NSTableView!
//
//    @IBOutlet weak var visitLevelView: NSView!
    
//    var medicationView: NSTextView {
//        get {
//            return medicationScroll.contentView.documentView as! NSTextView
//        }
//    }
	
//    var assessmentString = String()
//    var assessmentList = [String]()
//    var chosenAssessmentList = [String]()
//    let problemBadBits = ["Problems\\*\\*", "\\*problems\\*"]
    
    let nc = NotificationCenter.default
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    func getDataFromView(_ view:NSView) -> [(Int, String?)] {
        let tagList = getButtonsIn(view: view)
        return tagList.sorted(by: {$0.0 < $1.0})
    }
        
    func getButtonsIn(view: NSView) -> [(Int, String?)]{
        var results = [(Int, String?)]()
        for item in view.subviews {
            //print(item.tag)
            if let isButton = item as? NSButton {
            //if item is NSButton {
                if isButton.state == .on {
                    switch isButton {
                    case is NSPopUpButton:
                        if !(isButton as! NSPopUpButton).titleOfSelectedItem!.isEmpty {
                            results.append((isButton.tag, (isButton as! NSPopUpButton).titleOfSelectedItem))
                        }
                    default:
                        results.append((item.tag, nil))
                    }
                }
                //If we don't check tags here we end up with an entry for the NSBox and it's title
            } else if item is NSTextField && item.tag > 0 {
                if (item as! NSTextField).stringValue != "" {
                    results.append((item.tag, (item as! NSTextField).stringValue))
                }
            } else {
                results += getButtonsIn(view: item)
            }
        }
        return results
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.assessmentTableView.delegate = self
//        self.assessmentTableView.dataSource = self
        clearDrTab(self)
        
        //Populate assessmentTableView with Problems subsection of the Subjective section
//        let problems = theData.problems/*theData.subjective.simpleRegExMatch("(?s)(Problems\\*\\*).*(\\*problems\\*)").cleanTheTextOf(problemBadBits)*/
//        assessmentList = problems.convertListToArray()
//        self.assessmentTableView.reloadData()
//        chosenAssessmentList = assessmentList
        
        
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }
    
//    @IBAction func addMed(_ sender: Any) {
//        if !commonMedsPopup.titleOfSelectedItem!.isEmpty {
//            medicationView.addToViewsExistingText(commonMedsPopup.titleOfSelectedItem!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
////            let currentMeds = medicationView.string
////            medicationView.string = commonMedsPopup.titleOfSelectedItem! + currentMeds
//        }
//    }
    
    @IBAction func clearDrTab(_ sender: Any) {
        doctorTabView.clearControllers()
//        commonMedsPopup.clearPopUpButton(menuItems: commonMedsList)
        arthPopup.clearPopUpButton(menuItems: jointList)
        synvPopup.clearPopUpButton(menuItems: kneeList)
//        assessmentList = [String]()
//        self.assessmentTableView.reloadData()
    }
    
    @IBAction func returnResults(_ sender:Any) {
        let dataReviewResults = DataReview().processSectionData(getDataFromView(dataReviewView))
        let labViewResults = Lab().processSectionData(getDataFromView(labView))
        let proceduresResults = Procedures().processProceduresUsing(getDataFromView(proceduresView))
        let educationResults = Education().processSectionData(getDataFromView(educationView))
        let injectionResults = Injections().processInjectionsUsing(getDataFromView(injectionsView))
        let preOpResults = PreOp().processSectionData(getDataFromView(preOpView))
        
        
        let resultsArray = [dataReviewResults, labViewResults, proceduresResults, educationResults, injectionResults, preOpResults]
        
//        if !medicationView.string.isEmpty {
//            let medArray = medicationView.string.convertListToArray()
//            //print(medArray)
//            //resultsArray.append("Medications:\n\(medicationView.string)")
//            resultsArray.append("Prescribed this visit:\n\(medArray.map {$0.prependCharacter("~~")}.joined(separator: "\n"))")
//        }
        let filteredResultsArray = resultsArray.filter{!$0.isEmpty}
        let results = filteredResultsArray.joined(separator: "\n")
        
        theData.plan.addToExistingText(results)
//        processAssessmentTable(self)
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
    }
    
    //MARK: Table Handling Functions
//    func numberOfRows(in tableView: NSTableView) -> Int {
//        return assessmentList.count
//    }
    
    //Set up the tableview with the data from the assessmentList array
//    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//        var result:NSTableCellView
//        result = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as! NSTableCellView
//        result.textField?.stringValue = assessmentList[row]
//
//        return result
//    }
    
    
    func processAssessmentFromNoteAt(_ url: String?) -> String {
        var fullText = String()
        do {
            fullText = try String(contentsOfFile: url!, encoding: String.Encoding.utf8)
        } catch {
            return ""
        }
        
        let medications = fullText.findRegexMatchBetween("Problems:", and: "S:")?.removeWhiteSpace() ?? ""
        
        return medications
    }
    
    
//    @IBAction func processAssessmentTable(_ sender: Any) {
//
//        let results = Assessment().processAssessmentUsingArray(chosenAssessmentList, and: visitLevelView.getListOfButtons().filter {$0.state == .on}.map {$0.title})
//
//        theData.assessment.addToExistingText(results)
//    }
    
//    @IBAction func getDataFromSelectedRow(_ sender:Any) {
//        let currentRow = assessmentTableView.row(for: sender as! NSView)
//        if (sender as! NSButton).state == .on {
//            chosenAssessmentList.append(assessmentList[currentRow])
//        } else if (sender as! NSButton).state == .off {
//            chosenAssessmentList = chosenAssessmentList.filter { $0 != assessmentList[currentRow] }
//        }
//    }
    
    //Adds a blank line to the table and selects it, also adding a corresponding
    //empty string item to the data source array
//    @IBAction func addMedToTable(_ sender: NSButton) {
//        //Add the info from the textfield to the medList array
//        assessmentList.insert("", at: 0)
//        //Add the new info into the tableView (not sure exactly how this works)
//        assessmentTableView.insertRows(at: IndexSet(integer: 0), withAnimation: NSTableView.AnimationOptions.slideDown)
//        assessmentTableView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
//
//    }
    
    //Attached to the table's Table Cell View prototype via the classes First Responder
    //updates the data source array with any changes made to the table items.
//    @IBAction func updateArrayWithEdit(_ sender:Any) {
//        let currentRow = assessmentTableView.row(for: sender as! NSView)
//        //print(currentRow)
//
//        if let textField = sender as? NSTextField {
//            let textValue = textField.stringValue
//            assessmentList.remove(at: currentRow)
//            assessmentList.insert(textValue, at: currentRow)
//        }
//
//
//    }
    
    //Removes the selected row from the table and the corresponding
    //item from the data source array
//    @IBAction func removeRowFromTable(_ sender: NSButton) {
//        let row = assessmentTableView.selectedRow
//        if row != -1 {
//            assessmentList.remove(at: row)
//            let indexSet = IndexSet(integer:row)
//            assessmentTableView.removeRows(at:indexSet, withAnimation:NSTableView.AnimationOptions.effectFade)
//        }
//    }
	
//    @IBAction func onlyOneCheckAtATime(_ sender:NSButton) {
//        let boxes = visitLevelView.getListOfButtons()
//        for box in boxes {
//            if box.title != sender.title {
//                box.state = .off
//            }
//        }
//    }
    
    @IBAction func thinnerOrNot(_ sender:NSButton) {
        let boxes = preOpView.getListOfButtons()
        for box in boxes {
            if sender.tag != 1 {
                let noneBox = boxes.filter { $0.tag == 1 }
                noneBox[0].state = .off
            } else if box.title != sender.title {
                box.state = .off
            }
        }
    }
}
