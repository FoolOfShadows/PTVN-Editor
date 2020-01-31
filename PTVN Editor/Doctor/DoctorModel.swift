//
//  DoctorModel.swift
//  LIROS
//
//  Created by Fool on 10/20/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Foundation
var commonMedsList = ["", "Amoxicillin 500 mg —-> 1 by mouth three times daily x 10 days, dispense # 30, no refill", "Amoxicilin 875 mg —-> 1 by mouth twice daily x 10 days, no refill", "Augmentin 875/125 mg —-> 1 by mouth twice daily x 10 days,", "Levaquin (Levoflaxacin) 750 mg —-> 1 by mouth once daily x 5 days, no refill", "Levaquin (Levoflaxacin) 500 mg —-> 1 by mouth once daily x 7 days, No refill", "Zithromax Z pack 5 day = Azithromycin 250 mg —-> 2 po at once on 1st day, then 1 by mouth once daily x 4 more days, # 6 tabs, no Refill", "Bactrim DS (Tirmethaprim/Sulfamethoxizole) 800/160 mg —-> 1 by mouth twice daily x 10 days", "Cleocin (Clindamycin) 150 mg —->", "Cleocin (Clindamycin) 300 mg", "Keflex (Cephalexin) 500 mg", "Omnicef (Cefdinir) 300 mg", "Prednisone 5 day", "Prednisone Taper", "Medial DosePack"]
let jointList = ["", "Right Knee", "Left Knee", "Both Knees", "Right Shoulder", "Left Shoulder", "Both Shoulders", "Right Elbow", "Left Elbow", "Both Elbows"]
let kneeList = ["", "Right Knee", "Left Knee", "Both Knees"]

struct DataReview {
	func processSectionData(_ data:[(Int, String?)]) -> String {
        print("processing: \(data)")
		var results = String()
		var resultArray = [String]()
		var letterType = "(to be determined)"
		
		for item in data {
			switch item.0 {
			case 30: letterType = item.1!
			default: continue
			}
		}
		
		for item in data {
			switch item.0 {
			case 1: resultArray.append("Labs reviewed")
			case 2: resultArray.append( "Tests reviewed")
			case 3: resultArray.append( "Out patient fasting labs ordered.")
			case 4: resultArray.append( "Get records")
			case 5: resultArray.append( "Continue current pain medication dosage")
			case 6: resultArray.append( "Colonoscopy results reviewed")
			case 7: resultArray.append( "Stool card results reviewed")
			case 8: resultArray.append( "Diabetic eye exam results reviewed")
			case 9: resultArray.append( "Mammogram results reviewed")
			case 10: resultArray.append("Available hospital records reviewed.")
			case 11: resultArray.append( "Current and hospital discharge medication list reviewed (1111F).")
			case 12: resultArray.append( "^^Disability forms need to be filled out.")
			case 13: resultArray.append( "^^Patient needs letter about \(letterType)")
			case 15: resultArray.append( "Patient declines colonoscopy")
			case 16: resultArray.append( "Patient declines stool cards")
			case 17: resultArray.append( "Patient declines diabetic eye exam")
			case 18: resultArray.append( "Patient declines mammogram")
			case 25: resultArray.append("Patient has requested early refills on pain medications.  Patient admonished regarding health risks and consequences of overtaking pain medications and strongly admonished to take the medication as prescribed and referred to the pain treatment agreement.")
            case 50: resultArray.append("The patient would benefit from a back brace to support weak spinal muscles and reduce pain by restricting trunk mobility.")
            case 51: resultArray.append("Patient qualifies for CPAP with a respiratory disturbance index equal to or greater than 15, or between 5 and 14 with comorbidities.")
            case 52: resultArray.append("Patient qualifies for oxygen with a pulse ox less than or qual to 89% for five minutes or more.")
            case 53: resultArray.append("Patient qualifies for oxygen with lowest oxygen desaturation = 80% on room air and oxygen saturation less than or equal to 89? for 48 min.")
            case 54: resultArray.append("Bedside commode")
			default: continue
			}
		}
		
		
		//        var finalResult = String()
		//        let resultsStrings = getDescriptionOfItem(data, fromStruct: self) ?? [String]()
		
		if !resultArray.isEmpty {
			results = resultArray.joined(separator: "\n")
		}
		return results
	}
}

