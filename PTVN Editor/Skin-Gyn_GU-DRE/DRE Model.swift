//
//  DRE Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct DRE {
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("normal anus")
			case 2: resultArray.append("no rectal masses")
			case 3: resultArray.append("ext/int rhoids not swollen or thrombosed")
			case 4: resultArray.append("heme negative")
			case 5: resultArray.append("external hemorrhoids")
			case 6: resultArray.append("internal hemorrhoids")
			case 7: resultArray.append("swollen")
			case 8: resultArray.append("heme positive")
			case 9: resultArray.append("decreased rectal tone")
			case 15: resultArray.append("Mass: \(item.1!)")
			case 19: resultArray.append(item.1!)
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "DRE: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
