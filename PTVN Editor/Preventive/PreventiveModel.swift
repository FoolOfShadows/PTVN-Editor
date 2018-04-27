//
//  PreventiveModel.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 8/17/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

class PreventiveMeasure {
	var measure: String
	var suggestedDate: NSTextField
	var notDue: NSButton
	
	init(measure: String, date:NSTextField, notDue:NSButton) {
		self.measure = measure
		self.suggestedDate = date
		self.notDue = notDue
	}
	
	func processMeasure() -> String {
		var result = String()
		
		if self.suggestedDate.stringValue != "" {
			result = "\(self.measure): \(self.suggestedDate.stringValue)."
		} else if self.notDue.state == NSOnState {
			result = "\(self.measure): not due."
		}
		
		return result
	}
	
	func clearMeasure() {
		suggestedDate.stringValue = String()
		notDue.state = NSOffState
	}
	
}

func processMeasures(measures:[PreventiveMeasure]) -> String {
	var resultString = String()
	var resultArray = [String]()
	
	for measure in measures {
		let measureResults = measure.processMeasure()
		if !measureResults.isEmpty {
			resultArray.append(measureResults)
		}
	}
	
	if !resultArray.isEmpty {
		resultString = "Suggested preventive measures for the coming year:\n\(resultArray.joined(separator: "\n"))"
	}
	
	return resultString
}

func processClearMeasures(measures:[PreventiveMeasure]) {
	for measure in measures {
		measure.clearMeasure()
	}
}