struct Education:StructsWithDescriptionOutput {
    func getOutputFor(_ id:Int) -> String? {
        switch id {
        case 1: return "Weight loss diet with calorie restriction and food diary counseled and admonished, info given."
        case 2: return "Diabetic diet and lifestyle counseling and info given, 45 gm carb per meal."
        case 3: return "Low fat, low cholesterol diet and exercise counseling and info given."
        case 4: return "Low salt and cardiac diet counseling and info given, DASH diet, 2400 mg Sodium per day."
        case 5: return "Hypertension goals, lifestyle management counseling and info given."
        case 6: return "Dietary fiber education and info given."
        case 7: return "Coumadin diet education with Vitamin K food content info given."
        case 8: return "Exercise counseling, guidance and education given."
        case 9: return "Tobacco cessation admonished: counseling and info given (3-10 min)."
        case 10: return "Stress and anxiety management counseling given."
        case 11: return "Treatment agreement discussed and reviewed with patient. Signed copy given to patient."
        case 12: return "Stroke warning signs discussed and info given."
        case 13: return "Depression management counseling and resources given."
        case 14: return "Adverse health consequences of alcohol discussed and alcohol cessation admonished."
        case 15: return "Gastroesophageal Reflux diet and lifestyle modifications discussed and info given."
        case 16: return "Thyroid symptoms discussed."
        default: return nil
        }
    }
    
    func processSectionData(_ data:[(Int, String?)]) -> String {
        var finalResult = String()
        let resultsStrings = getDescriptionOfItem(data, fromStruct: self) ?? [String]()
        
        if !resultsStrings.isEmpty {
            finalResult = "Patient education done:\n\(resultsStrings.joined(separator: "\n"))"
        }
        return finalResult
    }
}

struct Lab:StructsWithDescriptionOutput {
    func getOutputFor(_ id:Int) -> String? {
        switch id {
        case 1: return "Urine Dip, consent signed"
        case 2: return "UCG, consent signed"
        case 3: return "m UDS, consent signed"
        case 4: return "UDS, consent signed"
        case 5: return "Rapid Flu A&B Swab, consent signed"
        case 10: return "Glucometer finger blood sugar done in office today = "
        default: return nil
        }
    }
    
    func processSectionData(_ data:[(Int, String?)]) -> String {
        var finalResult = String()
        let resultsStrings = getDescriptionOfItem(data, fromStruct: self) ?? [String]()
        
        if !resultsStrings.isEmpty {
            finalResult = "Lab(s) ordered:\n\(resultsStrings.joined(separator: "\n"))"
        }
        return finalResult
    }
}

struct Procedures {
    
    func processProceduresUsing(_ data:[(Int, String?)]) -> String {
        var resultArray = [String]()
        var results = String()
        for item in data {
            switch item.0 {
            case 1: resultArray.append("Digital rectal exam.")
            case 2: resultArray.append("Hemoccult Stool cards x 3 given for colon cancer screening.")
            case 3: resultArray.append("Incision and drainage of abscess, consent signed.")
            case 4: resultArray.append("EKG, consent signed.")
            case 10: resultArray.append("Cryo x \(item.1!), consent signed.")
            case 11: resultArray.append("Skin tag removal x \(item.1!), consent signed.")
            case 12: resultArray.append("Suture/staple removal x \(item.1!), consent signed.")
            default: continue
            }
        }
        
        if !resultArray.isEmpty {
            results = "Office procedure(s) performed:\n\(resultArray.joined(separator: "\n"))"
        }
        return results
    }
}

