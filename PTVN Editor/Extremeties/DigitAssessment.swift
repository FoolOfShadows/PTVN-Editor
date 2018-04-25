//
//  DigitAssessment.swift
//  Physical Exam 2
//
//  Created by Fool on 1/18/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation

class DigitAssessment {
	
	var oncResults = DigitAilment()
	var cyanResults = DigitAilment()
	var hammerResults = DigitAilment()
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		var sectionHeading = String()
		var appendage = String()
		
		for item in data {
			switch item.0 {
			case 54, 55: sectionHeading = item.1!
			case 56:
				sectionHeading = item.1!
				appendage = "toe(s)"
			case 57: appendage = "toe(s)"
			case 58: appendage = "finger(s)"
			default: continue
			}
		}
		
		func filterAllOutOf( _ array: inout [String], andAppend item: String) {
			array = array.filter {$0 != "all"}
			array.append(item)
		}
		
		func whereDoesItGo(_ item: String, forLeftSide left:Bool, andAll all:Bool) {
			switch (left, all) {
			case (true, false): switch (sectionHeading, appendage) {
			case ("Onychomycosis", "finger(s)"): filterAllOutOf(&oncResults.leftFingers, andAppend: item)
			case ("Cyanosis", "finger(s)"): filterAllOutOf(&cyanResults.leftFingers, andAppend: item)
			case ("Onychomycosis", "toe(s)"): filterAllOutOf(&oncResults.leftToes, andAppend: item)
			case ("Cyanosis", "toe(s)"): filterAllOutOf(&cyanResults.leftToes, andAppend: item)
			case ("Hammer Toes", "toe(s)"): filterAllOutOf(&hammerResults.leftToes, andAppend: item)
			default: ""
				}
			case (false, false): switch (sectionHeading, appendage) {
			case ("Onychomycosis", "finger(s)"): filterAllOutOf(&oncResults.rightFingers, andAppend: item)
			case ("Cyanosis", "finger(s)"): filterAllOutOf(&cyanResults.rightFingers, andAppend: item)
			case ("Onychomycosis", "toe(s)"): filterAllOutOf(&oncResults.rightToes, andAppend: item)
			case ("Cyanosis", "toe(s)"): filterAllOutOf(&cyanResults.rightToes, andAppend: item)
			case ("Hammer Toes", "toe(s)"): filterAllOutOf(&hammerResults.rightToes, andAppend: item)
			default: ""
				}
			case (true, true): switch (sectionHeading, appendage) {
			case ("Onychomycosis", "finger(s)"): oncResults.leftFingers = [item]
			case ("Cyanosis", "finger(s)"): cyanResults.leftFingers = [item]
			case ("Onychomycosis", "toe(s)"): oncResults.leftToes = [item]
			case ("Cyanosis", "toe(s)"): cyanResults.leftToes = [item]
			case ("Hammer Toes", "toe(s)"): hammerResults.leftToes = [item]
			default: ""
				}
			case (false, true): switch (sectionHeading, appendage) {
			case ("Onychomycosis", "finger(s)"): oncResults.rightFingers = [item]
			case ("Cyanosis", "finger(s)"): cyanResults.rightFingers = [item]
			case ("Onychomycosis", "toe(s)"): oncResults.rightToes = [item]
			case ("Cyanosis", "toe(s)"): cyanResults.rightToes = [item]
			case ("Hammer Toes", "toe(s)"): hammerResults.rightToes = [item]
			default: ""
				}
			}
		}
		
		for item in data {
			switch item.0 {
			case 59: whereDoesItGo("1st", forLeftSide: true, andAll: false)
			case 60: whereDoesItGo("2nd", forLeftSide: true, andAll: false)
			case 61: whereDoesItGo("3rd", forLeftSide: true, andAll: false)
			case 62: whereDoesItGo("4th", forLeftSide: true, andAll: false)
			case 63: whereDoesItGo("5th", forLeftSide: true, andAll: false)
			case 64: whereDoesItGo(item.1!.lowercased(), forLeftSide: true, andAll: true)
			case 65: whereDoesItGo("1st", forLeftSide: false, andAll: false)
			case 66: whereDoesItGo("2nd", forLeftSide: false, andAll: false)
			case 67: whereDoesItGo("3rd", forLeftSide: false, andAll: false)
			case 68: whereDoesItGo("4th", forLeftSide: false, andAll: false)
			case 69: whereDoesItGo("5th", forLeftSide: false, andAll: false)
			case 70: whereDoesItGo(item.1!.lowercased(), forLeftSide: false, andAll: true)
			default: continue
			}
		}
		
		if !oncResults.digitOutput().isEmpty {
			resultArray.append("Onychomycosis: \(oncResults.digitOutput())")
		}
		if !cyanResults.digitOutput().isEmpty {
			resultArray.append("Cyanosis: \(cyanResults.digitOutput())")
		}
		if !hammerResults.digitOutput().isEmpty {
			resultArray.append("Hammer Toe(s) on: \(hammerResults.digitOutput())")
		}
		
		if !resultArray.isEmpty {
			results = resultArray.joined(separator: "\n")
		}
		
		return results
	}
}

class DigitAilment {
	var leftFingers = [String]()
	var rightFingers = [String]()
	var leftToes = [String]()
	var rightToes = [String]()
	
	func digitOutput() -> String {
		var resultArray = [String]()
		var results = String()
		
		if !leftFingers.isEmpty {
			leftFingers = Array(Set(leftFingers))
			resultArray.append("left finger(s): \(leftFingers.sorted().joined(separator: ", "))")
		}
		if !rightFingers.isEmpty {
			rightFingers = Array(Set(rightFingers))
			resultArray.append("right finger(s): \(rightFingers.sorted().joined(separator: ", "))")
		}
		if !leftToes.isEmpty {
			leftToes = Array(Set(leftToes))
			resultArray.append("left toes(s): \(leftToes.sorted().joined(separator: ", "))")
		}
		if !rightToes.isEmpty {
			rightToes = Array(Set(rightToes))
			resultArray.append("right toe(s): \(rightToes.sorted().joined(separator: ", "))")
		}
		
		if !resultArray.isEmpty {
			results = resultArray.joined(separator: "; ")
		}
		
		return results
	}
	
}
