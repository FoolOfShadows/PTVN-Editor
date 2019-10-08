//
//  PHQ9Controller.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 8/3/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

class PHQ9Controller: NSViewController {

	@IBOutlet weak var totalView: NSTextField!
	
	@IBOutlet weak var littleInterestNAACB: NSButton!
	@IBOutlet weak var littleInterestSDCB: NSButton!
	@IBOutlet weak var littleInterestMTHTDCB: NSButton!
	@IBOutlet weak var littleInterestNEDCB: NSButton!
	@IBOutlet weak var feelingDownNAACB: NSButton!
	@IBOutlet weak var feelingDownSDCB: NSButton!
	@IBOutlet weak var feelingDownMTHTDCB: NSButton!
	@IBOutlet weak var feelingDownNEDCB: NSButton!
	@IBOutlet weak var troubleSleepingNAACB: NSButton!
	@IBOutlet weak var troubleSleepingSDCB: NSButton!
	@IBOutlet weak var troubleSleepingMTHTDCB: NSButton!
	@IBOutlet weak var troubleSleepingNEDCB: NSButton!
	@IBOutlet weak var feelingTiredNAACB: NSButton!
	@IBOutlet weak var feelingTiredSDCB: NSButton!
	@IBOutlet weak var feelingTiredMTHTDCB: NSButton!
	@IBOutlet weak var feelingTiredNEDCB: NSButton!
	@IBOutlet weak var poorAppetiteNAACB: NSButton!
	@IBOutlet weak var poorAppetiteSDCB: NSButton!
	@IBOutlet weak var poorAppetiteMTHTDCB: NSButton!
	@IBOutlet weak var poorAppetiteNEDCB: NSButton!
	@IBOutlet weak var feelingBadAboutSelfNAACB: NSButton!
	@IBOutlet weak var feelingBadAboutSelfSDCB: NSButton!
	@IBOutlet weak var feelingBadAboutSelfMTHTDCB: NSButton!
	@IBOutlet weak var feelingBadAboutSelfNEDCB: NSButton!
	@IBOutlet weak var troubleConcentratingNAACB: NSButton!
	@IBOutlet weak var troubleConcentratingSDCB: NSButton!
	@IBOutlet weak var troubleConcentratingMTHTDCB: NSButton!
	@IBOutlet weak var troubleConcentratingNEDCB: NSButton!
	@IBOutlet weak var speakingSlowlyNAACB: NSButton!
	@IBOutlet weak var speakingSlowlySDCB: NSButton!
	@IBOutlet weak var speakingSlowlyMTHTDCB: NSButton!
	@IBOutlet weak var speakingSlowlyNEDCB: NSButton!
	@IBOutlet weak var betterOffDeadNAACB: NSButton!
	@IBOutlet weak var betterOffDeadSDCB: NSButton!
	@IBOutlet weak var betterOffDeadMTHTDCB: NSButton!
	@IBOutlet weak var betterOffDeadNEDCB: NSButton!
	@IBOutlet weak var notDifficultCB: NSButton!
	@IBOutlet weak var somewhatDifficultCB: NSButton!
	@IBOutlet weak var veryDifficult: NSButton!
	@IBOutlet weak var extremelyDifficult: NSButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }
	
	@IBAction func littleInterestNAACheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 0)
	}
	@IBAction func littleInterestSDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 1)
	}
	@IBAction func littleInterestMTHTDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 2)
	}
	@IBAction func littleInterestNEDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 3)
	}
	@IBAction func feelingDownNAACheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 0)
	}
	@IBAction func feelingDownSDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 1)
	}
	@IBAction func feelingDownMTHTDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 2)
	}
	@IBAction func feelingDownNEDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 3)
	}
	@IBAction func troubleSleepingNAACheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 0)
	}
	@IBAction func troubleSleepingSDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 1)
	}
	@IBAction func troubleSleepingMTHTDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 2)
	}
	@IBAction func troubleSleepingNEDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 3)
	}
	@IBAction func feelingTiredNAACheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 0)
	}
	@IBAction func feelingTiredSDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 1)
	}
	@IBAction func feelingTiredMTHTDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 2)
	}
	@IBAction func feelingTiredNEDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 3)
	}
	@IBAction func poorAppetiteNAACheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 0)
	}
	@IBAction func poorAppetiteSDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 1)
	}
	@IBAction func poorAppetiteMTHTDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 2)
	}
	@IBAction func poorAppetiteNEDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 3)
	}
	@IBAction func feelingBadAboutSelfNAACheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 0)
	}
	@IBAction func feelingBadAboutSelfSDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 1)
	}
	@IBAction func feelingBadAboutSelfMTHTDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 2)
	}
	@IBAction func feelingBadAboutSelfNEDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 3)
	}
	@IBAction func troubleConcentratingNAACheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 0)
	}
	@IBAction func troubleConcentratingSDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 1)
	}
	@IBAction func troubleConcentratingMTHTDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 2)
	}
	@IBAction func troubleConcentratingNEDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 3)
	}
	@IBAction func speakingSlowlyNAACheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 0)
	}
	@IBAction func speakingSlowlySDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 1)
	}
	@IBAction func speakingSlowlyMTHTDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 2)
	}
	@IBAction func speakingSlowlyNEDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 3)
	}
	@IBAction func betterOffDeadNAACheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 0)
	}
	@IBAction func betterOffDeadSDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 1)
	}
	@IBAction func betterOffDeadMTHTDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 2)
	}
	@IBAction func betterOffDeadNEDCheckBox(_ sender: NSButton) {
		tallyCheckbox(state: sender.state.rawValue, value: 3)
	}
	
	var littleInterestCheckboxArray: [NSButton] {return [littleInterestNAACB, littleInterestSDCB, littleInterestMTHTDCB, littleInterestNEDCB]}
	
	var feelingDownCheckboxArray: [NSButton] {return [feelingDownNAACB, feelingDownSDCB, feelingDownMTHTDCB, feelingDownNEDCB]}
	
	var troubleSleepingCheckboxArray: [NSButton] {return [troubleSleepingNAACB, troubleSleepingSDCB, troubleSleepingMTHTDCB, troubleSleepingNEDCB]}
	
	var feelingTiredCheckboxArray: [NSButton] {return [feelingTiredNAACB, feelingTiredSDCB, feelingTiredMTHTDCB, feelingTiredNEDCB]}
	
	var poorAppetiteCheckboxArray: [NSButton] {return [poorAppetiteNAACB, poorAppetiteSDCB, poorAppetiteMTHTDCB, poorAppetiteNEDCB]}
	
	var feelingBadAboutSelfCheckboxArray: [NSButton] {return [feelingBadAboutSelfNAACB, feelingBadAboutSelfSDCB, feelingBadAboutSelfMTHTDCB, feelingBadAboutSelfNEDCB]}
	
	var troubleConcentratingCheckboxArray: [NSButton] {return [troubleConcentratingNAACB, troubleConcentratingSDCB, troubleConcentratingMTHTDCB, troubleConcentratingNEDCB]}
	
	var speakingSlowlyCheckboxArray: [NSButton] {return [speakingSlowlyNAACB, speakingSlowlySDCB, speakingSlowlyMTHTDCB, speakingSlowlyNEDCB]}
	
	var betterOffDeadCheckboxArray: [NSButton] {return [betterOffDeadNAACB, betterOffDeadSDCB, betterOffDeadMTHTDCB, betterOffDeadNEDCB]}
	
	var howDifficultArray: [NSButton] {return [notDifficultCB, somewhatDifficultCB, veryDifficult, extremelyDifficult]}
	
	private var displayedTotal:Int {
		get {
			return Int(totalView.stringValue)!
		}
		set {
			totalView.stringValue = String(newValue)
		}
	}
	
	private func tallyCheckbox(state:Int, value:Int) {
		var currentValue = displayedTotal
		switch state {
		case 0: currentValue = currentValue - value
		case 1: currentValue = currentValue + value
		default: break
		}
		displayedTotal = currentValue
	}
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
	@IBAction func takeProcess(_ sender: NSButton) {
		var finalResult = "The patient's PHQ-9 score is: \(totalView.stringValue)"
		let bigArray:[(QuestionsAndAnswers, [NSButton])] = [(.LittleInterest, littleInterestCheckboxArray), (.FeelingDown, feelingDownCheckboxArray), (.TroubleSleeping, troubleSleepingCheckboxArray), (.FeelingTired, feelingTiredCheckboxArray), (.PoorAppetite, poorAppetiteCheckboxArray), (.FeelingBadAboutSelf, feelingBadAboutSelfCheckboxArray), (.TroubleConcentrating, troubleConcentratingCheckboxArray), (.SpeakingSlowly, speakingSlowlyCheckboxArray), (.BetterOffDead, betterOffDeadCheckboxArray)]
		
		let resultBigArray = proccessBigArray(bigArray: bigArray)
		if !resultBigArray.isEmpty {
			finalResult = finalResult + "\n\(resultBigArray)"
		}
		
		let resultDifficultyLevel = processDifficultyLevel(boxes: howDifficultArray)
		if !resultDifficultyLevel.isEmpty {
			finalResult = finalResult + "\n\(resultDifficultyLevel)"
		}
		
        theData.objective.addToExistingText(finalResult)
        if !finalResult.isEmpty {
            theData.assessment.addToExistingText("PHQ-9", withSpace: false)
        }
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
	}
	
	@IBAction func takeClear(_ sender: NSButton) {
		setCheckboxesToOff(checkBoxes: littleInterestCheckboxArray)
		setCheckboxesToOff(checkBoxes: feelingDownCheckboxArray)
		setCheckboxesToOff(checkBoxes: troubleSleepingCheckboxArray)
		setCheckboxesToOff(checkBoxes: feelingTiredCheckboxArray)
		setCheckboxesToOff(checkBoxes: poorAppetiteCheckboxArray)
		setCheckboxesToOff(checkBoxes: feelingBadAboutSelfCheckboxArray)
		setCheckboxesToOff(checkBoxes: troubleConcentratingCheckboxArray)
		setCheckboxesToOff(checkBoxes: speakingSlowlyCheckboxArray)
		setCheckboxesToOff(checkBoxes: betterOffDeadCheckboxArray)
		setCheckboxesToOff(checkBoxes: howDifficultArray)
		totalView.stringValue = String()
	}
	
}
