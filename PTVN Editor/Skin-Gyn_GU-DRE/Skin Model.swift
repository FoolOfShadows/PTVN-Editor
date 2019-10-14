//
//  Skin Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct Skin {

	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("warm")
			case 2: resultArray.append("dry")
			case 5: resultArray.append("no rash")
			case 4: resultArray.append("no lesions")
			case 3: resultArray.append("normal turgor")
			case 6: resultArray.append("decreased skin turgor")
            case 7: resultArray.append("rosacea with rhynophyma")
			case 10: resultArray.append("Acne: \(item.1!)")
			case 11: resultArray.append("Rash: \(item.1!)")
			case 12: resultArray.append("Lump: \(item.1!)")
			case 13: resultArray.append("Ulcer: \(item.1!)")
			case 14: resultArray.append("Callus: \(item.1!)")
			case 15: resultArray.append("Cellulite: \(item.1!)")
			case 16: resultArray.append("Boil: \(item.1!)")
			case 17: resultArray.append("Nail fungus: \(item.1!)")
			case 18: resultArray.append("Skin fungus: \(item.1!)")
			case 19: resultArray.append(item.1!)
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "SKIN: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
