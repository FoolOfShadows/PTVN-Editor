//
//  HPIModel.swift
//  LIROS
//
//  Created by Fool on 11/7/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

enum HPITypes:String {
	case symptoms = "presents with symptoms including"
	case uti = "presents with symptoms of urinary tract infection including"
	case uri = "presents with symptoms of upper respiratory infection including"
	case htn = "returns for followup of hypertension and reports"
	case hichol = "returns for followup of high cholesterol and reports"
	case chestpain = "presents with symptoms of chest pain including"
    case posGen
    case negGen
    case posTIA
    case negTIA
    case posLS
    case negLS
	
	var denial:String {
		switch self {
		case .symptoms, .uti, .uri, .chestpain:
			return " and denies "
		case .htn, .hichol:
			return ".\nPatient denies "
        default:
            return self.rawValue
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

func processHTNHPISectionUsingData(_ data:[HPITypes:[String]]) -> String {
    var result = String()
    print(data)
    //returns for followup of hypertension.
    //patient denies [general].
    
    //patient denies TIA symptoms including: [tia]
    //patient is compliant with the following lifestyle modifications: [LS]
    //patient reports [general]
    //patient reports possible TIA symptoms including: [tia]
    //patient is not compliant with the following lifestyle modifications: [LS]
    
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

struct HPIHTNData {
    var htnButtons = [NSButton]()
    
    var general:[NSButton] {return htnButtons.filter { $0.state != .off && $0.tag == 6 }}
    var tia:[NSButton] {return htnButtons.filter { $0.state != .off && $0.tag == 7 }}
    var lifestyle:[NSButton] {return htnButtons.filter { $0.state != .off && $0.tag == 8 }}
    
    var positiveGen:[String] {return general.filter { $0.state == .mixed }.map { $0.title.lowercased().replacingOccurrences(of: "\n", with: "")}}
    var negativeGen:[String] {return general.filter { $0.state == .on }.map { $0.title.lowercased().replacingOccurrences(of: "\n", with: "")}}
    var positiveTIA:[String] {return tia.filter { $0.state == .mixed }.map { $0.title.lowercased().replacingOccurrences(of: "\n", with: "")}}
    var negativeTIA:[String] {return tia.filter { $0.state == .on }.map { $0.title.lowercased().replacingOccurrences(of: "\n", with: "")}}
    var positiveLS:[String] {return lifestyle.filter { $0.state == .mixed }.map { $0.title.lowercased().replacingOccurrences(of: "\n", with: "")}}
    var negativeLS:[String] {return lifestyle.filter { $0.state == .on }.map { $0.title.lowercased().replacingOccurrences(of: "\n", with: "")}}
    
    func getHPIHTNData() -> String {
        var negativeResults = [String]()
        var positiveResults = [String]()
        var finalResults = [String]()
        
        if !negativeGen.isEmpty {
            negativeResults.append(negativeGen.joined(separator: ", "))
        }
        if !negativeTIA.isEmpty {
            negativeResults.append("TIA symptoms including: \(negativeTIA.joined(separator: ", "))")
        }
        if !negativeLS.isEmpty {
            negativeResults.append("is not compliant with the following lifestyle modifications: \(negativeLS.joined(separator: ", "))")
        }
        if !positiveGen.isEmpty {
            positiveResults.append(positiveGen.joined(separator: ", "))
        }
        if !negativeTIA.isEmpty {
            positiveResults.append("possible TIA symptoms including: \(positiveTIA.joined(separator: ", "))")
        }
        if !negativeLS.isEmpty {
            positiveResults.append("compliance with the following lifestyle modifications: \(positiveLS.joined(separator: ", "))")
        }
        
        if !negativeResults.isEmpty {
            finalResults.append("Patient denies \(negativeResults.joined(separator: "; ")).")
        }
        if !positiveResults.isEmpty {
            finalResults.append("Patient reports \(positiveResults.joined(separator: "; "))")
        }
        
        if !finalResults.isEmpty {
            return "Patient returns for evaluation of hypertension. \(finalResults.joined(separator: "\n"))."
        } else {
            return ""
        }
    }
}
