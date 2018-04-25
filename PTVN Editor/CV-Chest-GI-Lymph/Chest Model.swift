//
//  Chest Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/9/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct Chest:PopulateComboBoxProtocol {
	let cbRULLULList = ["", "RUL", "LUL", "BUL", "RML", "RLL", "LLL", "BLL"]
	
	func matchValuesFrom(_ id: Int) -> [String]? {
		switch id {
		case 10, 11, 12, 13: return cbRULLULList
		default: return ["No matching values found."]
		}
	}
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("nontender")
			case 2: resultArray.append("lungs clear")
			case 3: resultArray.append("no wheezes")
			case 4: resultArray.append("no crackles")
			case 5: resultArray.append("no rhonchi")
			case 6: resultArray.append("normal fremitus")
			case 7: resultArray.append("no egophony")
			case 8: resultArray.append("breathing non labored")
			case 10: resultArray.append("wheezes \(item.1!)")
			case 11: resultArray.append("crackles \(item.1!)")
			case 12: resultArray.append("rhonchi \(item.1!)")
			case 13: resultArray.append("egophony \(item.1!)")
			case 20: resultArray.append(item.1!)
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "CHEST: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
