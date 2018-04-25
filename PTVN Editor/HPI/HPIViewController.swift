//
//  HPIViewController.swift
//  LIROS
//
//  Created by Fool on 11/7/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class HPIViewController: NSViewController {

	@IBOutlet var hpiView: NSView!
	@IBOutlet weak var complaintsBox: NSBox!
	@IBOutlet weak var uriBox: NSBox!
	@IBOutlet weak var utiBox: NSBox!
	@IBOutlet weak var chestPainBox: NSBox!
	@IBOutlet weak var htnBox: NSBox!
	@IBOutlet weak var cholesterolBox: NSBox!
	@IBOutlet weak var noProblemsCheckbox: NSButton!
	
	//@IBOutlet weak var onsetView: NSTextField!
	@IBOutlet weak var phlegmColorCombo: NSComboBox!
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
	let nc = NotificationCenter.default
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		phlegmColorCombo.clearComboBox(menuItems: phlegmColors)
    }
	
	override func viewDidAppear() {
		super.viewDidAppear()
		addSelectorToButtonsInView(complaintsBox)
		addSelectorToButtonsInView(uriBox)
		addSelectorToButtonsInView(utiBox)
		addSelectorToButtonsInView(chestPainBox)
		addSelectorToButtonsInView(htnBox)
		addSelectorToButtonsInView(cholesterolBox)
	}
	
	func getTextFieldsFrom(_ view:NSView) -> [NSTextField] {
		var results = [NSTextField]()
		for item in view.subviews {
			if item is NSTextField && (item as! NSTextField).isEditable {
				results.append((item as! NSTextField))
			} else {
				results += getTextFieldsFrom(item)
			}
		}
		return results
	}
	
	func getListOfButtons(_ view:NSView) -> [NSButton] {
		var results = [NSButton]()
		for item in view.subviews {
			if item is NSButton {
				results.append((item as? NSButton)!)
			} else {
				results += getListOfButtons(item)
			}
		}
		//print(results)
		return results
	}
	
	func getTitlesOfActiveButtonsFrom(_ view:NSView) ->(title: String, positives: [String], negatives: [String]) {
		var positiveResults = [String]()
		var negativeResults = [String]()
		var title = String()
		if getTextFieldsFrom(view)[0].stringValue != "" {
			title = getTextFieldsFrom(view)[0].stringValue
		}
		let activeButtons = getListOfButtons(view).filter {$0.state != .off}
		for button in activeButtons {
			if button.state == .mixed {
				positiveResults.append(button.title.lowercased())
			} else if button.state == .on {
				negativeResults.append(button.title.lowercased())
			}
		}
		
		if !phlegmColorCombo.stringValue.isEmpty {
			func addendColorToPhlegmIn(_ result:inout [String]) {
				for (index, item) in result.enumerated() {
					if item == "phlegm" {
						result[index] = "\(phlegmColorCombo.stringValue) colored phlegm"
					}
				}
			}
			addendColorToPhlegmIn(&positiveResults)
			//addendColorToPhlegmIn(&negativeResults)
		}
		
		
		
		
		return (title:title, positives:positiveResults, negatives:negativeResults)
	}
	
	@IBAction func clearHPI(_ sender: Any) {
		hpiView.clearControllers()
		phlegmColorCombo.clearComboBox(menuItems: phlegmColors)
	}
	
	@IBAction func processHPI(_ sender: Any) {
		var resultsArray = [String]()
		var results = String()
		//process Complaints box
		resultsArray.append(processHPISection(.symptoms, usingData: getTitlesOfActiveButtonsFrom(complaintsBox)))
		resultsArray.append(processHPISection(.uti, usingData: getTitlesOfActiveButtonsFrom(utiBox)))
		resultsArray.append(processHPISection(.uri, usingData: getTitlesOfActiveButtonsFrom(uriBox)))
		resultsArray.append(processHPISection(.chestpain, usingData: getTitlesOfActiveButtonsFrom(chestPainBox)))
		resultsArray.append(processHPISection(.htn, usingData: getTitlesOfActiveButtonsFrom(htnBox)))
		resultsArray.append(processHPISection(.hichol, usingData: getTitlesOfActiveButtonsFrom(cholesterolBox)))
//		if noProblemsCheckbox.state == .on {
//			resultsArray.append("Patient reports no new problems or concerns today.")
//		}
		
		let hpiResults = resultsArray.filter {$0 != ""}
		if !hpiResults.isEmpty {
			results = hpiResults.joined(separator: "\n")
		}  else if noProblemsCheckbox.state == .on {
			results = "Patient reports no new problems or concerns today."
		}
        
        theData.subjective.addToExistingText(results)
        
        let firstVC = presenting as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
		
	}
	
	@IBAction func noOtherSelectionsActive(_ sender: NSButton) {
		if sender.state == .on {
		complaintsBox.clearControllers()
		uriBox.clearControllers()
		utiBox.clearControllers()
		chestPainBox.clearControllers()
		htnBox.clearControllers()
		cholesterolBox.clearControllers()
		phlegmColorCombo.clearComboBox(menuItems: phlegmColors)
		}
	}
	
	func addSelectorToButtonsInView(_ view:NSView) {
		for item in view.subviews {
			if let button = item as? NSButton {
				button.target = self
				button.action = #selector(deselectNoProblems)
			} else {
				addSelectorToButtonsInView(item)
			}
		}
	}
	
	@objc func deselectNoProblems(_ sender:NSButton) {
		if sender.state != .off {
		noProblemsCheckbox.state = .off
		}
	}
	
//    @IBAction func processHPIAndContinue(_ sender: Any) {
//        processHPI(self)
//        TrackingTabs.newTab = 2
//        nc.post(name: NSNotification.Name("SwitchTabs"), object: nil)
//        processAndContinue()
//    }
}
