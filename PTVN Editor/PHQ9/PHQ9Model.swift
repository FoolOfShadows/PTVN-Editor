//
//  PHQ9Model.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 8/3/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

enum QuestionsAndAnswers:String {
	case LittleInterest = "Little interest or pleasure in doing things"
	case FeelingDown = "Feeling down, depressed, or hopeless"
	case TroubleSleeping = "Trouble falling or staying asleep, or sleeping too much"
	case FeelingTired = "Feeling tired or having little energy"
	case PoorAppetite = "Poor appetite or overeating"
	case FeelingBadAboutSelf = "Feeling bad about themselves"
	case TroubleConcentrating = "Trouble concentrating"
	case SpeakingSlowly = "Moving or speaking slowly, or being fidgety and restless"
	case BetterOffDead = "Thoughts that they would be better off dead or of hurting themselves"
}

enum HowOften:Int {
	case NotAtAll = 0
	case SeveralDays
	case MoreThanHalfTheDays
	case NearlyEveryDay
	
	var theString: String {
		switch self {
		case .NotAtAll: return "not at all."
		case .SeveralDays: return "for several days."
		case .MoreThanHalfTheDays: return "for more than half the days."
		case .NearlyEveryDay: return "nearly every day."
		}
	}
}

func createString(question: QuestionsAndAnswers, checkboxes: [NSButton]) -> String {
	var finalString = String()
	var theTag = Int()
	
	for box in checkboxes {
		if box.state == .on {
			theTag = box.tag
		}
	}
	
	if theTag != 0 {
		if let theFrequency = HowOften(rawValue: theTag) {
			finalString = "\(question.rawValue) \(theFrequency.theString)"
			
		}
	}
	return finalString
}

func proccessBigArray(bigArray:[(QuestionsAndAnswers, [NSButton])]) -> String {
	var finalString = String()
	var stringArray = [String]()
	
	for array in bigArray {
		let result = createString(question: array.0, checkboxes: array.1)
		if !result.isEmpty {
			stringArray.append(result)
		}
	}
	
	if !stringArray.isEmpty {
		finalString = "In the last two weeks the patient reports experiencing:\n" + stringArray.joined(separator: "\n")
	}
	
	return finalString
}

func processDifficultyLevel(boxes:[NSButton]) -> String {
	var finalString = String()
	for box in boxes {
		if box.state == .on {
			finalString = "Patient reports their difficulty working, taking care of things at home, or getting along with other people as being: \(box.title)"
		}
	}
	return finalString
}

func setCheckboxesToOff(checkBoxes:[NSButton]) {
	for box in checkBoxes {
		box.state = .off
	}
}
