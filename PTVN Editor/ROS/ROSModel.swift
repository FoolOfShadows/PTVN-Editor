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
                results.append(getOutputFor(item.title))
            }
        }
        return results
    }
    
    func getOutputFor(_ title:String) -> String {
        switch title {
        //General
        case "Wt Loss": return "Weight loss"
        case "Wt Gain": return "Weight gain"
        case "App Loss": return "Loss of appetite"
        case "Fever": return title
        case "Chills": return title
        case "Sweats": return title
        case "Fatigue": return "Fatigue/malaise"
        case "Weakness": return title
        case "Insomnia": return title
        //GUE
        case "Pnfl Urin": return "Painful urination"
        case "Blood": return "Blood in urine"
        case "Frequency": return "Frequency in urination"
        case "Urgency": return "Urgency in urination"
        case "U Incont": return "Urinary incontinence"
        case "S Incont": return "Stool incontinence"
        case "Nocturia": return title
        case "Hesitency": return "Hesitency or dribbling"
        case "EDS": return "Erectile disfunction"
        case "Dec Libido": return "Decreased libido"
        case "Irr Periods": return "Irregular or heavy periods"
        case "Vag Dis": return "Vaginal discharge"
        case "Brst Dis": return "Breast discharge"
        case "Hot Flashes": return "Hot flashes"
        case "Flushing": return title
        case "Goiter": return title
        case "Swl Glands": return "Swollen glands"
        case "Thirst": return "Excessive thirst"
        case "Heat Int": return "Heat intolerance"
        case "Cold Int": return "Cold intolerance"
        //PSYCH
        case "Stress": return title
        case "Depression": return title
        case "Anxiety": return "Anxiety/Nerves"
        case "Panic": return "Panic attacks"
        case "Mood": return "Mood swings"
        case "Crying": return title
        case "Poor Conc": return "Poor concentration"
        case "Memory": return "Memory loss"
        case "Confusion": return title
        case "Hallucinations": return "Hallucinations (audio/visual)"
        case "Suicidal/Hom": return "Suicidal/homicidal thoughts"
        case "Paranoia": return "Paranoid thoughts"
        case "Grief": return title
        //GI
        case "Ab Pain": return "Abdominal pain"
        case "Pelvic Pain:": return "Pelvic pain:"
        case "Nausea": return title
        case "Vomiting": return title
        case "Diarrhea": return title
        case "Constipation": return title
        case "Hemorrhoids": return title
        case "Bloody Stool": return "Bloody or black stool"
        case "Bloody Vomit": return "Bloody vomit"
        case "Gas": return title
        case "Bloating": return title
        case "Indigestion": return title
        case "Heartburn": return title
        case "Trbl Swallowing": return "Trouble or pain swallowing"
        case "Early Fullness": return "Early satiety/fullness"
        //EYE
        case "Blurry Vision": return "Blurry vision"
        case "Poor Vision": return "Poor vision"
        case "Watery/Itchy/Red": return "Watery/Itchy/Red eyes"
        case "Double Vision": return "Double vision"
        case "Eye Pain": return "Eye pain"
        //ENT
        case "Ear Ache": return "Ear ache"
        case "Ear Drainage": return "Ear drainage"
        case "Hearing Loss": return "Hearing loss"
        case "Ringing Ears": return "Tinnitus (ringing ears)"
        case "Runny Nose": return "Runny nose"
        case "Sneezing": return title
        case "Congestion": return "Nasal/Sinus congestion"
        case "Nasal Drip": return "Post nasal drip"
        case "Nose Bleed": return "Nose bleed"
        case "Smell Loss": return "Loss of smell"
        case "Taste Loss": return "Loss of taste"
        case "Sore Throat": return "Sore throat"
        case "Mouth Sores": return "Mouth sores"
        case "Hoarse": return "Hoarse voice"
        case "Laryngitis": return "Laryngitis"
        //MSK
        //case "Weakness": return title
        case "Stiffness": return title
        case "Swelling": return title
        case "Joint Ache": return "Joint ache"
        case "Muscle Ache": return "Muscle ache"
        case "Cramps": return title
        case "Spasms": return title
        //ENDO
        case "Bruising": return title
        case "Transfusion": return "Blood transfusion"
            
        //RESP
        case "Wheezing": return title
        case "Dry Cough": return "Dry cough"
        case "Prod Cough": return "Productive cough"
        case "Bldy Sputum": return "Bloody sputum"
        case "SOB": return "Shortness of breath"
        case "Dyspnea": return "Dyspnea on exertion"
        case "Snoring": return title
        case "Apnea": return title
        case "Day Sleep": return "Excess daytime sleepiness"
        case "Pleurisy": return title
        case "Pnfl Breaths": return "Painful breaths"
        //NEURO
        case "Seizures": return title
        case "Stroke Symp": return "TIA or stroke symptoms"
        case "Headaches": return title
        case "Tremors": return title
        case "Twitches": return title
        case "Jerks": return title
        case "Numbness": return title
        case "Tingling": return title
        case "Fainting": return "Syncope/Fainting"
        case "Vertigo": return "Vertigo/Spinning"
        case "Dizziness": return title
        case "Light-hd": return "Light-headed"
        case "Balance": return "Poor balance"
        case "Falling": return title
        //CARDIO
        case "Chest Pain": return "Chest pain"
        case "Angina": return title
        case "Palitations": return title
        case "Palp - Racing": return "Palpitations - racing"
        case "Palp - Skipping": return "Palpitations - skipping"
        case "Irr Heart Beat": return "Irregular heart beat"
        case "Leg Cramps": return "Leg cramps"
        //case "Swelling": return title
        case "Diff Breathing": return "Can't breath laying down"
        case "Wake Gasping": return "Wake up gasping for air"
        //DERM
        case /*"Bruising",*/ "Itching", "Jaundice", "Rash", "Hives", "Lumps", "Sores", "Ulcers": return title
        //case "Swl Glands": return "Swollen glands"
        case "Hair Loss": return "Hair loss"
        case "Excess Hair": return "Excess hair"
        case "Dry Skn/Eye/Mth": return "Dry skin/eyes/mouth"
        case "Poor healing": return "Poor healing wounds"
        case "Mole Change": return "Changing moles"
        case "Abcessess": return "Abscesses/Boils"
        //DEFAULT
        default: return ""
        }
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
                        results += selections.map { (tag:entry.value, title:$0, state:-1) }
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
                    results += selections.map { (tag:entry.value, title:$0, state:1) }
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