struct Injections {
    func processInjectionsUsing(_ data:[(Int, String?)]) -> String {
        var resultArray = [String]()
        var results = String()
        
        func getSiteSpecificArthroVerbiageFrom(_ data:String) -> String {
            if data.range(of: "Knee") != nil {
                return "Arthrocentesis \(data) medial flexed knee approach, with injection of 1 cc 1% lidocaine + 1 cc Marcaine + 1 cc (6 mg) Celestone, after cleansed and prepped with betadine and alcohol.  Pt tolerated procedure well. EBL: none. Consent signed."
            } else if data.range(of: "Elbow") != nil  {
                return "Arthrocentesis \(data) olecranon bursa / lateral epicondyle, with injection of 1 cc 1% lidocaine + 1 cc (6 mg) Celestone, after cleansed and prepped with betadine and alcohol.  Pt tolerated procedure well. EBL: none. Consent signed."
            } else if data.range(of: "Shoulder") != nil  {
                return "Arthrocentesis \(data) posterior approach, with injection of 1 cc 1% lidocaine + 1 cc Marcaine + 1 cc (6 mg) Celestone, after cleansed and prepped with betadine and alcohol.  Pt tolerated procedure well. EBL: none. Consent signed."
            } else {
                return ""
            }
        }
        
        for item in data {
            switch item.0 {
            case 1: resultArray.append("Decadron 4 mg/1 ml + Kenalog 40 mg/1 ml")
            case 2: resultArray.append("Celestone 6 mg/1 ml")
            case 3: resultArray.append("Solumedrol 125 mg")
            case 4: resultArray.append("B12 1000 mcg/1 ml")
            case 5: resultArray.append("Phenergan 25 mg")
            case 6: resultArray.append("Toradol (Ketoralac)")
            case 7: resultArray.append("Testosterone Cypionate 200 mg/1 ml")
            //case 6: resultArray.append("Toradol (Ketoralac)")
            case 8: resultArray.append("Estradiol Cypionate 5 mg/1ml")
            case 20: resultArray.append(getSiteSpecificArthroVerbiageFrom(item.1!))
            case 9: resultArray.append("PPD (Purified Protein Derivative) Mantoux TB Skin Test 0.1 ml/5 TU")
            case 10: resultArray.append("Flu shot: 0.5 ml")
            case 11: resultArray.append("Pneumovax 23: 0.5 ml")
            case 12: resultArray.append("Tdap 0.5 ml")
            case 13: resultArray.append("Nubain 10 mg + Phenergan 25 mg")
            case 14: resultArray.append("Rocephin Lidocaine")
            case 15: resultArray.append("DepoProvera 150 mg/1 ml")
            case 16: resultArray.append("Procrit/Epogen 10,000 u")
            case 21: resultArray.append("Arthrocentesis \(item.1!) medial flexed knee approach, with injection of 1 cc 1% lidocaine + Synvisc ONE, after cleansed and prepped with betadine and alcohol.  Pt tolerated procedure well. EBL: none. Consent signed.")
            case 22: resultArray.append("Trigger point injection with Lidocaine 1 ml + Celestone 6 mg/1 ml \(item.1!).")
            case 25: resultArray.append("\(item.1!)")
            case 30: resultArray.append("Prevnar 13: 0.5 ml IM, Rx written and given to patient.")
            default: continue
            }
        }
        
        if !resultArray.isEmpty {
            results = "Injection(s) given/written:\n\(resultArray.joined(separator: "\n"))"
        }
        
        return results
    }
}

struct Assessment {
	func processAssessmentUsingArray(_ list:[String], and data:[String]) -> String {
		var resultArray = [String]()
		if !list.isEmpty {
			resultArray.append(list.map {$0.prependDashToLine()}.joined(separator: "\n"))
		}
		
		if !data.isEmpty {
			resultArray.append(data.map {"Lvl \($0)"}.joined(separator: "\n"))
		}
		
		return resultArray.joined(separator: "\n")
	}
}

struct PreOp:StructsWithDescriptionOutput {
    func getOutputFor(_ id:Int) -> String? {
        switch id {
        case 1: return "Patient is not currently on any blood thinners."
        case 2: return "aspirin"
        case 3: return "Plavix"
        case 4: return "Coumadin"
        case 5: return "Xarelto"
        case 6: return "Eliquis"
        case 7: return "Pradaxa"
        default: return nil
        }
    }
    
    func processSectionData(_ data:[(Int, String?)]) -> String {
        var finalResult = String()
        if data.count > 0 && data[0].0 == 1 {
            finalResult = "Patient is medically clear for surgery with low cardiac risk. Use standard peri-operative precautions including beta-blocker.  Patient is not currently on any blood thinners."
        } else {
            let resultsStrings = getDescriptionOfItem(data, fromStruct: self) ?? [String]()
            
            if !resultsStrings.isEmpty {
                finalResult = "Patient is medically clear for surgery with low cardiac risk. Use standard peri-operative precautions including beta-blocker. May hold blood thinners including: \(resultsStrings.joined(separator: ", "))."
            }
        }
        return finalResult
    }
}
