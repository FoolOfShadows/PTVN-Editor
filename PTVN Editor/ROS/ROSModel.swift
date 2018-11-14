//
//  ROSModel.swift
//  LIROS
//
//  Created by Fool on 4/6/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

//struct rosSection {
//    let sectionName:String
//    let sectionTitlesAndStates:[(title: String, state: Int)]
//
//    func processSection() -> (positives: String, negatives: String)? {
//        var posNegList: (positiveList: [String], negativeList: [String])?
//        var results: (positives: String, negatives: String)?
//
//        //print(sectionTitlesAndStates)
//
//        for item in sectionTitlesAndStates {
//            if item.state == -1 {
//                posNegList?.positiveList.append(item.title)
//            } else if item.state == 1 {
//                posNegList?.negativeList.append("no \(item.title)")
//            }
//        }
//
//        if let theList = posNegList {
//            //print("The list is not nil")
//            if !theList.positiveList.isEmpty {
//                results?.positives = "\(sectionName): \(theList.positiveList.joined(separator: ", "))"
//            }
//            if !theList.negativeList.isEmpty {
//                results?.negatives = "\(sectionName): \(theList.negativeList.joined(separator: ", "))"
//            }
//        }
//
//
//
//        return results
//    }
//
//}

struct rosSection {
    let sectionName:String
    let sectionData:[(title:String, state:Int)]
    var posResults:String { let pos = populateResultsFor(-1)
        //print("Pos results: \(pos)")
        if !pos.isEmpty {
            return "\(sectionName): \(pos.joined(separator: ", "))"
        } else {
            return String()
        }
    }
    var negResults:String { let negs = populateResultsFor(1)
        if !negs.isEmpty {
            return "\(sectionName): \(negs.map {"no \($0)"}.joined(separator: ", "))"
        } else {
            return String()
        }
    }
    var fullData:(sectionName: String, list: [(title: String, state: Int)]) { return (sectionsName: sectionName, list:sectionData) as! (sectionName: String, list: [(title: String, state: Int)]) }
    
    func populateResultsFor(_ state:Int) -> [String] {
        var results = [String]()
        for item in sectionData {
            if item.state == state {
                //print(item.title)
                results.append(ROSOutput().getOutputFor(item.title))
            }
        }
        return results
    }
    
    
    
}
//FIXME: Redoing how the ROS sections get processed
func processROSForm(_ sections: [rosSection]) -> String {
    var tempResults = (positiveResults: [String()], negativeResults: [String()])
    var finalPositives = String()
    var finalNegatives = String()
    var finalResults = String()
    
    for section in sections {
        tempResults.positiveResults.append(section.posResults)
        tempResults.negativeResults.append(section.negResults)
    }
    
    let filteredPositives = tempResults.positiveResults.filter{ !$0.isEmpty }
    let filteredNegatives = tempResults.negativeResults.filter{ !$0.isEmpty }
    print("Positive results array is: \(filteredPositives)")
    print("Negative results array is: \(filteredNegatives)")
    
    if /*(tempResults.positiveResults != [""]) &&*/ (!filteredPositives.isEmpty){
        //let filteredPositives = tempResults.positiveResults.filter{ !$0.isEmpty }
        finalPositives = "(+) " + filteredPositives.joined(separator: "; ").replacingOccurrences(of: "\n", with: "") + "\n"
    }
    if /*(tempResults.negativeResults != [""]) && */(!filteredNegatives.isEmpty) {
        //let filteredNegatives = tempResults.negativeResults.filter{ !$0.isEmpty }
        finalNegatives = "(-) " + filteredNegatives.joined(separator: "; ").replacingOccurrences(of: "\n", with: "") + ".  "
    }
    
    if finalPositives != "" || finalNegatives != "" {
        finalResults = "REVIEW OF SYSTEMS - ROS as per HPI and:\n" + finalPositives + finalNegatives + "All other systems reviewed and are negative.\nPMH, PSH, SHX, FHX, Meds reviewed."
    } else {
        finalResults = "REVIEW OF SYSTEMS - ROS as per HPI.  All systems reviewed and are negative.\nPMH, PSH, SHX, FHX, Meds reviewed."
    }
    
    return finalResults
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
	
	print("Positive results array is: \(tempResults.positiveResults)")
	print("Negative results array is: \(tempResults.negativeResults)")
	
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

func parseExistingROSData(_ data:String) -> [(tag:Int, title:String, state:Int)]? {
    let sectionHeaders = ["GEN":1, "GI":2, "PSYCH":3, "GU":4, "ENDO":5, "ENT":6, "EYE":7, "MSK":8, "HEMO":9, "RESP":10, "NEURO":11, "CARDIO":12, "DERM":13]
    
    //var resultDictionary:[Int:[String]] = [:]
    var results = [(tag:Int, title:String, state:Int)]()
    
    if data.contains("(+)") {
            let positiveData = data.simpleRegExMatch("(?s)\\(\\+\\).*?(\\(-\\)|(All\\sother\\ssystems))").cleanTheTextOf(["\\(\\+\\) ", "\\(-\\)", "All\\sother\\ssystems"])
            //print(positiveData)
            for entry in sectionHeaders {
                if positiveData.contains(entry.key) {
                    //positiveData = positiveData.replacingOccurrences(of: ",", with: "&")
                    let selections = positiveData.simpleRegExMatch("(?s)\(entry.key): .*?(;|(\\(-\\))|(All)|\\z)").cleanTheTextOf(["\(entry.key): ", ";"]).components(separatedBy: ", ")
                    //print(selections)
                    if !selections.isEmpty {
                        //resultDictionary[entry.value] = selections
                        results += selections.map { (tag:entry.value, title:ROSTitles().getTitleFor($0), state:-1) }
                    }
            }
            
        }
    }
    
    if data.contains("(-)") {
        //print("There is negative data")
        let negativeData = data.simpleRegExMatch("(?s)\\(-\\).*?(All\\sother\\ssystems)").cleanTheTextOf(["No ", "no ", "\\(-\\)", "All\\sother\\ssystems"])
        //print("The - data is: \(negativeData)")
        for entry in sectionHeaders {
            if negativeData.contains(entry.key) {
                let selections = negativeData.simpleRegExMatch("(?s)\(entry.key): .*?(;|(All\\sother\\ssystems)|\\z)").cleanTheTextOf(["\(entry.key): ", "All\\sother\\ssystems", ";", "\\."]).components(separatedBy: ", ")
                //print(selections)
                if !selections.isEmpty {
                    //resultDictionary[entry.value] = selections
                    results += selections.map { (tag:entry.value, title:ROSTitles().getTitleFor($0), state:1) }
                }
            }
            
        }
    }
    //print(results)
    if !results.isEmpty {
        return results
    } else {
        return nil
    }
    
}


