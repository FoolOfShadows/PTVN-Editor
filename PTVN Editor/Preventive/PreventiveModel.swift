//
//  PreventiveModel.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 8/17/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

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
//	for measure in measures {
//		measure.clearMeasure()
//	}
}

func getPrevDataFrom(_ source:String) -> String {
    var preventiveResultsArray = [String]()
    let preventiveArray = source.components(separatedBy: "\n")
    for measure in preventiveArray {
        let dates = measure.allRegexMatchesFor("(\\d*/\\d*/\\d*|\\d+/\\d+)")
        let heading = measure.simpleRegExMatch("^\\w* -|^\\w*-|^\\w* \\w* -|^\\w* \\w*-")
        
        //print(heading)
        //print(dates)
        
        if let sortedDates = getDateFromString(dates)?.sorted() {
            if let last = sortedDates.last {
                //format the date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                preventiveResultsArray.append("\(heading) \(dateFormatter.string(from: last))")
                //print("\(heading) \(dateFormatter.string(from: last))")
            } else {
                preventiveResultsArray.append("\(heading) no last date found")
                //print("\(heading) no last date found")
            }
            
        }
    }
    return preventiveResultsArray.joined(separator: "\n")
    
}
