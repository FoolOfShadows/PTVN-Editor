//
//  ESSModel.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 11/1/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Foundation

enum AnswerValues:Int {
	case never = 0
	case slight
	case moderate
	case high
	
	var essAnswerString:String {
		switch self {
		case .never: return "Would never doze."
		case .slight: return "Slight chance of dozing."
		case .moderate: return "Moderate chance of dozing."
		case .high: return "High chance of dozing."
		}
	}
}

enum QuestionValues:String {
	case sitting = "Sitting and reading:"
	case tv = "Watching television:"
	case inPublic = "Sitting inactive in a public place:"
	case passenger = "As a passenger in a care:"
	case lying = "Lying down to rest:"
	case talking = "Sitting and talking to someone:"
	case afterLunch = "Sitting quietly after lunch:"
	case car = "In a car, while stopped in traffic:"
}

