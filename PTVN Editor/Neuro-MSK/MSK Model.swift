//
//  MSKAssessmentModel.swift
//  Physical Exam 2
//
//  Created by Fool on 12/21/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Foundation

class MSK {
	
	var mskAbnormalResults = String()
	
	let generalAreas = ["Head & Spine", "Shoulders & Arms", "Hands", "Hips & Legs", "Feet"]
	let headSelections = ["head", "neck", "paraspinal", "traps", "ribs", "T-spine", "L-spine", "pelvis", "sacral", "sciatic"]
	let shoulderSelections = ["shoulder", "deltoid", "bicep", "tricep", "elbow", "forearm", "wrist"]
	let handSelections = ["hand", "index finger", "middle finger", "ring finger", "pinky finger", "thumb"]
	let hipSelections = ["hip", "gluteus", "thigh", "quadricep", "hamstring", "knee", "calf", "ankle"]
	let feetSelections = ["foot", "heel", "big toe", "2nd toe", "3rd toe", "4th toe", "5th toe"]
	let sides = ["left", "right", "both"]
	
	let theSwlLocListGen = ["", "general", "inside", "outside", "top", "bottom", "left side", "right side"]
	let theStrengthList = ["", "0", "1", "2", "2+", "3-", "3", "3+", "4-", "4", "4+", "5-", "5"]
	let theRomList = ["", "10", "15", "20", "25", "30", "35", "40", "45", ">45"]
	let neckROMDirList = ["", "flexion", "extension", "right lateral flexion", "left lateral flexion", "right lateral rotation", "left lateral rotation", "crepitus"]
	let lspineROMDirList = ["", "flexion", "extension", "right lateral", "left lateral"]
	let shoulderROMDirList = ["", "abduction", "adduction", "flexion", "extension", "external rotation", "internal rotation"]
	let elbowROMDirList = ["", "flexion", "extension", "pronation", "supination"]
	let forearmROMDirList = ["", "pronation", "supination"]
	let wristROMDirList = ["", "flexion", "extension", "radial deviation", "ulnar deviation"]
	let hipROMDirList = ["", "abduction", "adduction", "flexion", "extension", "external rotation", "internal rotation"]
	let kneeROMDirList = ["", "flexion", "extension"]
	let ankleROMDirList = ["", "plantar flexion", "dorsiflexion", "inversion", "eversion"]
	let footROMDirList = ["", "inversion", "eversion"]
	let theRomDirListGen = ["", "extension", "flexion", "left rotation", "right rotation"]
	let theToneList = ["", "normal" , "atrophic", "fasciculations", "flaccid", "tense", "stiff", "spastic", "ratcheting cog wheel rigidity", "ligament laxity", "subluxation"]
	let effList = ["", "effusion", "swelling"]
	
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("normal range of motion")
			case 2: resultArray.append("normal strength")
			case 3: resultArray.append("nontender")
			case 4: resultArray.append("normal tone")
			case 15: resultArray.append(item.1!)
			default: continue
			}
		}
		
		if !mskAbnormalResults.isEmpty {
			resultArray.append(mskAbnormalResults)
		}
		
		if !resultArray.isEmpty {
			results = "MSK: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
