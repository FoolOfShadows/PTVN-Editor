//
//  ENT Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/8/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct ENT {
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		var earResults = [String]()
		var noseResults = [String]()
        var nareResults = [String]()
		var throatResults = [String]()
		
		//The ~= operator in the following closures is checking to see if the
        //presented range contains the variable
		earResults.append(processENTSubSectionsFrom(data.filter {1...9 ~= $0.0}.map {$0.0}))
		
		let ltmResults = data.filter {13...15 ~= $0.0}.map {$0.0}
		if !ltmResults.isEmpty {
			earResults.append("Left Tympanic Membrane: \(processENTSubSectionsFrom(ltmResults))")
		}
		let rtmResults = data.filter {10...12 ~= $0.0}.map {$0.0}
		if !rtmResults.isEmpty {
			earResults.append("Right Tympanic Membrane: \(processENTSubSectionsFrom(rtmResults))")
		}
		//Ear EAC subsection -- This needs to take into account the fact that these controllers have different output for
		//different states
		let eacResults = data.filter {(16...17 ~= $0.0) || (46...47 ~= $0.0)}.map {$0.0}
		if !eacResults.isEmpty {
			earResults.append("EAC: \(processENTSubSectionsFrom(eacResults))")
		}
		earResults = earResults.filter {!$0.isEmpty}
		if !earResults.isEmpty {
			resultArray.append("EARS: \(earResults.joined(separator: "\n"))")
		}
		
		noseResults.append(processENTSubSectionsFrom(data.filter {20...24 ~= $0.0}.map {$0.0}))
		let rnarResults = data.filter {26...30 ~= $0.0}.map {$0.0}
		if !rnarResults.isEmpty {
			nareResults.append("Nare R: \(processENTSubSectionsFrom(rnarResults))")
		}
		let lnarResults = data.filter {31...35 ~= $0.0}.map {$0.0}
		if !lnarResults.isEmpty {
			nareResults.append("Nare L: \(processENTSubSectionsFrom(lnarResults))")
		}
        if !nareResults.isEmpty {
            noseResults.append("Nasal mucosa: \(nareResults.joined(separator: ", "))")
        }
		noseResults = noseResults.filter {!$0.isEmpty}
		if !noseResults.isEmpty {
			resultArray.append("NOSE: \(noseResults.joined(separator: "\n"))")
		}
		
		//throatResults.append(processENTSubSectionsFrom(data.filter {40...45 ~= $0.0}.map {$0.0}))
		let opResults = data.filter {50...54 ~= $0.0}.map {$0.0}
		if !opResults.isEmpty {
			throatResults.append("Oropharynx: \(processENTSubSectionsFrom(opResults))")
		}
        throatResults.append(processENTSubSectionsFrom(data.filter {40...45 ~= $0.0}.map {$0.0}))
		throatResults = throatResults.filter {!$0.isEmpty}
		if !throatResults.isEmpty {
            resultArray.append("THROAT: \(throatResults.joined(separator: "; "))")
		}
		
		let other = data.filter {$0.0 == 60}
		if !other.isEmpty {
			if let otherText = other[0].1 {
				resultArray.append(otherText)
			}
		}
		
		if !resultArray.isEmpty {
			results = "ENT: \(resultArray.joined(separator: "\n"))"
		}
		
		return results
	}
	
	private func processENTSubSectionsFrom(_ tag:[Int]) -> String {
		var resultArray = [String]()
		
		for item in tag {
			switch item {
			case 1: resultArray.append("external auditory canals clear")
			case 2: resultArray.append("tympanic membranes normal")
			case 40: resultArray.append("oropharynx clear, moist mucus membranes")
			case 3: resultArray.append("otitis externa")
			case 4: resultArray.append("hearing loss - mild")
			case 5: resultArray.append("hearing loss - moderate")
			case 6: resultArray.append("hearing loss - severe")
			case 7: resultArray.append("hearing aid right ear")
			case 8: resultArray.append("hearing aid left ear")
			case 9: resultArray.append("hearing aids both ears")
			case 20: resultArray.append("normal nasal mucosa, normal septum and turbinates, no obstruction, Nare boggy bilaterally")
			case 23: resultArray.append("sinus tenderness - frontal")
			case 24: resultArray.append("sinus tenderness - maillary")
			case 10, 13, 28, 33, 52: resultArray.append("red")
			case 11, 14: resultArray.append("dull")
			case 12, 15: resultArray.append("scarred")
			case 16: resultArray.append("right ear complete wax occlusion")
			case 46: resultArray.append("right ear partial wax occlusion")
			case 17: resultArray.append("left ear complete wax occlusion")
			case 47: resultArray.append("left ear partial wax occlusion")
			case 26, 31: resultArray.append("boggy")
			case 27, 32: resultArray.append("swollen")
			case 29, 34: resultArray.append("pale")
			case 30, 35, 53: resultArray.append("dry")
			case 41: resultArray.append("dentition normal")
			case 42: resultArray.append("poor dentition")
			case 43: resultArray.append("fair dentition")
			case 44: resultArray.append("edentulus")
			case 45: resultArray.append("dentures")
			case 50: resultArray.append("streaky")
			case 51: resultArray.append("post nasal drip")
			case 54: resultArray.append("glossitis")
			default: continue
			}
		}
		
		return resultArray.joined(separator: ", ")
	}
}
