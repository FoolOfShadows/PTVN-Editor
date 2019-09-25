//
//  PainViewController.swift
//  LIROS
//
//  Created by Fool on 12/1/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

protocol PillCountDelegate: class {
    var pillCountData:String { get set }
    var ptName:String { get set }
}

class PainViewController: NSViewController, NSTextFieldDelegate, NSTextDelegate, NSControlTextEditingDelegate, PillCountDelegate {

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
	
	@IBOutlet weak var painSeverityAmountView: NSTextField!
    @IBOutlet weak var painJoyAmountView: NSTextField!
    @IBOutlet weak var painActivityAmountView: NSTextField!
    @IBOutlet weak var pegScoreView: NSTextField!
    
	
	@IBOutlet weak var contextStatusPopup: NSPopUpButton!
	@IBOutlet weak var contextCauseView: NSTextField!
	
	@IBOutlet weak var medsView: NSTextField!
	
	@IBOutlet weak var mobileWithPopup: NSPopUpButton!
	
	@IBOutlet weak var qolMeasurePopup: NSPopUpButton!
	@IBOutlet weak var qolCommentsView: NSTextField!
    
    var pillCountData = String()
    var ptName:String = ""
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
	let nc = NotificationCenter.default
    
//    private var displayedTotal:Double {
//        get {
//            return Double(pegScoreView.stringValue)!
//        }
//        set {
//            pegScoreView.stringValue = String(newValue)
//        }
//    }
	
	override func viewDidLoad() {
        super.viewDidLoad()
        
        painSeverityAmountView.delegate = self
        painJoyAmountView.delegate = self
        painActivityAmountView.delegate = self
        
        clearPain(self)
    }
	
	
    func calculatePEGScore() -> String {
        var painResults = [String]()
        if !painSeverityAmountView.stringValue.isEmpty {
            painResults.append("Pain level over the last week = \(painSeverityAmountView.stringValue)/10")
        }
        if !painJoyAmountView.stringValue.isEmpty {
            painResults.append("Pain interference with enjoyment of life = \(painJoyAmountView.stringValue)/10")
        }
        if !painActivityAmountView.stringValue.isEmpty {
            painResults.append("Pain interference with activity = \(painActivityAmountView.stringValue)/10")
        }
        
        if let weeklyValue = Double(painSeverityAmountView.stringValue), let enjoymentValue = Double(painJoyAmountView.stringValue), let activityValue = Double(painActivityAmountView.stringValue) {
            let totalSum = weeklyValue + enjoymentValue + activityValue
            pegScoreView.stringValue = "\(String(format: "%.1f", totalSum/3))/10"
            painResults.append("PEG PAIN SCORE = \(String(format: "%.1f", totalSum/3))/10")
        }
        
        return painResults.joined(separator: "\n")
    }
    
    func updatePEGView() {
        if let weeklyValue = Double(painSeverityAmountView.stringValue), let enjoymentValue = Double(painJoyAmountView.stringValue), let activityValue = Double(painActivityAmountView.stringValue) {
            let totalSum = weeklyValue + enjoymentValue + activityValue
            print("PEG Score: \(totalSum)")
            pegScoreView.stringValue = "\(String(format: "%.1f", totalSum/3))/10"
        }
    }
    
    @IBAction func takeAverageWeeklySlider(_ sender: NSSlider) {
        painSeverityAmountView.doubleValue = sender.doubleValue
        updatePEGView()
    }
    
    @IBAction func takeEnjoymentSlider(_ sender: NSSlider) {
        painJoyAmountView.doubleValue = sender.doubleValue
        updatePEGView()
    }
    
    @IBAction func takeActivitySlider(_ sender: NSSlider) {
        painActivityAmountView.doubleValue = sender.doubleValue
        updatePEGView()
    }
	
	
	@IBAction func clearPain(_ sender: Any) {
		painTabView.clearControllers()
		mobileWithPopup.clearPopUpButton(menuItems: mobilityList)
		durationPeriodPopup.clearPopUpButton(menuItems: durationList)
		//severityEstimationPopup.clearPopUpButton(menuItems: painSeverityList)
		contextStatusPopup.clearPopUpButton(menuItems: painContextList)
		qolMeasurePopup.clearPopUpButton(menuItems: qolList)
	}
	
	@IBAction func processPain(_ sender: NSButton) {
		let locationResults = Location().processSectionData(getButtonsIn(view: locationBox))
		let durationResults = getDurationInfo()
		let severityResults = calculatePEGScore()
		let qualityResults = Quality().processSectionData(getButtonsIn(view: qualityBox))
		let timingResults = Timing().processSectionData(getButtonsIn(view: timingBox))
		let contextResults = getContextInfo()
		let modifyingFactorResults = ModifyingFactors().processSectionData(getButtonsIn(view: modifyingFactorsBox))
		let associatedSymptoms = AssociatedSymptoms().processSectionData(getButtonsIn(view: associatedSymptomsBox))
		let functionResults = Function().processSectionData(getButtonsIn(view: functionBox))
		let qolResults = getQOLInfo()
		let fullResults = [locationResults, durationResults, severityResults, qualityResults, timingResults, contextResults, modifyingFactorResults, associatedSymptoms, functionResults, qolResults]
		var filteredResults = fullResults.filter {!$0.isEmpty}
        if !pillCountData.isEmpty {
            filteredResults.append(pillCountData)
        }
		
        theData.subjective.addToExistingText(filteredResults.joined(separator: "\n"))
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        
        if sender.title == "Process & Continue" {
            FormButtons.formName = "Diabetes"
            self.dismiss(self)
            nc.post(name: NSNotification.Name("SwitchForm"), object: nil)
        } else {
            self.dismiss(self)
        }

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
		if !painSeverityAmountView.stringValue.isEmpty {
			results = "Severity: \(painSeverityAmountView.stringValue)/10."
		} /*else if severityEstimationPopup.titleOfSelectedItem != "" {
			results = "Severity: \(severityEstimationPopup.titleOfSelectedItem!)."
		}*/
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
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let theSegue = segue.identifier {
            switch theSegue {
            case "showPillCount":
                if let toViewController = segue.destinationController as? PillCountVC {
                    ptName = theData.ptName
                    //For the delegate to work, it needs to be assigned here
                    //rather than in view did load.  Because it's a modal window?
                    toViewController.pillCountDelegate = self
                }
            default: return
            }
        }
    }
}
