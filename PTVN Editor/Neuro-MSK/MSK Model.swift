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
	
//    let generalAreas = ["Head & Spine", "Shoulders & Arms", "Hands", "Hips & Legs", "Feet"]
//    let headSelections = ["head", "neck", "paraspinal", "traps", "ribs", "T-spine", "L-spine", "pelvis", "sacral", "sciatic"]
//    let shoulderSelections = ["shoulder", "deltoid", "bicep", "tricep", "elbow", "forearm", "wrist"]
//    let handSelections = ["hand", "index finger", "middle finger", "ring finger", "pinky finger", "thumb"]
//    let hipSelections = ["hip", "gluteus", "thigh", "quadricep", "hamstring", "knee", "calf", "ankle"]
//    let feetSelections = ["foot", "heel", "big toe", "2nd toe", "3rd toe", "4th toe", "5th toe"]
//    let sides = ["left", "right", "both"]
//
//    let theSwlLocListGen = ["", "general", "inside", "outside", "top", "bottom", "left side", "right side"]
//    let theStrengthList = ["", "0", "1", "2", "2+", "3-", "3", "3+", "4-", "4", "4+", "5-", "5"]
//    let theRomList = ["", "10", "15", "20", "25", "30", "35", "40", "45", ">45"]
//    let neckROMDirList = ["", "flexion", "extension", "right lateral flexion", "left lateral flexion", "right lateral rotation", "left lateral rotation", "crepitus"]
//    let lspineROMDirList = ["", "flexion", "extension", "right lateral", "left lateral"]
//    let shoulderROMDirList = ["", "abduction", "adduction", "flexion", "extension", "external rotation", "internal rotation"]
//    let elbowROMDirList = ["", "flexion", "extension", "pronation", "supination"]
//    let forearmROMDirList = ["", "pronation", "supination"]
//    let wristROMDirList = ["", "flexion", "extension", "radial deviation", "ulnar deviation"]
//    let hipROMDirList = ["", "abduction", "adduction", "flexion", "extension", "external rotation", "internal rotation"]
//    let kneeROMDirList = ["", "flexion", "extension"]
//    let ankleROMDirList = ["", "plantar flexion", "dorsiflexion", "inversion", "eversion"]
//    let footROMDirList = ["", "inversion", "eversion"]
//    let theRomDirListGen = ["", "extension", "flexion", "left rotation", "right rotation"]
//    let theToneList = ["", "normal" , "atrophic", "fasciculations", "flaccid", "tense", "stiff", "spastic", "ratcheting cog wheel rigidity", "ligament laxity", "subluxation"]
//    let effList = ["", "effusion", "swelling"]
	
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("normal range of motion")
			case 2: resultArray.append("normal strength")
			case 3: resultArray.append("nontender")
			case 4: resultArray.append("normal tone")
			//case 15: resultArray.append(item.1!)
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

