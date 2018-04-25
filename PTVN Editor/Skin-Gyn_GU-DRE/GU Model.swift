//
//  GU Model.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Foundation
struct GU {
	
	func processSectionFrom(_ data: [(Int, String?)]) -> String {
		var results = String()
		var resultArray = [String]()
		
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("normal uncircumcised phallus, no penile discharge, no lesions")
			case 2: resultArray.append("normal circumcised phallus, no penile discharge, no lesions")
			case 3: resultArray.append("testes normal size, no masses, no hernias, no inguinal lymphadenopathy")
			case 4: resultArray.append("no hernias")
			case 5: resultArray.append("DRE: prostate nontender, no masses, normal size, no rectal masses, ext/int rhoids, stool brown, heme negative")
			case 6: resultArray.append("asymmetric")
			case 7: resultArray.append("domed")
			case 8: resultArray.append("lumpy")
			case 9: resultArray.append("right inguinal hernia")
			case 10: resultArray.append("left inguinal hernia")
			case 19: resultArray.append(item.1!)
			default: continue
			}
		}
		
		if !resultArray.isEmpty {
			results = "GU: \(resultArray.joined(separator: ", "))"
		}
		
		return results
	}
}
