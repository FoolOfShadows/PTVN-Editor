//
//  MWEController.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 8/2/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

class MWEController: NSViewController {
	
	@IBOutlet weak var visualAcuityLeftView: NSTextField!
	@IBOutlet weak var visualAcuityRightView: NSTextField!
	@IBOutlet weak var glassesView: NSButton!
	@IBOutlet weak var contactsView: NSButton!
	@IBOutlet weak var hearingDifficultiesYesCheckbox: NSButton!
	@IBOutlet weak var hearingDifficultiesNoCheckbox: NSButton!
	@IBOutlet weak var hearingLeftPassCheckbox: NSButton!
	@IBOutlet weak var hearingLeftFailCheckbox: NSButton!
	@IBOutlet weak var hearingRightPassCheckbox: NSButton!
	@IBOutlet weak var hearingRightFailCheckbox: NSButton!
	@IBOutlet weak var getUpAndGoYesCheckbox: NSButton!
	@IBOutlet weak var getUpAndGoNoCheckbox: NSButton!
	@IBOutlet weak var rugsYesCheckbox: NSButton!
	@IBOutlet weak var rugsNoCheckbox: NSButton!
	@IBOutlet weak var depressedYesCheckbox: NSButton!
	@IBOutlet weak var depressedNoCheckbox: NSButton!
	@IBOutlet weak var littleInterestYesCheckbox: NSButton!
	@IBOutlet weak var littleInterestNoCheckbox: NSButton!
	@IBOutlet weak var adDirWantsCheckbox: NSButton!
	@IBOutlet weak var adDirDoesNotWantCheckbox: NSButton!
	@IBOutlet weak var adDirNotSureCheckbox: NSButton!
	@IBOutlet weak var adDirAgreesCheckbox: NSButton!
	@IBOutlet weak var adDirDisagreesCheckbox: NSButton!
	@IBOutlet weak var smokingCounseling3to10: NSButton!
	@IBOutlet weak var smokingCounselingGreaterThan10: NSButton!
	
	
	@IBOutlet weak var caregiverInputView: NSTextField!
	
	var buttonsArray: [NSButton] {return [getUpAndGoYesCheckbox, getUpAndGoNoCheckbox, rugsYesCheckbox, rugsNoCheckbox]}
	let buttonVerbiageArray: [String] = ["Get Up & Go test was unsteady or took longer than 30 seconds.", "Get Up & Go test was steady and took less than 30 seconds.", "The patient's home has rugs in the hallway, lacks grab bars in the bathroom, lacks handrails on the stars or has poor lighting.", "The patient's home does not have rugs in the hallway, lack grab bars in the bathroom, lack handrails on the stars or have poor lighting."]
	var textArray: [NSTextField] {return [caregiverInputView]}
	var textVerbiage: [String] {return ["Patient family/caregiver input:\(caregiverInputView.stringValue)."]}
	
	var visualAcuity:VisualAcuity {return VisualAcuity(leftEye: visualAcuityLeftView, rightEye: visualAcuityRightView, glasses: glassesView, contacts: contactsView)}
	var hearingAssessment:Hearing {return Hearing(difficultiesYes: hearingDifficultiesYesCheckbox, difficultiesNo: hearingDifficultiesNoCheckbox, leftPass: hearingLeftPassCheckbox, leftFail: hearingLeftFailCheckbox, rightPass: hearingRightPassCheckbox, rightFail: hearingRightFailCheckbox)}
	var advancedDirective:AdvanceDirective {return AdvanceDirective(want: adDirWantsCheckbox, notWant: adDirDoesNotWantCheckbox, notSure: adDirNotSureCheckbox, agree: adDirAgreesCheckbox, disagree: adDirDisagreesCheckbox)}
	var phq2Screening:PHQ2Screen {return PHQ2Screen(downYes: depressedYesCheckbox, downNo: depressedNoCheckbox, interestYes: littleInterestYesCheckbox, interestNo: littleInterestNoCheckbox)}
	
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
//    override func awakeFromNib() {
//        clearWWEForm(self)
//    }
	
	@IBAction func processWWEForm(_ sender: NSButton) {
		var finalResultsArray = [String]()
		var finalResults = String()
		
		let visionResults = visualAcuity.processAcuity()
		if !visionResults.isEmpty {
			finalResultsArray.append(visionResults)
		}
		
		let hearingResults = hearingAssessment.processHearing()
		if !hearingResults.isEmpty {
			finalResultsArray.append(hearingResults)
		}
		
		let buttonResults = processButtons(buttons: buttonsArray, verbiage: buttonVerbiageArray)
		if !buttonResults.isEmpty {
			finalResultsArray.append(buttonResults)
		}
		
		let phq2Results = phq2Screening.processPHQ2()
		if !phq2Results.isEmpty {
			finalResults.append(phq2Results)
		}
		
		let directiveResults = advancedDirective.processAdvanceDirective()
		if !directiveResults.isEmpty {
			finalResultsArray.append(directiveResults)
		}
		
		if caregiverInputView.stringValue != "" {
			finalResultsArray.append("Input from patient's family/caregiver:\n \(caregiverInputView.stringValue)")
		}
		
		if !finalResultsArray.isEmpty {
			finalResults = finalResultsArray.joined(separator: "\n")
		}
		
        let pasteBoard = NSPasteboard.general
		pasteBoard.clearContents()
        pasteBoard.setString(finalResults, forType: NSPasteboard.PasteboardType.string)
		Swift.print(finalResults)
	}
	
	@IBAction func clearWWEForm(_ sender: AnyObject) {
		visualAcuity.clearAcuity()
		hearingAssessment.clearHearing()
		phq2Screening.clearPHQ2()
		clearControllersOnWWEForm(buttons: buttonsArray, fields: textArray)
	}
}
