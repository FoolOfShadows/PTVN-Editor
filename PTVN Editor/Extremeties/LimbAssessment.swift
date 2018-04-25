//
//  LimbAssessment.swift
//  Physical Exam 2
//
//  Created by Fool on 1/18/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
class LimbAssessment {
	
//	var vibSenseResults
//	var monofilamentResults
//	var spiderVeinResults
//	var vericoseResults
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		var sectionHeading = String()
		var appendage = [String]()
		var side = String()
		var senseState = String()
		
		var processToRun: (()->String)?
		
		
		
		func processVibeSense() -> String {
			return "\(senseState) \(sectionHeading) \(side) \(appendage.joined())"
		}
		
		func processSpiderVericose() -> String {
			return "\(sectionHeading) \(side) \(appendage.joined(separator: ", "))"
		}
		
		for item in data {
			switch item.0 {
			case 80: sectionHeading = "Vibration sense"; processToRun = processVibeSense
			case 81: sectionHeading = "Monofilament sensation"; processToRun = processVibeSense
			case 82: sectionHeading = "Spider veins"; processToRun = processSpiderVericose
			case 83: sectionHeading = "Varicose veins"; processToRun = processSpiderVericose
			case 84...90: appendage.append(item.1!.lowercased())
			case 91: appendage.append("abdomen")
			case 92, 93, 94: side = item.1!.lowercased()
			case 95, 96: senseState = item.1!.lowercased()
			default: continue
			}
		}
		
		
		if let selectedProcess = processToRun {
			results = selectedProcess()
		} else if !resultArray.isEmpty {
			results = resultArray.joined(separator: ", ")
		}
		
		return results
	}
}
