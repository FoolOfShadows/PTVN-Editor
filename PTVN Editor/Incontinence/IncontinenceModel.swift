//
//  IncontinenceModel.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 8/9/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

enum Question:String {
	case DayFrequency = "Daytime urination frequency of "
	case NightFrequency = "Nighttime urination frequency of "
	case Rush =  "Needing to rush to the toilet to urinate "
	case Leak =  "Urine leaking before getting to the toilet "
}


func processQuestion(question: Question, answers: [NSButton], bothered: [NSButton]) -> String {
	var results = String()
	var theAnswer = String()
	var bother = String()
	
	for answer in answers {
		if answer.state == .on {
			theAnswer = question.rawValue + answer.title
		}
	}
	for amount in bothered {
		if amount.state == .on {
			bother = " and is bothered \(amount.title) out of 4"
		}
	}
	
	if !theAnswer.isEmpty && !bother.isEmpty {
		results = "\(theAnswer)\(bother)"
	}
	
	
	
	return results
}

