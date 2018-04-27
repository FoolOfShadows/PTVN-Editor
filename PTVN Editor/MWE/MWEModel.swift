//
//  MWEModel.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 8/2/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

class VisualAcuity {
	var leftEyeVision:NSTextField?
	var rightEyeVision:NSTextField?
	var glasses:NSButton
	var contacts:NSButton
	
	init(leftEye:NSTextField, rightEye:NSTextField, glasses:NSButton, contacts:NSButton) {
		self.leftEyeVision = leftEye
		self.rightEyeVision = rightEye
		self.glasses = glasses
		self.contacts = contacts
	}
	
	func processAcuity() -> String {
		var resultsArray = [String]()
		var results = String()
		
		if let leftVision = leftEyeVision?.stringValue {
			if !leftVision.isEmpty {
				resultsArray.append("Left eye is 20/\(leftVision)")
			}
		}
		if let rightVision = rightEyeVision?.stringValue {
			if !rightVision.isEmpty {
				resultsArray.append("Right eye is 20/\(rightVision)")
			}
		}
		
		if glasses.state == .on {
			resultsArray.append("Patient wears glasses.")
		}
		if contacts.state == .on {
			resultsArray.append("Patient wears contact lenses.")
		}
		
		if !resultsArray.isEmpty {
			results = "Patient's visual acuity:\n\(resultsArray.joined(separator: "\n"))"
		}
		return results
	}
	
	func clearAcuity() {
		leftEyeVision?.stringValue = String()
		rightEyeVision?.stringValue = String()
		glasses.state = .off
		contacts.state = .off
	}
}

class Hearing {
	var hearingDifficultiesYes:NSButton
	var hearingDifficultiesNo:NSButton
	var whisperLeftPass:NSButton
	var whisperLeftFail:NSButton
	var whisperRightPass:NSButton
	var whisperRightFail:NSButton
	
	init(difficultiesYes:NSButton, difficultiesNo:NSButton, leftPass:NSButton, leftFail:NSButton, rightPass:NSButton, rightFail:NSButton) {
		self.hearingDifficultiesYes = difficultiesYes
		self.hearingDifficultiesNo = difficultiesNo
		self.whisperLeftPass = leftPass
		self.whisperLeftFail = leftFail
		self.whisperRightPass = rightPass
		self.whisperRightFail = rightFail
	}
	
	func processHearing() -> String {
		var results = String()
		var resultArray = [String]()
		
		if hearingDifficultiesYes.state == .on {
			resultArray.append("Patient reports hearing difficulties.")
		} else if hearingDifficultiesNo.state == .on {
			resultArray.append("Patient reports no hearing difficulties.")
		}
		
		var whisperArray = [String]()
		if whisperLeftPass.state == .on {
			whisperArray.append("left ear passed")
		} else if whisperLeftFail.state == .on {
			whisperArray.append("left ear failed")
		}
		if whisperRightPass.state == .on {
			whisperArray.append("right ear passed")
		} else if whisperRightFail.state == .on {
			whisperArray.append("right ear failed")
		}
		
		if !whisperArray.isEmpty {
			let whisperResults = "Whisper test results: \(whisperArray.joined(separator: ", "))"
			resultArray.append(whisperResults)
		}
		
		if !resultArray.isEmpty {
			results = resultArray.joined(separator: "\n")
		}
		
		return results
	}
	
	func clearHearing() {
		hearingDifficultiesYes.state = .off
		hearingDifficultiesNo.state = .off
		whisperLeftPass.state = .off
		whisperLeftFail.state = .off
		whisperRightPass.state = .off
		whisperRightFail.state = .off
	}
}

class PHQ2Screen {
	var feelingDownYes:NSButton
	var feelingDownNo:NSButton
	var littleInterestYes:NSButton
	var littleInterestNo:NSButton
	
	init(downYes:NSButton, downNo:NSButton, interestYes:NSButton, interestNo:NSButton) {
		self.feelingDownYes = downYes
		self.feelingDownNo = downNo
		self.littleInterestYes = interestYes
		self.littleInterestNo = interestNo
	}
	
	func processPHQ2() -> String {
		var resultsArray = [String]()
		var results = String()
		
		if feelingDownYes.state == .on {
			resultsArray.append("During the past month, have you often been bothered by feeling down, depressed, or hopeless. - YES")
		} else if feelingDownNo.state == .on {
			resultsArray.append("During the past month, have you often been bothered by feeling down, depressed, or hopeless. - NO")
		}
		
		if littleInterestYes.state == .on {
			resultsArray.append("During the past month, have you often been bothered by little interest or pleasure in doing things. - YES")
		} else if littleInterestNo.state == .on {
			resultsArray.append("During the past month, have you often been bothered by little interest or pleasure in doing things. - NO")
		}
		
		if !resultsArray.isEmpty {
			results = "PHQ-2 Depression Screen:\n\(resultsArray.joined(separator: "\n"))"
		}
		
		return results
	}
	
	func clearPHQ2() {
		feelingDownYes.state = .off
		feelingDownNo.state = .off
		littleInterestYes.state = .off
		littleInterestNo.state = .off
	}
}

class AdvanceDirective {
	var want:NSButton
	var notWant:NSButton
	var notSure:NSButton
	var agree:NSButton
	var disagree:NSButton
	
	init(want:NSButton, notWant:NSButton, notSure:NSButton, agree:NSButton, disagree:NSButton) {
		self.want = want
		self.notWant = notWant
		self.notSure = notSure
		self.agree = agree
		self.disagree = disagree
	}
	
	func processAdvanceDirective() -> String {
		var results = String()
		var ptResults = String()
		var drResults = String()
		
		if want.state == .on {
			ptResults = "Patient expresses the desire to create an advance directive."
		} else if notWant.state == .on {
			ptResults = "Patient does not wish to create an advance directive at this time."
		} else if notSure.state == .on {
			ptResults = "Patient is unsure about creating an advance directive at this time."
		}
		
		if agree.state == .on {
			drResults = "I agree with the patient's decision."
		} else if disagree.state == .on {
			drResults = "I disagree with the patient's decision."
		}
		
		if !ptResults.isEmpty {
			results = ptResults
			if !drResults.isEmpty {
				results = results + "  \(drResults)"
			}
		}
		
		return results
	}
	
}

func processButtons(buttons:[NSButton], verbiage:[String]) -> String {
	var finalString = String()
	var stringArray = [String]()
	
	for (index, button) in buttons.enumerated() {
		if button.state == .on {
			stringArray.append(verbiage[index])
		}
	}
	
	if !stringArray.isEmpty {
		finalString = stringArray.joined(separator: "\n")
	}
	
	return finalString
}

func processTextFields(fields:[NSTextField], verbiage:[String]) -> String {
	var finalString = String()
	var stringArray = [String]()
	
	for (index, field) in fields.enumerated() {
		if field.stringValue != "" {
			stringArray.append(verbiage[index])
		}
	}
	
	if !stringArray.isEmpty {
		finalString = stringArray.joined(separator: "\n")
	}
	
	return finalString
	
}

func clearControllersOnWWEForm(buttons:[NSButton], fields:[NSTextField]) {
	for button in buttons {
		button.state = .off
	}
	for field in fields {
		field.stringValue = String()
	}
}
