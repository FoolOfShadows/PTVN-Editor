//
//  DoctorViewController.swift
//  LIROS
//
//  Created by Fool on 10/20/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

//Protocol to set up for accepting data back from the CurrentAssessmentController
protocol assessmentTableDelegate: class {
    func currentAssessmentWillBeDismissed(sender: CurrentAssessmentController)
}

class DoctorViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate, assessmentTableDelegate {

    @IBOutlet var doctorTabView: NSView!
    @IBOutlet weak var dataReviewView: NSBox!
    @IBOutlet weak var labView: NSBox!
    @IBOutlet weak var proceduresView: NSBox!
    @IBOutlet weak var educationView: NSBox!
    @IBOutlet weak var injectionsView: NSBox!
    @IBOutlet weak var commonMedsPopup: NSPopUpButton!
    @IBOutlet weak var medicationView: NSTextField!
    @IBOutlet weak var arthPopup: NSPopUpButton!
    @IBOutlet weak var synvPopup: NSPopUpButton!
    @IBOutlet weak var assessmentTableView: NSTableView!
    
	@IBOutlet weak var visitLevelStack: NSStackView!
	
	var assessmentString = String()
    var assessmentList = [String]()
    
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
        self.assessmentTableView.delegate = self
        self.assessmentTableView.dataSource = self
        clearDrTab(self)
    }
    
    @IBAction func addMed(_ sender: Any) {
        if !commonMedsPopup.titleOfSelectedItem!.isEmpty {
            let currentMeds = medicationView.stringValue
            medicationView.stringValue = commonMedsPopup.titleOfSelectedItem! + "\n" + currentMeds
        }
    }
    
    @IBAction func clearDrTab(_ sender: Any) {
        doctorTabView.clearControllers()
        commonMedsPopup.clearPopUpButton(menuItems: commonMedsList)
        arthPopup.clearPopUpButton(menuItems: jointList)
        synvPopup.clearPopUpButton(menuItems: kneeList)
        assessmentList = [String]()
		self.assessmentTableView.reloadData()
    }
    
    @IBAction func returnResults(_ sender:Any) {
        let dataReviewResults = DataReview().processSectionData(getDataFromView(dataReviewView))
        let labViewResults = Lab().processSectionData(getDataFromView(labView))
        let proceduresResults = Procedures().processProceduresUsing(getDataFromView(proceduresView))
        let educationResults = Education().processSectionData(getDataFromView(educationView))
        let injectionResults = Injections().processInjectionsUsing(getDataFromView(injectionsView))
        
        var resultsArray = [dataReviewResults, labViewResults, proceduresResults, educationResults, injectionResults]
        
        if !medicationView.stringValue.isEmpty {
            resultsArray.append("Medications:\n\(medicationView.stringValue)")
        }
        let filteredResultsArray = resultsArray.filter{!$0.isEmpty}
        let results = filteredResultsArray.joined(separator: "\n")
        
        theData.subjective.addToExistingText(results)
        
        let firstVC = presenting as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
    }
    
    //MARK: Table Handling Functions
    func numberOfRows(in tableView: NSTableView) -> Int {
        return assessmentList.count
    }
    
    //Set up the tableview with the data from the assessmentList array
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result:NSTableCellView
        result = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as! NSTableCellView
        result.textField?.stringValue = assessmentList[row]
        
        return result
    }
    
    @IBAction func getMedsFromFile(_ sender: NSButton) {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = true
        panel.allowedFileTypes = ["txt"]
        
        panel.beginSheetModal(for: self.view.window!, completionHandler: {(returnCode) -> Void in
            if returnCode == NSApplication.ModalResponse.OK {
                let message = panel.url?.path
                self.assessmentString = self.processAssessmentFromNoteAt(message)
                self.performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "showCurrentAssessment"), sender: nil)
            }
        })
        
        
    }
    
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
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier!.rawValue == "showCurrentAssessment" {
            if let toViewController = segue.destinationController as? CurrentAssessmentController {
                //For the delegate to work, it needs to be assigned here
                //rather than in view did load.  Because it's a modal window?
                toViewController.assessmentReloadDelegate = self
                toViewController.assessmentString = assessmentString
            }
        }
    }
    
    //When the modal window dismisses, it needs to tell the main view to update
    //the assessment table with the data it passes back using delegation
    func currentAssessmentWillBeDismissed(sender: CurrentAssessmentController) {
        self.assessmentTableView.reloadData()
    }
    
	@IBAction func processAssessmentTable(_ sender: Any) {
		
		let results = Assessment().processAssessmentUsingArray(assessmentList, and: visitLevelStack.getListOfButtons().filter {$0.state == .on}.map {$0.title})
		
		let myPasteboard = NSPasteboard.general
		myPasteboard.clearContents()
		myPasteboard.setString(results, forType: NSPasteboard.PasteboardType.string)
	}
    
    //Adds a blank line to the table and selects it, also adding a corresponding
    //empty string item to the data source array
    @IBAction func addMedToTable(_ sender: NSButton) {
        //Add the info from the textfield to the medList array
        assessmentList.insert("", at: 0)
        //Add the new info into the tableView (not sure exactly how this works)
        assessmentTableView.insertRows(at: IndexSet(integer: 0), withAnimation: NSTableView.AnimationOptions.slideDown)
        assessmentTableView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
        
    }
    
    //Attached to the table's Table Cell View prototype via the classes First Responder
    //updates the data source array with any changes made to the table items.
    @IBAction func updateArrayWithEdit(_ sender:Any) {
        let currentRow = assessmentTableView.row(for: sender as! NSView)
        print(currentRow)
        
        if let textField = sender as? NSTextField {
            let textValue = textField.stringValue
            assessmentList.remove(at: currentRow)
            assessmentList.insert(textValue, at: currentRow)
        }
        
        
    }
        
    //Removes the selected row from the table and the corresponding
    //item from the data source array
    @IBAction func removeRowFromTable(_ sender: NSButton) {
        let row = assessmentTableView.selectedRow
        if row != -1 {
            assessmentList.remove(at: row)
            let indexSet = IndexSet(integer:row)
            assessmentTableView.removeRows(at:indexSet, withAnimation:NSTableView.AnimationOptions.effectFade)
        }
    }
	
	@IBAction func onlyOneCheckAtATime(_ sender:NSButton) {
		let boxes = visitLevelStack.getListOfButtons()
		for box in boxes {
			if box.title != sender.title {
				box.state = .off
			}
		}
	}
}
