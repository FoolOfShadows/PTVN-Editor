//
//  Lymph Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/9/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct Lymph {
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("normal cervical lymph nodes")
			case 2: resultArray.append("no axillary lymphadenopathy")
			case 3: resultArray.append("normal inguinal lymph nodes")
			case 4: resultArray.append("no supraclavicular lymphadenopathy")
			case 10, 11, 12: resultArray.append("\(item.1!.lowercased()) axillary lymphadenopathy")
			case 13, 14, 15: resultArray.append("\(item.1!.lowercased()) inguinal lymphadenopathy")
			case 16, 17, 18: resultArray.append("\(item.1!.lowercased()) supraclavicular lymphadenopathy")
			case 19, 20, 21: resultArray.append("\(item.1!.lowercased()) submandibular lymphadenopathy")
			case 22, 23, 24: resultArray.append("\(item.1!.lowercased()) anterior cervical lymphadenopathy")
			case 25, 26, 27: resultArray.append("\(item.1!.lowercased()) posterior cervical lymphadenopathy")
			case 30: resultArray.append(item.1!)
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "LYMPH: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
