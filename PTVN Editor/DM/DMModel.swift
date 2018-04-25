//
//  DMModel.swift
//  LIROS
//
//  Created by Fool on 12/5/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Foundation

let vibrationSenseList = ["", "none", "normal", "decreased", "absent"]
let yesNoList = ["", "yes", "no"]
let complianceList = ["", "Compliant w/Meds & Diet", "Compliant w/Meds", "Compliant w/Diet", "Non-compliant w/Meds & Diet", "Non-compliant w/Meds", "Non-compliant w/Diet"]
let checkingFBSList = ["", "1 time/day", "2 times/day", "3 times/day", "4 times/day", "5 times/day", "6 times/day", "2 times/day, 3days/week", "Every Other Day", "Every Week"]
let retinopathyExamList = ["", "No", "Yes", "Unknown"]
let glucometerIssuesList = ["", "Poor vision", "Blindness", "Dexterity"]
let umalbList = ["", "Normal", "Abnormal"]
let dmTypeList = ["", "I", "II", "II, Insulin requiring"]
let dmModifierList = ["", "Controlled on diet", "Controlled on meds", "Controlled on insulin", "Uncontrolled"]
let prognosisList = ["", "Stable", "Fair", "Poor", "Declining", "Improving"]
let retinopathyHxList = ["", "Vision Loss", "Poor Vision", "Laser Treatment", "Injection Treatment"]

func processCompliance(_ data:[(Int, String?)]) -> String {
	var results = [String]()
	var bsStick = String()
	var footComplaints = [String]()
	
	for item in data {
		switch item.0 {
		case 1: results.append("Diabetes Mellitus \(item.1!)")
		case 2: results.append(item.1!)
		case 3: if let i = item.1 { results.append(i) }
		case 4: results.append("Patient reports compliance with taking medications and is taking them without difficulty.")
		case 5: results.append("Patient is exercising regularly.")
		case 6: results.append("Patient is not exercising regularly.")
		case 7: results.append("Blood sugar log provided and reviewed.")
		case 8: results.append("Patient did not provide blood sugar log.")
		case 9: if let i = item.1 { bsStick = "Patient is checking finger stick blood sugar \(i)" }
		case 10: if let i = item.1 { bsStick += ", with a range of \(i)" }
		case 11: if let i = item.1 { bsStick += " to \(i)."; results.append(bsStick) }
		case 12: results.append("Patient denies any foot complaints.")
		case 13: footComplaints.append("numbness")
		case 14: footComplaints.append("tingling")
		case 15: footComplaints.append("burning pain")
		default: continue
		}
	}
	
	if !footComplaints.isEmpty {
		results.append("Patient complains of \(footComplaints.joined(separator: ", ")) in feet.")
	}
	
	return results.joined(separator: "\n")
}

func processBSSectionData(_ data:[String], forType type:String) -> String {
		if !data.isEmpty {
			if data.contains("no") {
				return "Patient denies any symptoms of \(type) blood sugar."
			} else {
				return "Patient reports symptoms of \(type) blood sugar: \(data.joined(separator: ", "))."
			}
		} else {
			return ""
		}
	}

func processEquipmentIssues(difficulty:Int, glucometer:String) -> String {
	var results = [String]()
	if difficulty == 1 {
		results.append("Patient has difficulty with their equipment.")
	}
	if !glucometer.isEmpty {
		results.append("Glucometer issues: \(glucometer)")
	}
	
	return results.joined(separator: "\n")
}

func processVibrationData(vibration:String, monofilament:Int) -> String {
	var results = [String]()
	if !vibration.isEmpty {
		results.append("Vibration sense in feet: \(vibration).")
	}
	if monofilament == 1 {
		results.append("Monofilament screen normal.")
	}
	
	return results.joined(separator: "\n")
}

func processLabsUsing(_ data:[(Int, String?)]) -> String {
	var subResults = [String]()
	var results = [String]()
	let filteredData = data.filter {$0.0 == 1 || $0.1 != nil}
	for item in filteredData {
		switch item.0 {
		case 1: results.append("All labs are at target values.")
		case 2: results.append("Lab date \(item.1!).")
		case 3: results.append("HgbA1C: \(item.1!)")
		case 4:
			if results.contains(where: {$0.hasPrefix("HgbA1C:")}) {
				if let i = results.index(where: {$0.hasPrefix("HgbA1C:")}) {
					results[i] = "\(results[i]); 3 month glucose average: \(item.1!)"
				}
			}
		case 5: subResults.append("eGFR: \(item.1!)")
		case 6: subResults.append("BUN: \(item.1!)")
		case 7: subResults.append("Creatinine: \(item.1!)")
		case 9: subResults.append("LDL: \(item.1!)")
		case 8: subResults.append("U Malb: \(item.1!)")
		case 10:
			if subResults.contains(where: {$0.hasPrefix("U Malb:")}) {
				if let i = subResults.index(where: {$0.hasPrefix("U Malb:")}) {
					subResults[i] = "\(subResults[i]) - \(item.1!)"
				}
			}
		default: continue
		}
	}
	
	if !subResults.isEmpty {
		results.append(subResults.joined(separator: "; "))
	}
	
	return results.joined(separator: "\n")
	
}

func processPlanUsing(_ data:[(Int, String?)]) -> String {
	var results = [String]()
	var refResults = [String]()
	//let filteredData = data.filter {$0.1 != nil}
	
	for item in data {
		switch item.0 {
		case 1: results.append("Patient directed to check blood sugars \(item.1!).")
		case 2: results.append("DM shoes prescribed at this visit.")
		case 3: results.append("DM diet discussed with patient at this visit.")
		case 4: refResults.append("DM Education")
		case 5: refResults.append("Nutritionist")
		case 6: refResults.append("Podiatrist")
		case 7: refResults.append("Opthalmologist")
		default: continue
		}
	}
	
	if !refResults.isEmpty {
		results.append("Referrals made: \(refResults.joined(separator: ", "))")
	}
	
	return results.joined(separator: "\n")
}


func processAssessmentUsing(_ data:[(Int, String)]) -> String {
	var results = [String]()
	
	for item in data {
		switch item.0 {
		case 1: results.append("with fluctuating blood sugars")
		case 2: results.append("with hypoglycemia episodes")
		case 3: results.append("hypoglycemia in diabetes")
		case 4: results.append("PeripheralNeuropathy")
		case 5: results.append("diabetic neuropathic pain in feet")
		case 6: results.append("diabetic neuropathic pain in legs")
		case 7: results.append("diabetic retinopathy")
		case 8: results.append("diabetic nephropathy")
		case 9: results.append("diabetic amyotrophy")
		case 10: results.append("poor circulation")
		case 11: results.append("diabetic foot")
		case 12: results.append("diabetic foot ulcer")
		case 13: results.append("history of foot ulcers")
		case 14: results.append("pre-ulcerative callus")
		case 15: results.append("Bunion")
		case 16: results.append("hammer toes")
		case 17: results.append("Onycomycosis")
		default: continue
		}
	}
	
	
	return results.joined(separator: "\n")
}
