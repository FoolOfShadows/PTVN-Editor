//
//  GI Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/9/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct GI:PopulateComboBoxProtocol {
	let cbTTPMass = ["", "diffusely", "midepigastic", "periumbilical", "RUQ", "LUQ", "BUQ", "RLQ", "LLQ", "BLQ", "pelvic"]
	
	func matchValuesFrom(_ id: Int) -> [String]? {
		switch id {
		case 17, 18: return cbTTPMass
		default: return ["No matching values found."]
		}
	}
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("soft")
			case 2: resultArray.append("no tenderness")
			case 3: resultArray.append("no rebound or guarding")
			case 4: resultArray.append("non-distended")
			case 5: resultArray.append("no hepatosplenomegaly")
			case 6: resultArray.append("no masses")
			case 7: resultArray.append("normal bowel sounds")
			case 8: resultArray.append("distended")
			case 9: resultArray.append("bloated")
			case 10: resultArray.append("obese")
			case 15: resultArray.append("hepatoMegaly: \(item.1!)")
			case 16: resultArray.append("splenoMegaly: \(item.1!)")
			case 27: resultArray.append("tender: \(item.1!)")
			case 28: resultArray.append("mass: \(item.1!)")
			case 30: resultArray.append("BS: \(item.1!.lowercased())")
			case 31: resultArray.append("BS: \(item.1!.lowercased())")
			case 32: resultArray.append("BS: \(item.1!.lowercased())")
			case 40: resultArray.append(item.1!)
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
            results = "GI: ABDOMEN: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
