//
//  HPI Functions.swift
//  Labs Injections ROS
//
//  Created by Fool on 6/2/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

struct Location:StructsWithDescriptionOutput {
	func getOutputFor(_ id:Int) -> String? {
		switch id {
		case 1: return "chest"
		case 2: return "abdomen"
		case 3: return "left side ribs"
		case 4: return "right side ribs"
		case 5: return "left shoulder"
		case 6: return "right shoulder"
		case 7: return "left upper arm"
		case 8: return "right upper arm"
		case 9: return "left elbow"
		case 10: return "right elbow"
		case 11: return "left forearm"
		case 12: return "right forearm"
		case 13: return "left wrist"
		case 14: return "right wrist"
		case 15: return "left hand"
		case 16: return "right hand"
		case 17: return "head"
		case 18: return "neck"
		case 19: return "upper back"
		case 20: return "lower back"
		case 21: return "left hip"
		case 22: return "right hip"
		case 23: return "left upper leg"
		case 24: return "right upper leg"
		case 25: return "left knee"
		case 26: return "right knee"
		case 27: return "left lower leg"
		case 28: return "right lower leg"
		case 29: return "left ankle"
		case 30: return "right ankle"
		case 31: return "left foot"
		case 32: return "right foot"
		default: return nil
		}
	}
		
		func processSectionData(_ data:[(Int, String?)]) -> String {
			var finalResult = String()
			var resultsStrings = getDescriptionOfItem(data, fromStruct: self) ?? [String]()
			
			let other = data.filter ({$0.0 == 50})
			if other.count > 0 {
				if let otherLocation = other[0].1 {
					resultsStrings.append(otherLocation)
				}
			}
			
			if !resultsStrings.isEmpty {
				finalResult = "Location of pain: \(resultsStrings.joined(separator: ", "))"
			}
			return finalResult
		}
	}

struct Timing:StructsWithDescriptionOutput {
	func getOutputFor(_ id:Int) -> String? {
		switch id {
		case 1: return "constant"
		case 2: return "frequent"
		case 3: return "occasional"
		case 4: return "infrequent"
		case 5: return "intermittent"
		case 6: return "at rest"
		case 7: return "after work"
		case 8: return "after exercise"
		case 9: return "in the morning"
		case 10: return "at night"
		case 11: return "at the end of the day"
		default: return nil
		}
	}
	
	func processSectionData(_ data:[(Int, String?)]) -> String {
		var resultArray = [String]()
		var finalResult = String()
		if let timingResults = getDescriptionOfItem(data.filter {$0.0 < 6}, fromStruct: self) {
			if !timingResults.isEmpty {
				resultArray.append("Timing: \(timingResults.joined(separator: ", "))")
			}
		}
		if let worseResults = getDescriptionOfItem(data.filter {$0.0 > 5}, fromStruct: self) {
			if !worseResults.isEmpty {
				resultArray.append("Worse: \(worseResults.joined(separator: ", "))")
			}
		}
		
		if !resultArray.isEmpty {
			finalResult = resultArray.joined(separator: "\n")
		}
		return finalResult
	}
}

struct Quality:StructsWithDescriptionOutput {
	func getOutputFor(_ id:Int) -> String? {
		switch id {
		case 1: return "aching"
		case 2: return "sore"
		case 3: return "sharp"
		case 4: return "stabbing"
		case 5: return "dull"
		case 6: return "burning"
		case 7: return "stinging"
		case 8: return "throbbing"
		case 9: return "cramping"
		case 10: return "spasm"
		default: return nil
		}
	}
	
	func processSectionData(_ data:[(Int, String?)]) -> String {
		var finalResult = String()
		let resultsStrings = getDescriptionOfItem(data, fromStruct: self) ?? [String]()
		
		if !resultsStrings.isEmpty {
			finalResult = "Quality: " + resultsStrings.joined(separator: ", ")
		}
		return finalResult
	}
}


