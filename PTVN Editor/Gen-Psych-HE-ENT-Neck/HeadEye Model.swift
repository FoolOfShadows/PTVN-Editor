//
//  HeadEye Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/8/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct HeadEye {
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		var eyeArray = [String]()
		var leftEyeArray = [String]()
		var rightEyeArray = [String]()
		var headArray = [String]()
		
		for item in data {
			switch item.0 {
			case 1: headArray.append("normocephalic atraumatic, no lesions")
			case 2: eyeArray.append("pupils equal round, reactive to light and accommodation")
			case 3: eyeArray.append("extra-ocular muscles intact")
			case 4: eyeArray.append("no icterus")
			case 5: eyeArray.append("conjunctivae clear")
			case 6: leftEyeArray.append("sclera red")
			case 7: leftEyeArray.append("muddy")
			case 8: leftEyeArray.append("icteric")
			case 9: leftEyeArray.append("arcus sinilus")
			case 10: leftEyeArray.append("esotropia")
			case 11: rightEyeArray.append("sclera red")
			case 12: rightEyeArray.append("muddy")
			case 13: rightEyeArray.append("icteric")
			case 14: rightEyeArray.append("arcus sinilus")
			case 15: rightEyeArray.append("esotropia")
			case 20: headArray.append("\(item.1!)")
			case 21: eyeArray.append(item.1!)
			default: continue
			}
		}
		
		if !rightEyeArray.isEmpty {
			eyeArray.insert("Right eye conjunctiva: \(rightEyeArray.joined(separator: ", "))", at: 0)
		}
		if !leftEyeArray.isEmpty {
			eyeArray.insert("Left eye conjunctiva: " + (leftEyeArray.joined(separator: ", ")), at: 0)
		}
		
		if !headArray.isEmpty {
			resultArray.append("HEAD: \(headArray.joined(separator: ", "))")
		}
		if !eyeArray.isEmpty {
			resultArray.append("EYE: \(eyeArray.joined(separator: ", "))")
		}
		
		
		
		
		
		if !resultArray.isEmpty {
            results = resultArray.joined(separator: "\n")
		}
		
		return results
	}
}
