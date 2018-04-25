//
//  cv Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/8/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation

struct Cardiovascular:PopulateComboBoxProtocol {
	let cbSEMQuant = ["", "1", "2", "3", "4", "5", "6"]
	let cbSEMType = ["systolic", "diastolic", "systolic & diastolic"]
	let cbSEMLocation = ["", "throughout", "RUSB", "LUSB", "BUSB", "RLSB", "LLSB", "BLSB", "Apex"]
	
	func matchValuesFrom(_ id: Int) -> [String]? {
		switch id {
		case 20: return cbSEMQuant
		case 21: return cbSEMType
		case 22: return cbSEMLocation
		default: return ["No matching values found."]
		}
	}
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		var murmurs = String()
		
		for item in data {
			switch item.0 {
			case 21: murmurs = "\(item.1!) murmurs"
			case 22: murmurs += " \(item.1!)"
			default: continue
			}
		}
		
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("regular rhythm, normal rate")
			case 2: resultArray.append("no murmur")
			case 3: resultArray.append("no gallops")
			case 4: resultArray.append("no rubs")
			case 5: resultArray.append("normal point of maximal pulse")
			case 6: resultArray.append("normal s1")
			case 7: resultArray.append("normal s2")
			case 8: resultArray.append("premature beat")
			case 9: resultArray.append("regularly irregular")
			case 10: resultArray.append("irregularly irregular")
			case 11: resultArray.append("tachycardia")
			case 12: resultArray.append("bradycardia")
			case 13: resultArray.append("s3 present")
			case 14: resultArray.append("s4 present")
			case 20: resultArray.append("\(item.1!)/6 \(murmurs)")
			case 25: resultArray.append(item.1!)
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "CV: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