struct ModifyingFactors:StructsWithDescriptionOutput {
	func getOutputFor(_ id:Int) -> String? {
		switch id {
		case 1: return "heat"
		case 2: return "ice"
		case 3: return "rest"
		case 4: return "elevation"
		case 5: return "medication"
		case 10: return "lifting"
		case 11: return "bending"
		case 12: return "stairs"
		case 13: return "standing"
		case 14: return "walking"
		case 15: return "sitting"
		case 16: return "reaching"
		case 17: return "laying down"
		case 18: return "chores"
		default: return nil
		}
	}
	func processSectionData(_ data:[(Int, String?)]) -> String {
		var finalResult = String()
		var resultsStrings = [String]()
		if let betterResults = getDescriptionOfItem(data.filter {$0.0 < 10}, fromStruct: self) {
			if !betterResults.isEmpty {
			resultsStrings.append("Better with: \(betterResults.joined(separator: ", "))")
			}
		}
		if let worseResults = getDescriptionOfItem(data.filter {$0.0 > 9 && $0.0 < 30}, fromStruct: self) {
			if !worseResults.isEmpty {
			resultsStrings.append("Worse with: \(worseResults.joined(separator: ", "))")
			}
		}
		
		if !resultsStrings.isEmpty {
			finalResult = "Modifying factors\n" + resultsStrings.joined(separator: "\n")
		}
		
		let medications = data.filter ({$0.0 == 30})
		if medications.count > 0 {
			if let meds = medications[0].1 {
				finalResult = finalResult.replacingOccurrences(of: "medication", with: "medication (\(meds))")
			}
		}
		
		return finalResult
		
	}
}

struct AssociatedSymptoms:StructsWithDescriptionOutput {
	func getOutputFor(_ id:Int) -> String? {
		switch id {
		case 1: return "no numbness"
		case 2: return "no tingling"
		case 3: return "no weakness"
		case 4: return "no stiffness"
		case 5: return "no limp"
		case 6: return "no limited movement"
		case 7: return "no foot drop"
		case 8: return "no bladder incontinence"
		case 9: return "no bowel incontinence"
		case 21: return "numbness"
		case 22: return "tingling"
		case 23: return "weakness"
		case 24: return "stiffness"
		case 25: return "limp"
		case 26: return "limited movement"
		case 27: return "foot drop"
		case 28: return "bladder incontinence"
		case 29: return "bowel incontinence"
		default: return nil
		}
}

	func processSectionData(_ data:[(Int, String?)]) -> String {
		var finalResult = String()
		let resultsStrings = getDescriptionOfItem(data, fromStruct: self) ?? [String]()
		
		if !resultsStrings.isEmpty {
			finalResult = "Associated symptoms: " + resultsStrings.joined(separator: ", ")
		}
		return finalResult
	}
}

//
struct Function:StructsWithDescriptionOutput {
	
	enum FunctionListTwo:Int {
		case NoAssistance = 1
		case WheelChair
		case Walker
		case Cane
		case WalkerOrCane
		
		var functionVerbiage:String {
			switch self {
			case .NoAssistance: return "Ambulates without assistance."
			case .WheelChair: return "Mobilizes with wheel chair."
			case .Walker: return "Ambulates with walker."
			case .Cane: return "Ambulates with cane."
			case .WalkerOrCane: return "Ambulates with walker or cane."
			}
		}
	}
	
	func getOuputForText(_ text:String) -> String? {
		switch text {
		case "no assistance": return "Ambulates without assistance."
		case "wheelchair": return "Mobilizes with wheel chair."
		case "walker": return "Ambulates with walker."
		case "cane": return "Ambulates with cane."
		case "walker or cane": return "Ambulates with walker or cane."
		default: return nil
		}
	}
	
	
	
	func getOutputFor(_ id:Int) -> String? {
		switch id {
		case 1: return "job"
		case 2: return "grooming"
		case 3: return "bathing and toilet"
		case 4: return "cooking"
		case 5: return "eating"
		case 6: return "chores"
		default: return nil
		}
	}

	func processSectionData(_ data:[(Int, String?)]) -> String {
		//var finalResult = String()
		var finalResultsArray = [String]()
		let resultsStrings = getDescriptionOfItem(data, fromStruct: self) ?? [String]()
		
		let mobility = data.filter ({$0.0 == 10})
		if mobility.count > 0 {
			if let mobile = mobility[0].1, let mobileText = getOuputForText(mobile) {
				finalResultsArray.append(mobileText)
			}
		}
		
		if !resultsStrings.isEmpty {
			finalResultsArray.append("Patient has trouble with " + resultsStrings.joined(separator: ", "))
		}
		return finalResultsArray.joined(separator: "\n")
	}
}


let durationList = ["", "days", "weeks", "months", "months to years", "years"]
let painSeverityList = ["", "mild", "moderate", "severe"]
let painContextList = ["", "better", "worse", "same", "gradual", "sudden", "good", "fair", "poor"]
let mobilityList = ["", "no assistance", "wheelchair", "walker", "cane", "walker or cane"]
let qolList = ["", "better", "worse", "good", "fair", "poor"]
//

