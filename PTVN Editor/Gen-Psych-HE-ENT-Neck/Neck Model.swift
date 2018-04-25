//
//  Neck Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/8/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct Neck {
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("supple, no masses")
			case 2: resultArray.append("no lymphadenopathy")
			case 3: resultArray.append("no bruits")
			case 4: resultArray.append("no jugular venous distention")
			case 5: resultArray.append("trachea normal & midline")
			case 6: resultArray.append("no thyromegaly")
			case 7: resultArray.append("shoddy lymphadenopathy")
			case 8: resultArray.append("submandibular lymphadenopathy")
			case 9: resultArray.append("anterior cervical lymphadenopathy")
			case 10: resultArray.append("posterior cervical lymphadenopathy")
			case 11: resultArray.append("jugular venous distention")
			case 12: resultArray.append("goiter")
			case 13: resultArray.append("right carotid bruit")
			case 14: resultArray.append("left carotid bruit")
			case 20: resultArray.append(item.1!)
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "NECK: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
