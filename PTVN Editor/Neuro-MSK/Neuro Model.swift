//
//  Neuro Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/9/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct Neuro:PopulateComboBoxProtocol {
	let cbDTR = ["", "+1", "+2", "+3", "+4", "diminished", "absent"]
	let cbSTL = ["10", "15", "20", "25", "30", "35", "40", "45", ">45", ""]
	
	func matchValuesFrom(_ id: Int) -> [String]? {
		switch id {
		case 10, 11: return cbSTL.reversed()
		case 19, 20: return cbDTR
		default: return ["No matching values found."]
		}
	}
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		var dtrLocation = String()
		var gaitArray = [String]()
		var postureArray = [String]()
		
		for item in data {
			switch item.0 {
			case 15...18: dtrLocation = item.1!
			default: continue
			}
		}
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("cranial nerves 1-12 grossly intact")
			case 2: resultArray.append("normal deep tendon reflexes")
			case 3: resultArray.append("normal sensation")
			case 4: resultArray.append("normal gait")
			case 5: resultArray.append("normal posture")
			case 6: resultArray.append("nonfocal findings")
			
			case 10: resultArray.append("straight leg raising right leg \(item.1!) degrees")
			case 11: resultArray.append("straight leg raising left leg \(item.1!) degrees")
			case 19: resultArray.append("\(dtrLocation) right deep tendon reflexes \(item.1!)")
			case 20: resultArray.append("\(dtrLocation) left deep tendon reflexes \(item.1!)")
			case 25...29: gaitArray.append(item.1!)
			case 35, 36: postureArray.append(item.1!)
			case 40: resultArray.append(item.1!)
			default: continue
			}
		}
		
		if !gaitArray.isEmpty {
			resultArray.append("Gait: \(gaitArray.joined(separator: ", "))")
		}
		if !postureArray.isEmpty {
			resultArray.append("Posture: \(postureArray.joined(separator: ", "))")
		}
		
		if !resultArray.isEmpty {
			results = "NEURO: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
