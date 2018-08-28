//
//  PainViewController.swift
//  LIROS
//
//  Created by Fool on 12/1/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class PainViewController: NSViewController {

	@IBOutlet var painTabView: NSView!
	@IBOutlet weak var locationBox: NSBox!
	@IBOutlet weak var qualityBox: NSBox!
	@IBOutlet weak var timingBox: NSBox!
	@IBOutlet weak var modifyingFactorsBox: NSBox!
	@IBOutlet weak var associatedSymptomsBox: NSBox!
	@IBOutlet weak var functionBox: NSBox!
	
	@IBOutlet weak var locationView: NSTextField!
	
	@IBOutlet weak var durationQtyView: NSTextField!
	@IBOutlet weak var durationPeriodPopup: NSPopUpButton!
	
	@IBOutlet weak var severityAmountView: NSTextField!
	@IBOutlet weak var severityEstimationPopup: NSPopUpButton!
	
	@IBOutlet weak var contextStatusPopup: NSPopUpButton!
	@IBOutlet weak var contextCauseView: NSTextField!
	
	@IBOutlet weak var medsView: NSTextField!
	
	@IBOutlet weak var mobileWithPopup: NSPopUpButton!
	
	@IBOutlet weak var qolMeasurePopup: NSPopUpButton!
	@IBOutlet weak var qolCommentsView: NSTextField!
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
	let nc = NotificationCenter.default
	
	override func viewDidLoad() {
        super.viewDidLoad()
        clearPain(self)
    }
	
	

	
	
	@IBAction func clearPain(_ sender: Any) {
		painTabView.clearControllers()
		mobileWithPopup.clearPopUpButton(menuItems: mobilityList)
		durationPeriodPopup.clearPopUpButton(menuItems: durationList)
		severityEstimationPopup.clearPopUpButton(menuItems: painSeverityList)
		contextStatusPopup.clearPopUpButton(menuItems: painContextList)
		qolMeasurePopup.clearPopUpButton(menuItems: qolList)
	}
	
	@IBAction func processPain(_ sender: Any) {
		let locationResults = Location().processSectionData(getButtonsIn(view: locationBox))
		let durationResults = getDurationInfo()
		let severityResults = getSeverityInfo()
		let qualityResults = Quality().processSectionData(getButtonsIn(view: qualityBox))
		let timingResults = Timing().processSectionData(getButtonsIn(view: timingBox))
		let contextResults = getContextInfo()
		let modifyingFactorResults = ModifyingFactors().processSectionData(getButtonsIn(view: modifyingFactorsBox))
		let associatedSymptoms = AssociatedSymptoms().processSectionData(getButtonsIn(view: associatedSymptomsBox))
		let functionResults = Function().processSectionData(getButtonsIn(view: functionBox))
		let qolResults = getQOLInfo()
		let fullResults = [locationResults, durationResults, severityResults, qualityResults, timingResults, contextResults, modifyingFactorResults, associatedSymptoms, functionResults, qolResults]
		let filteredResults = fullResults.filter {!$0.isEmpty}
		
        theData.subjective.addToExistingText(filteredResults.joined(separator: "\n"))
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)

	}
	
//    @IBAction func processPainAndContinue(_ sender: Any) {
//        processPain(self)
//        TrackingTabs.newTab = 4
//        nc.post(name: NSNotification.Name("SwitchTabs"), object: nil)
//        processAndContinue()
//    }
	
	func getDurationInfo() -> String {
		var results = String()
		if !durationQtyView.stringValue.isEmpty && durationPeriodPopup.titleOfSelectedItem != "" {
			results = "Duration: \(durationQtyView.stringValue) \(durationPeriodPopup.titleOfSelectedItem!)"
		}
		return results
	}
	
	func getSeverityInfo() -> String {
		var results = String()
		if !severityAmountView.stringValue.isEmpty {
			results = "Severity: \(severityAmountView.stringValue)/10."
		} else if severityEstimationPopup.titleOfSelectedItem != "" {
			results = "Severity: \(severityEstimationPopup.titleOfSelectedItem!)."
		}
		return results
	}
	
	func getContextInfo() -> String {
		var results = [String]()
		var result = String()
		if contextStatusPopup.titleOfSelectedItem != "" {
			results.append("Current status is \(contextStatusPopup.titleOfSelectedItem!)")
		}
		if !contextCauseView.stringValue.isEmpty {
			results.append("Cause: \(contextCauseView.stringValue)")
		}
		
		if !results.isEmpty {
			result = "Context: \(results.joined(separator: "\n"))"
		}
		return result
	}
	
	func getQOLInfo() -> String {
		var resultsArray = [String]()
		var result = String()
		if qolMeasurePopup.titleOfSelectedItem != "" {
			resultsArray.append(qolMeasurePopup.titleOfSelectedItem!)
		}
		if !qolCommentsView.stringValue.isEmpty {
			resultsArray.append(qolCommentsView.stringValue)
		}
		if !resultsArray.isEmpty {
			result = "Quality of life: \(resultsArray.joined(separator: ", "))"
		}
		
		return result
	}
}
