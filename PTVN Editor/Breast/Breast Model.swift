//
//  Breast Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct Breast:PopulateComboBoxProtocol {
	let cbGalact = ["", "bloody", "dark", "green", "purulent", "milky", "clear"]
	let puMassSize = ["", ".5", "1.0", "1.5", "2.0", "2.5", "3.0", "3.5", "4.0", "4.5", "5.0", "5.5", "6.0", "6.5", "7.0", "7.5", "8.0", "8.5", "9.0", "9.5", "10.0"]
	let cbTenderness = ["", "diffuse", "upper", "lower", "inside", "outside", "upper inside", "upper outside", "lower inside", "lower outside", "left upper outer quadrant", "right upper outer quadrant", "left upper inner quadrant", "right upper inner quadrant", "left lower outer quadrant", "right lower outer quadrant", "left lower inner quadrant", "right lower inner quadrant"]
	
	func matchValuesFrom(_ id: Int) -> [String]? {
		switch id {
		case 1100...3999, 4100...69999: return puMassSize
		case 1014, 4014: return cbTenderness
		case 1015, 4015: return cbGalact
		default: return ["No matching values found."]
		}
	}
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		//Normal
		let normalBreast = data.filter {1...4 ~= $0.0}
		if !normalBreast.isEmpty {
			resultArray.append(proccessBreastSubSectionsFrom(normalBreast))
		}
		//Left
		let leftBreast = data.filter {6...7 ~= $0.0 || 1001...3999 ~= $0.0}
		if !leftBreast.isEmpty {
			resultArray.append("Left Breast: \(proccessBreastSubSectionsFrom(leftBreast))")
		}
		
		//Right
		let rightBreast = data.filter {11...12 ~= $0.0 || 4001...69999 ~= $0.0}
		if !rightBreast.isEmpty {
			resultArray.append("Right Breast: \(proccessBreastSubSectionsFrom(rightBreast))")
		}
		
		if !resultArray.isEmpty {
			results = "BREAST: \(resultArray.joined(separator: "\n"))"
		}
		
		return results
	}
	
	private func proccessBreastSubSectionsFrom(_ data: [(Int, String?)]) -> String {
		//var results = String()
		var resultArray = [String]()
		
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("no dominant masses")
			case 2: resultArray.append("no nipple discharge")
			case 3: resultArray.append("no axillary lymphadenopathy present")
			case 4: resultArray.append("nontender")
			case 6: resultArray.append("diffuse fibrocystic densities")
			case 7: resultArray.append("axillary lymphadenopathy present")
			case 11: resultArray.append("diffuse fibrocystic densities")
			case 12: resultArray.append("axillary lymphadenopathy present")
				
			case 1100...1112, 2200...2212, 3300...3312, 4100...4112, 5200...5212, 6300...6312: resultArray.append("\(item.1!) \(typeOfIssue(value: item.0)) at \(timeLocation(value: item.0))")
				
			case 1001...1012: resultArray.append("tenderness at \(item.0%1000):00")
			case 1013: resultArray.append("tenderness around nipple")
			case 1113: resultArray.append("masses around nipple")
			case 2213: resultArray.append("cysts around nipple")
			case 3313: resultArray.append("fibrodensities around nipple")
				
			case 4001...4012: resultArray.append("tenderness at \(item.0%1000):00")
			case 4013: resultArray.append("tenderness around nipple")
			case 4113: resultArray.append("masses around nipple")
			case 4213: resultArray.append("cysts around nipple")
			case 4313: resultArray.append("fibrodensities around nipple")
				
				
			case 1014: resultArray.append("\(item.1!) tenderness")
			case 1015: resultArray.append("galactorrhea: \(item.1!)")
			case 4014: resultArray.append("\(item.1!) tenderness")
			case 4015: resultArray.append("galactorrhea: \(item.1!)")
				
			case 5: resultArray.append("\(item.1!)")
			default: continue
			}
		}
		return resultArray.joined(separator: ", ")
	}
	
	func timeLocation(value:Int) -> String {
		switch value % 100 {
		case 1: return "at 1:00"
		case 2: return "at 2:00"
		case 3: return "at 3:00"
		case 4: return "at 4:00"
		case 5: return "at 5:00"
		case 6: return "at 6:00"
		case 7: return  "at 7:00"
		case 8: return "at 8:00"
		case 9: return "at 9:00"
		case 10: return "at 10:00"
		case 11: return "at 11:00"
		case 12: return "at 12:00"
		default: return "no location"
		}
	}
	
	func typeOfIssue(value: Int) -> String {
		switch value % 1000 {
		case 100...200: return "cm mass"
		case 201...300: return "cm cyst"
		case 301...400: return "cm fribrodense area"
		default: return "no type"
		}
	}
}
