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
		print(data.title)
		result += "  Onset reported as \(data.title)."
	}
	
	return result
}

let phlegmColors = ["", "clear", "white", "yellow", "green", "tan", "gray", "bloody", "rusty", "brown", "frothy"]
