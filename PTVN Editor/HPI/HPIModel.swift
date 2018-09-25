//
//  HPIModel.swift
//  LIROS
//
//  Created by Fool on 11/7/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Foundation

enum HPITypes:String {
	case symptoms = "presents with symptoms including"
	case uti = "presents with symptoms of urinary tract infection including"
	case uri = "presents with symptoms of upper respiratory infection including"
	case htn = "returns for followup of hypertension and reports"
	case hichol = "returns for followup of high cholesterol and reports"
	case chestpain = "presents with symptoms of chest pain including"
	
	var denial:String {
		switch self {
		case .symptoms, .uti, .uri, .chestpain:
			return " and denies "
		case .htn, .hichol:
			return ".\nPatient denies "
		}
	}
}

func processHPISection(_ section:HPITypes, usingData data:(title: String, positives: [String], negatives: [String])) -> String {
	var result = String()
	
	if !data.positives.isEmpty {
		result = "Patient \(section.rawValue) \(data.positives.joined(separator: ", "))"
		if !data.negatives.isEmpty {
			result += "\(section.denial)\(data.negatives.joined(separator: ", "))."
		} else {
			result += "."
		}
	}
	
	if !result.isEmpty && data.title != "" {
		//print(data.title)
		result += "  Onset reported as \(data.title)."
	}
	
	return result
}

let phlegmColors = ["", "clear", "white", "yellow", "green", "tan", "gray", "bloody", "rusty", "brown", "frothy"]

struct Vitals {
    var weight = String()
    var height = String()
    var temp = String()
    var bpSite = String()
    var systolic = String()
    var diastolic = String()
    var pulse = String()
    var resp = String()
    var pulseOx = String()
    var poType = String()
    
    var bmi:String { if let numWeight = Double(weight), let numHeight = Double(height) {
        return String(format: "%.1f",(numWeight/(numHeight * numHeight)) * 703)
        }
        return "NC"
    }
    
    func getVitalsOutput() -> String {
        
        return "Wt: \(weight) lb;     Ht: \(height) in;     BMI: \(bmi)     T: \(temp) F;     BP: \(systolic)/\(diastolic) \(getVitalsVerbiageFrom(bpSite)) sitting;     P: \(pulse);     R: \(resp);     Pulse Ox: \(pulseOx)% \(getVitalsVerbiageFrom(poType))"
    }
    
    func getVitalsVerbiageFrom(_ raw:String) -> String {
        switch raw {
        case "RA":
            return "right arm"
        case "LA":
            return "left arm"
        case "RW":
            return "right wrist"
        case "LW":
            return "left wrist"
        case "RM":
            return "room air"
        case "2":
            return "on 2L NC O2"
        case "2.5":
            return "on 2.5L NC O2"
        case "3":
            return "on 3L NC O2"
        case "3.5":
            return "on 3.5L NC O2"
        case "4":
            return "on 4L NC O2"
        default:
            return ""
        }
    }
}