//struct HPIDuration: IsHPIData {
//	var quantity:String
//	var timeFrame:String
//
//	func processData() -> String {
//		var results = String ()
//
//		if !quantity.isEmpty {
//			results = "Duration: \(quantity) \(timeFrame)."
//		}
//
//		return results
//	}
//}
//
//struct HPISeverity: IsHPIData {
//	var outOfTen: String
//	var description: String
//
//	func processData() -> String {
//		var resultString = String()
//
//		if !outOfTen.isEmpty {
//			resultString = "Severity: \(outOfTen)/10."
//		} else if !description.isEmpty {
//			resultString = "Severity: \(description)."
//		}
//
//		return resultString
//	}
//}
//




//struct HPIContext: IsHPIData {
//	var context:String
//	var cause:String
//
//	func processData() -> String {
//		var resultArray = [String]()
//		var resultString = String()
//
//		if !context.isEmpty {
//			resultArray.append("Current status is \(context).")
//		}
//
//		if !cause.isEmpty {
//			resultArray.append("Cause: \(cause).")
//		}
//
//		if !resultArray.isEmpty {
//			resultString = "Context: \(resultArray.joined(separator: "\n"))"
//		}
//
//		return resultString
//	}
//}
//

//struct HPIAssociatedSymptoms: IsHPIData {
//	var numbness:(Int, String)
//	var tingling:(Int, String)
//	var weakness:(Int, String)
//	var stiffness:(Int, String)
//	var limp:(Int, String)
//	var limitedMovement:(Int, String)
//	var footDrop:(Int, String)
//	var bladder:(Int, String)
//	var bowel:(Int, String)
//
//	var symptomsArray:[(Int, String)] {return [numbness, tingling, weakness, stiffness, limp, limitedMovement, footDrop, bladder, bowel]}
//
//	func processData() -> String {
//		var resultArray = [String]()
//		var resultString = String()
//
//		for symptom in symptomsArray {
//			if symptom.0 == 1 {
//				resultArray.append(symptom.1.lowercased())
//			} else if symptom.0 == -1 {
//				resultArray.append("no \(symptom.1.lowercased())")
//			}
//		}
//
//		if !resultArray.isEmpty {
//			resultString = "Associated symptoms: \(resultArray.joined(separator: ", "))."
//		}
//
//		return resultString
//	}
//}
//
//struct HPIFunction: IsHPIData {
//	var mobileWith:Int
//	var job:(Int, FunctionList) = (Int(), .Job)
//	var grooming:(Int, FunctionList) = (Int(), .Grooming)
//	var bathing:(Int, FunctionList) = (Int(), .Bathing)
//	var cooking:(Int, FunctionList) = (Int(), .Cooking)
//	var eating:(Int, FunctionList) = (Int(), .Eating)
//	var chores:(Int, FunctionList) = (Int(), .Chores)
//
//	var troubleList:[(Int, FunctionList)] {return [job, grooming, bathing, cooking, eating, chores]}
//
//	init(mobileWith:Int, job:Int, grooming:Int, bathing:Int, cooking:Int, eating:Int, chores:Int) {
//		self.mobileWith = mobileWith
//		self.job.0 = job
//		self.grooming.0 = grooming
//		self.bathing.0 = bathing
//		self.cooking.0 = cooking
//		self.eating.0 = eating
//		self.chores.0 = chores
//	}
//
//	func processData() -> String {
//		var resultArray = [String]()
//		var resultString = String()
//		var troubleArray = [String]()
//
//		if mobileWith > 0 {
//			if let theSelected = FunctionListTwo(rawValue: mobileWith) {
//				resultArray.append(theSelected.functionVerbiage)
//			}
//		}
//
//		for trouble in troubleList {
//			if trouble.0 == 1 {
//				troubleArray.append(trouble.1.rawValue.lowercased())
//			}
//		}
//
//		if !troubleArray.isEmpty {
//			resultArray.append("Patient has trouble with \(troubleArray.joined(separator: ", ")).")
//		}
//
//		if !resultArray.isEmpty {
//			resultString = "Function: \(resultArray.joined(separator: "\n"))"
//		}
//
//
//		return resultString
//	}
//}
//
//struct HPIQOL: IsHPIData {
//	var quality:String
//	var comments:String
//
//	func processData() -> String {
//		var resultArray = [String]()
//		var resultString = String()
//
//		if !quality.isEmpty {
//			resultArray.append(quality)
//		}
//		if !comments.isEmpty {
//			resultArray.append(comments)
//		}
//
//		if !resultArray.isEmpty {
//			resultString = "Quality of life: \(resultArray.joined(separator: ", "))"
//		}
//
//		return resultString
//	}
//}













