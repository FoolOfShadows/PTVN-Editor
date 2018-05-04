//
//  Chest Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/9/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct Chest/*:PopulateComboBoxProtocol*/ {
	//let cbRULLULList = ["", "RUL", "LUL", "BUL", "RML", "RLL", "LLL", "BLL"]
	
//    func matchValuesFrom(_ id: Int) -> [String]? {
//        switch id {
//        case 10, 11, 12, 13: return cbRULLULList
//        default: return ["No matching values found."]
//        }
//    }
	
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
            case 10: resultArray.append("wheezes RUL")
            case 11: resultArray.append("wheezes LUL")
            case 12: resultArray.append("wheezes BUL")
            case 13: resultArray.append("wheezes RML")
            case 14: resultArray.append("wheezes RLL")
            case 15: resultArray.append("wheezes LLL")
            case 16: resultArray.append("wheezes BLL")
            case 20: resultArray.append("crackles RUL")
            case 21: resultArray.append("crackles LUL")
            case 22: resultArray.append("crackles BUL")
            case 23: resultArray.append("crackles RML")
            case 24: resultArray.append("crackles RLL")
            case 25: resultArray.append("crackles LLL")
            case 26: resultArray.append("crackles BLL")
            case 30: resultArray.append("rhonchi RUL")
            case 31: resultArray.append("rhonchi LUL")
            case 32: resultArray.append("rhonchi BUL")
            case 33: resultArray.append("rhonchi RML")
            case 34: resultArray.append("rhonchi RLL")
            case 35: resultArray.append("rhonchi LLL")
            case 36: resultArray.append("rhonchi BLL")
            case 40: resultArray.append("egophony RUL")
            case 41: resultArray.append("egophony LUL")
            case 42: resultArray.append("egophony BUL")
            case 43: resultArray.append("egophony RML")
            case 44: resultArray.append("egophony RLL")
            case 45: resultArray.append("egophony LLL")
            case 46: resultArray.append("egophony BLL")
            case 50: resultArray.append(item.1!)
            default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "CHEST: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
