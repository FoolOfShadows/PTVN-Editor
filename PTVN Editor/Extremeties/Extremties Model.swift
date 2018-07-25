//
//  Extremeties Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct Extremities:PopulateComboBoxProtocol {
	let cbRLBList = ["", "right", "left", "bilateral"]
	let cbPitting = ["", "pitting", "slight pitting", "non-pitting"]
	let cbPulses = ["", "+2 pulses", "+1 pulses", "diminished pulses", "absent pulses"]
	let puEdemaQuant = ["", "trace", "+1", "+2", "+3", "+4"]
	let cbEdema = ["", "toes", "foot", "ankle", "calf", "knee", "thigh", "hip", "groin", "gluteal", "hand", "wrist", "forearm", "elbow", "upper arm", "shoulder"]
	let cbPulsesLocation = ["", "dorsalis pedis", "posterior tibial", "popliteal", "femoral", "radial", "ulnar", "brachial"]
	let cbCRQuant = ["", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5"]
	
	func matchValuesFrom(_ id: Int) -> [String]? {
		switch id {
		case 24, 25: return cbCRQuant
		case 40: return puEdemaQuant
		case 41: return cbPitting
		case 42: return cbRLBList
		case 43: return cbEdema
		case 50, 52: return cbPulses
		case 51, 53: return cbPulsesLocation
		default: return ["No matching values found."]
		}
	}
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("no cyanosis")
			case 2: resultArray.append("no clubbing")
			case 3: resultArray.append("no edema")
			case 4: resultArray.append("normal pulses")
			case 5: resultArray.append("normal capillary refill")
			case 6: resultArray.append("normal vibration sense")
			case 7: resultArray.append("normal monofilament sensation")
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = resultArray.joined(separator: ", ")
		}
		
		return results
	}
	

}

struct Edema {
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		var edemaString = String()
		
		for item in data {
			switch item.0 {
			case 40: edemaString += "\(item.1!) "
			case 41: edemaString += "\(item.1!) "
			case 42: edemaString += "of \(item.1!) "
			case 43: edemaString += item.1!
			case 44: resultArray.append("brawny")
			case 45: resultArray.append("lymphedema")
			case 46: resultArray.append("venus insufficiency")
			case 47: resultArray.append("cellulitis")
			default: continue
			}
		}
		
		if !edemaString.isEmpty {
			resultArray.insert(edemaString, at: 0)
		}
		
		if !resultArray.isEmpty {
			results = resultArray.joined(separator: ", ")
		}
		return results
	}
}

struct Pulses {
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		var lPulseString = String()
		var rPulseString = String()
		
		for item in data {
			switch item.0 {
			case 50: lPulseString += "\(item.1!) "
			case 51: lPulseString += "left \(item.1!)"
			case 52: rPulseString += "\(item.1!) "
			case 53: rPulseString += "right \(item.1!)"
			default: continue
			}
		}
		
		if !lPulseString.isEmpty {
			resultArray.append(lPulseString)
		}
		if !rPulseString.isEmpty {
			resultArray.append(rPulseString)
		}
		
		if !resultArray.isEmpty {
			results = resultArray.joined(separator: ", ")
		}
		return results
	}
}

struct CapillaryRefill {
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		for item in data {
			switch item.0 {
			case 24: resultArray.append("\(item.1!) second(s) left foot")
			case 25: resultArray.append("\(item.1!) second(s) right foot")
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "Capillary refill \(resultArray.joined(separator: ", "))"
		}
		return results
	}
}

struct Clubbing {
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		for item in data {
			switch item.0 {
			case 105, 106, 107: resultArray.append("\(item.1!.lowercased()) toes")
			case 108, 109, 110: resultArray.append("\(item.1!.lowercased()) fingers")
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "Clubbing present on \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}

struct Bunions {
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		for item in data {
			switch item.0 {
			case 115, 116, 117: resultArray.append("\(item.1!.lowercased()) medial")
			case 118, 119, 120: resultArray.append("\(item.1!.lowercased()) lateral")
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "Bunions: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}

struct Callus {
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		
		if data.count > 0 {
			let theItem = data[0]
			if let title = theItem.1 {
				switch title {
				case "Right", "Left": results = "Callus: \(title.lowercased()) foot"
				case "Bilateral": results = "Calluses: both feet"
				default: break
				}
			}
		}
		
		return results
	}
}

















