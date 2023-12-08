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
    @IBOutlet weak var snippetReviewView: NSBox!
    @IBOutlet weak var labView: NSBox!
    @IBOutlet weak var proceduresView: NSBox!
    @IBOutlet weak var educationView: NSBox!
    @IBOutlet weak var injectionsView: NSBox!
    @IBOutlet weak var preOpView: NSBox!
    @IBOutlet weak var preventiveView: NSBox!
//    @IBOutlet weak var commonMedsPopup: NSPopUpButton!
    //@IBOutlet weak var medicationView: NSTextView!
//    @IBOutlet weak var medicationScroll: NSScrollView!
    @IBOutlet weak var arthPopup: NSPopUpButton!
    @IBOutlet weak var synvPopup: NSPopUpButton!
    
    @IBOutlet weak var previousPrevScroll: NSScrollView!
    var previousPrevView: NSTextView {
        get {
            return previousPrevScroll.contentView.documentView as! NSTextView
        }
    }
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
        clearDrTab(self)
        setFontSizeOf(16, forFields: [previousPrevView])
        previousPrevView.string = getPrevDataFrom(theData.preventive)
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
        let snippetResults = DataReview().processSectionData(getDataFromView(snippetReviewView))
        let labViewResults = Lab().processSectionData(getDataFromView(labView))
        let proceduresResults = Procedures().processProceduresUsing(getDataFromView(proceduresView))
        let educationResults = Education().processSectionData(getDataFromView(educationView))
        let injectionResults = Injections().processInjectionsUsing(getDataFromView(injectionsView))
        let preOpResults = PreOp().processSectionData(getDataFromView(preOpView))
        let objectiveResults = DataReview().processObjectiveData(getDataFromView(snippetReviewView))
        let preventiveResults = Preventive().processPreventiveData(getDataFromView(preventiveView))
        
        
        let resultsArray = [dataReviewResults, snippetResults, labViewResults, proceduresResults, educationResults, injectionResults, preOpResults, preventiveResults]
        
//        if !medicationView.string.isEmpty {
//            let medArray = medicationView.string.convertListToArray()
//            //print(medArray)
//            //resultsArray.append("Medications:\n\(medicationView.string)")
//            resultsArray.append("Prescribed this visit:\n\(medArray.map {$0.prependCharacter("~~")}.joined(separator: "\n"))")
//        }
        let filteredResultsArray = resultsArray.filter{!$0.isEmpty}
        let results = filteredResultsArray.joined(separator: "\n")
        
        theData.plan.addToExistingText(results)
        if results.contains("1111F") {
            theData.assessment.addToExistingText("1111F", withSpace: false)
        }
        if results.contains("1101F") {
            theData.assessment.addToExistingText("1101F", withSpace: false)
        }
        if results.contains("3288F") {
            theData.assessment.addToExistingText("3288F", withSpace: false)
        }
        if !objectiveResults.isEmpty {
            theData.objective.addToExistingText(objectiveResults)
        }
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
    
    
private func getPrevDataFrom(_ source:String) -> String {
    var preventiveResultsArray = [String]()
    let preventiveArray = source.components(separatedBy: "\n")
    for measure in preventiveArray {
        let dates = measure.allRegexMatchesFor("(\\d*/\\d*/\\d*|\\d+/\\d+)")
        let heading = measure.simpleRegExMatch("^\\w* -|^\\w*-|^\\w* \\w* -|^\\w* \\w*-")
        
        //print(heading)
        //print(dates)
        
        if let sortedDates = getDateFromString(dates)?.sorted() {
            if let last = sortedDates.last {
                //format the date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                preventiveResultsArray.append("\(heading) \(dateFormatter.string(from: last))")
                //print("\(heading) \(dateFormatter.string(from: last))")
            } else {
                preventiveResultsArray.append("\(heading) no last date found")
                //print("\(heading) no last date found")
            }
            
        }
    }
    return preventiveResultsArray.joined(separator: "\n")
    
}
    
    func setFontSizeOf(_ size: CGFloat, forFields textFields: [NSTextView]) {
        let theUserFont:NSFont = NSFont.systemFont(ofSize: size)
        let fontAttributes = NSDictionary(object: theUserFont, forKey: kCTFontAttributeName as! NSCopying)
        //let fontAttributes = NSDictionary(object: theUserFont, forKey: NSFontAttributeName as NSCopying)
        for field in textFields {
            field.typingAttributes = fontAttributes as! [NSAttributedString.Key : Any]
        }
    }
    
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
    
    @IBAction func getUpAndGoSelection(_ sender:NSButton) {
        let boxes = preventiveView.getListOfButtons()
        let activeBoxTag = sender.tag
        for box in boxes {
            if box.tag != activeBoxTag {
                box.state = .off
            }
        }
    }
    
    @IBAction func abnormalPE(_ sender:NSButton) {
        let boxes = snippetReviewView.getListOfButtons()
        for box in boxes {
            if (box.tag > 59) && (box.title != sender.title) {
                box.state = .off
            }
        }
    }
}