struct mskEnumLists {
    var mskCases:[String] {
        var tempCases = [String]()
        mskAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var headCases:[String] {
        var tempCases = [String]()
        headSelections.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var shoulderCases:[String] {
        var tempCases = [String]()
        shoulderSelections.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var handCases:[String] {
        var tempCases = [String]()
        handSelections.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var hipCases:[String] {
        var tempCases = [String]()
        hipSelections.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var feetCases:[String] {
        var tempCases = [String]()
        feetSelections.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var mskSideCases:[String] {
        var tempCases = [String]()
        mskSides.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var swellingCases:[String] {
        var tempCases = [String]()
        swellingLocation.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var strengthCases:[String] {
        var tempCases = [String]()
        strengthList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var toneCases:[String] {
        var tempCases = [String]()
        toneList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var effusionCases:[String] {
        var tempCases = [String]()
        effusionList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var neckROMCases:[String] {
        var tempCases = [String]()
        neckROMList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var lspineROMCases:[String] {
        var tempCases = [String]()
        lspineROMList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var shoulderROMCases:[String] {
        var tempCases = [String]()
        shoulderROMList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var elbowROMCases:[String] {
        var tempCases = [String]()
        elbowROMList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var forearmROMCases:[String] {
        var tempCases = [String]()
        forearmROMList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var wristROMCases:[String] {
        var tempCases = [String]()
        wristROMList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var hipROMCases:[String] {
        var tempCases = [String]()
        hipROMList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var kneeROMCases:[String] {
        var tempCases = [String]()
        kneeROMList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var ankleROMCases:[String] {
        var tempCases = [String]()
        ankleROMList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var footROMCases:[String] {
        var tempCases = [String]()
        footROMList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var generalROMCases:[String] {
        var tempCases = [String]()
        generalROMList.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    let generalROMDegrees = ["10", "15", "20", "25", "30", "35", "40", "45", ">45"]
    let shoulderRomDegrees = ["0", "15", "30", "45", "60", "90", "100", "120", "140", "160", "180"]
}

enum mskAreas:String, CaseIterable {
    case headSpine = "Head & Spine"
    case shouldersArms = "Shoulders & Arms"
    case hands = "Hands"
    case hipsLegs = "Hips & Legs"
    case feet = "Feet"
}

enum headSelections:String, CaseIterable {
    case head
    case neck
    case paraspinal
    case traps
    case ribs
    case tSpine = "Thoracic spine"
    case lSpine = "Lumbar spine"
    case pelvis
    case sacral
    case sciatic
}

enum shoulderSelections:String, CaseIterable {
    case shoulder
    case deltoid
    case bicep
    case tricep
    case elbow
    case forearm
    case wrist
}

enum handSelections:String, CaseIterable {
    case hand
    case index = "index finger"
    case middle = "middle finger"
    case ring = "ring finger"
    case pinky = "pinky finger"
    case thumb
}

enum hipSelections:String, CaseIterable {
    case hip
    case gluteus
    case thigh
    case quadricep
    case hamstring
    case knee
    case calf
    case ankle
}

enum feetSelections:String, CaseIterable {
    case foot
    case heel
    case big = "big toe"
    case second = "2nd toe"
    case third = "3rd toe"
    case fourth = "4th toe"
    case fifth = "5th toe"
}

enum mskSides:String, CaseIterable {
    case left
    case right
    case both
}

enum swellingLocation:String, CaseIterable {
    case general
    case medial
    case lateral
    case top
    case bottom
    case left = "left side"
    case right = "right side"
}

enum strengthList:String, CaseIterable {
    case zero = "0"
    case one = "1"
    case two = "2"
    case twoPlus = "2+"
    case twoMinus = "2-"
    case three = "3"
    case threePlus = "3+"
    case threeMinus = "3-"
    case four = "4"
    case fourPlus = "4+"
    case fourMinus = "4-"
    case fiveMinus = "5-"
    case five = "5"
}

enum toneList:String, CaseIterable {
    case normal
    case atrophic
    case fasciculations
    case flaccid
    case tense
    case stiff
    case spastic
    case ratcheting = "ratcheting cog wheel rigidity"
    case laxity = "ligament laxity"
    case subluxation
    case crepitus
}

enum effusionList:String, CaseIterable {
    case effusion
    case swelling
}

enum neckROMList:String, CaseIterable {
    case flexion
    case extensionNeck = "extension"
    case rightFlex = "right lateral flexion"
    case leftFlex = "left lateral flexion"
    case rightRotation = "right lateral rotation"
    case leftRotation = "left lateral rotation"
}

enum lspineROMList:String, CaseIterable {
    case flexion
    case extensionLSpine = "extension"
    case rightFlex = "right lateral"
    case leftFlex = "left lateral"
}

enum shoulderROMList:String, CaseIterable {
    case abduction
    case adduction
    case forwardExtension = "forward extension"
    case backwardExtension = "backward extension"
    case internalRotation = "internal rotation"
    case externalRotation = "external rotation"
    
}

enum elbowROMList:String, CaseIterable {
    case flexion
    case extensionElbow = "extension"
    case pronation
    case supination
}

enum forearmROMList:String, CaseIterable {
    case pronation
    case supination
}

enum wristROMList:String, CaseIterable {
    case flexion
    case extensionWrist = "extension"
    case radial = "radial deviation"
    case ulnar = "ulnar deviation"
}

enum hipROMList:String, CaseIterable {
    case abuction
    case adduction
    case flexion
    case extensionHip = "extension"
    case externalRotation = "external rotation"
    case internalRotation = "internal rotation"
}

enum kneeROMList:String, CaseIterable {
    case flexion
    case extensionKnee = "extension"
}

enum ankleROMList:String, CaseIterable {
    case plantar = "plantar flexion"
    case dorsiflexion
    case inversion
    case eversion
}

enum footROMList:String, CaseIterable {
    case inversion
    case eversion
}

enum generalROMList:String, CaseIterable {
    case extensionGeneral = "extension"
    case flexion
    case leftRotation = "left rotation"
    case rightRotation = "right rotation"
}
