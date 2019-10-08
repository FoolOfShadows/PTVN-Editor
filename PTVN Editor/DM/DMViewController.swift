//
//  DMViewController.swift
//  LIROS
//
//  Created by Fool on 12/5/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class DMViewController: NSViewController {
	
	@IBOutlet var dmTabView: NSView!
	@IBOutlet weak var complianceBox: NSBox!
	@IBOutlet weak var highBSBox: NSBox!
	@IBOutlet weak var lowBSBox: NSBox!
	@IBOutlet weak var labsBox: NSBox!
	@IBOutlet weak var planBox: NSBox!
	
	@IBOutlet weak var compliancePopup: NSPopUpButton!
	@IBOutlet weak var fbsCombo: NSComboBox!
	
	
	@IBOutlet weak var equipmentDifficultyCheckbox: NSButton!
	@IBOutlet weak var glucometerIssuesPopup: NSPopUpButton!
	
	@IBOutlet weak var vibrationSensePopup: NSPopUpButton!
	@IBOutlet weak var monofilamentCheckbox: NSButton!
	
	@IBOutlet weak var uMalbPopup: NSPopUpButton!
	
	@IBOutlet weak var fbsPlanCombo: NSComboBox!
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
	let nc = NotificationCenter.default
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		clearDiabetesTab()
    }
	
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }

	
	
	@IBAction func clearDMTab(_ sender: Any) {
		clearDiabetesTab()
	}
	
	@IBAction func processDMTab(_ sender: Any) {
		let complianceResults = processCompliance(getButtonsIn(view: complianceBox))
		let lowBSResults = processBSSectionData(getStringsForButtonsIn(view: lowBSBox), forType: "low")
		let highBSResults = processBSSectionData(getStringsForButtonsIn(view: highBSBox), forType: "high")
		let equipmentResults = processEquipmentIssues(difficulty: equipmentDifficultyCheckbox.state.rawValue, glucometer: glucometerIssuesPopup.titleOfSelectedItem!)
		let vibrationResults = processVibrationData(vibration: vibrationSensePopup.titleOfSelectedItem!, monofilament: monofilamentCheckbox.state.rawValue)
		let labResults = processLabsUsing(getButtonsIn(view: labsBox))
		let planResults = processPlanUsing(getButtonsIn(view: planBox))
		
		let allResults = [complianceResults, lowBSResults, highBSResults, equipmentResults, vibrationResults, labResults, planResults]
		
		let filteredResults = allResults.filter {!$0.isEmpty}
		
        theData.subjective.addToExistingText(filteredResults.joined(separator: "\n"))
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
	}
	
//    @IBAction func processDMAndContinue(_ sender: Any) {
//        processDMTab(self)
//        TrackingTabs.newTab = 3
//        nc.post(name: NSNotification.Name("SwitchTabs"), object: nil)
//        processAndContinue()
//    }
	
	func clearDiabetesTab() {
		dmTabView.clearControllers()
		compliancePopup.clearPopUpButton(menuItems: complianceList)
		fbsCombo.clearComboBox(menuItems: checkingFBSList)
		glucometerIssuesPopup.clearPopUpButton(menuItems: glucometerIssuesList)
		vibrationSensePopup.clearPopUpButton(menuItems: vibrationSenseList)
		uMalbPopup.clearPopUpButton(menuItems: umalbList)
		fbsPlanCombo.clearComboBox(menuItems: checkingFBSList)
	}
	
	@IBAction func yesNoExclusive(_ sender: NSButton) {
		let buttons = dmTabView.getListOfButtons()
		if sender.title == "Yes" && sender.state == .on {
			let noButton = buttons.filter {$0.tag == sender.tag + 1}
			noButton[0].state = .off
		} else if sender.title == "No" && sender.state == .on {
			let yesButton = buttons.filter {$0.tag == sender.tag - 1}
			yesButton[0].state = .off
		}
	}
	
	@IBAction func ifNoThenAllOtherBoxesOff(_ sender: NSButton) {
		if let buttons = sender.superview?.subviews {
			for button in buttons {
				if (button as! NSButton).title != sender.title {
					(button as! NSButton).state = .off
				}
			}
		}
	}
	
	@IBAction func ifYesThenNoBoxOff(_ sender: NSButton) {
		if let buttons = sender.superview?.subviews {
			for button in buttons {
				if (button as! NSButton).title == "No" {
					(button as! NSButton).state = .off
				}
			}
		}
	}
}
