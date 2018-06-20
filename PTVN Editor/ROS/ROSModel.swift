//
//  ROSModel.swift
//  LIROS
//
//  Created by Fool on 4/6/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Foundation

struct rosSection {
	let sectionName:String
	let sectionTitlesAndStates:[(title: String, state: Int)]
	
	func processSection() -> (positives: String, negatives: String)? {
		var posNegList: (positiveList: [String], negativeList: [String])?
		var results: (positives: String, negatives: String)?
		
		//print(sectionTitlesAndStates)
		
		for item in sectionTitlesAndStates {
			if item.state == -1 {
				posNegList?.positiveList.append(item.title)
			} else if item.state == 1 {
				posNegList?.negativeList.append("no \(item.title)")
			}
		}
		
		if let theList = posNegList {
			//print("The list is not nil")
			if !theList.positiveList.isEmpty {
				results?.positives = "\(sectionName): \(theList.positiveList.joined(separator: ", "))"
			}
			if !theList.negativeList.isEmpty {
				results?.negatives = "\(sectionName): \(theList.negativeList.joined(separator: ", "))"
			}
		}
		
		
		
		return results
	}
	
}

func processROSForm(_ sections:[(sectionName:String, list:[(title:String, state:Int)] )]) -> String {
	var tempResults = (positiveResults: [String()], negativeResults: [String()])
	var finalPositives = String()
	var finalNegatives = String()
	var finalResults = String()
	
	for section in sections {
		let processedSection = processROSSectionsFor(section.sectionName, with: section.list)
		if !processedSection.positives.isEmpty {
		tempResults.positiveResults.append(processedSection.positives)
		}
		if !processedSection.negatives.isEmpty {
		tempResults.negativeResults.append(processedSection.negatives)
		}
	}
	
	//print("Positive results array is: \(tempResults.positiveResults)")
	//print("Negative results array is: \(tempResults.negativeResults)")
	
	if (tempResults.positiveResults != [""]) && (!tempResults.positiveResults.isEmpty){
		let filteredPositives = tempResults.positiveResults.filter{ $0 != ""}
		finalPositives = "(+) " + filteredPositives.joined(separator: "; ").replacingOccurrences(of: "\n", with: "") + "\n"
	}
	if (tempResults.negativeResults != [""]) && (!tempResults.negativeResults.isEmpty) {
		let filteredNegatives = tempResults.negativeResults.filter{ $0 != "" }
		finalNegatives = "(-) " + filteredNegatives.joined(separator: "; ").replacingOccurrences(of: "\n", with: "") + ".  "
	}
	
	//print(finalPositives)
	//print(finalNegatives)
	
	if finalPositives != "" || finalNegatives != "" {
		finalResults = "REVIEW OF SYSTEMS - ROS as per HPI and:\n" + finalPositives + finalNegatives + "All other systems reviewed and are negative.\nPMH, PSH, SHX, FHX, Meds reviewed."
	} else {
		finalResults = "REVIEW OF SYSTEMS - ROS as per HPI.  All systems reviewed and are negative.\nPMH, PSH, SHX, FHX, Meds reviewed."
	}
	
	
	return finalResults
}

func processROSSectionsFor(_ sectionName:String, with list:[(title:String, state:Int)] ) -> (positives: String, negatives: String) {
	var positives = [String]()
	var positiveResults = String()
	var negatives = [String]()
	var negativeResults = String()
	
	
	for item in list {
		if item.state == 1 {
			negatives.append("no \(item.title)")
		} else if item.state == -1 {
			positives.append(item.title)
		}
	}
	
	if !positives.isEmpty {
		positives = makeFirstCharacterInStringArrayUppercase(positives)
		positiveResults = "\(sectionName): " + positives.joined(separator: ", ")
	}
	
	if !negatives.isEmpty {
		negatives = makeFirstCharacterInStringArrayUppercase(negatives)
		negativeResults = "\(sectionName): " + negatives.joined(separator: ", ")
	}
	//print(positiveResults, negativeResults)
	return (positives: positiveResults, negatives: negativeResults)
}

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
