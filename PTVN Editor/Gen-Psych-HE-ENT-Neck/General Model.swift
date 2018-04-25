//
//  GenPsychHEENTNeck Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/5/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

struct General {
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("alert")
			case 2: resultArray.append("oriented x3")
			case 3: resultArray.append("no acute distress")
			case 4: resultArray.append("well developed, well nourished")
			case 5: resultArray.append("somnolent")
			case 6: resultArray.append("arousable")
			case 7: resultArray.append("obese")
			case 8: resultArray.append("thin")
			case 9: resultArray.append("cachectic")
			case 10: resultArray.append("not oriented to time")
			case 11: resultArray.append("not oriented to place")
			case 12: resultArray.append("not oriented to person")
			case 13: resultArray.append("unkempt")
			case 30: resultArray.append(item.1!)
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "GENERAL: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
