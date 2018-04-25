//
//  Gyn Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct Gyn:PopulateComboBoxProtocol {
	let cbDischargeList = ["", "yellow", "green", "bloody"]
	
	func matchValuesFrom(_ id: Int) -> [String]? {
		switch id {
		case 11: return cbDischargeList
		default: return ["No matching values found."]
		}
	}
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("external genetalia: normal, no lesions, normal urethra")
			case 2: resultArray.append("uterus normal size/position/motion, anteverted, no mass/enlargement nontender")
			case 3: resultArray.append("cervix: normal")
			case 4: resultArray.append("no cervical motion tenderness")
			case 5: resultArray.append("no adnexal mass/tenderness, no inguinal lymphadenopathy")
			case 10: resultArray.append("atrophic vaginitis")
			case 11: resultArray.append("vaginal discharge: \(item.1!)")
			case 12: resultArray.append("cervical motion tenderness")
			case 13: resultArray.append("cystocoele")
			case 14: resultArray.append("rectocoele")
			case 15: resultArray.append("cervix absent")
			case 16: resultArray.append("uterus absent")
			case 17: resultArray.append("right adnexal fullness")
			case 18: resultArray.append("left adnexal fullness")
			case 19: resultArray.append("bilateral adnexal fullness")
			case 25: resultArray.append("\(item.1!)")
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "GYN: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
