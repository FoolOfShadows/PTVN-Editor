//
//  Psy Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/8/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation

struct Psychological {
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("normal mood")
			case 2: resultArray.append("appropriate affect")
			case 3: resultArray.append("normal judgment")
			case 4: resultArray.append("normal insight")
			case 5: resultArray.append("*depressed")
			case 6: resultArray.append("*flat, apathetic")
			case 7: resultArray.append("*anxious")
			case 8: resultArray.append("*fair")
			case 9: resultArray.append("^depressed")
			case 10: resultArray.append("^flat")
			case 11: resultArray.append("^anxious")
			case 15: resultArray.append("increased psychomotor activity")
			case 16: resultArray.append("decreased psychomotor activity")
			case 17: resultArray.append("fair judgment and insight")
			case 18: resultArray.append("poor judgment and insight")
			case 19: resultArray.append("pleasantly demented")
			case 20: resultArray.append("agitated dementia")
			case 25: resultArray.append(item.1!)
			default: continue
			}
		}
		
		let moodResults = resultArray.filter {$0.contains("*")}
		let affectResults = resultArray.filter {$0.contains("^")}
		
		resultArray = resultArray.filter {!$0.contains("*") && !$0.contains("^")}
		
		if !affectResults.isEmpty {
			resultArray.insert("Affect: " + (affectResults.joined(separator: ", ")).replacingOccurrences(of: "^", with: ""), at:0)
		}
		if !moodResults.isEmpty {
			resultArray.insert("Mood: " + (moodResults.joined(separator: ", ")).replacingOccurrences(of: "*", with: ""), at:0)
		}
		
		
		
		if !resultArray.isEmpty {
			results = "PSY: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
