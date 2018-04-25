//
//  ProcInjModel.swift
//  LIROS
//
//  Created by Fool on 12/7/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Foundation

var fluTypeList = ["","Fluarix", "FluzoneQuad", "Fluzone Hi Dose"]

struct ProcInjModel {
    let earLavageList = ["", "right ear", "left ear", "both ears"]
    let nebulizerList = ["", "Albuterol", "Atrovent", "Duoneb"]
    
    func getListItemsForID(_ id:Int) -> [String] {
        switch id {
        case 1, 3, 5, 6, 7, 8, 14, 16: return /*deltGlutIMOnlyList*/ ["", "R Delt IM", "L Delt IM", "R Glut IM", "L Glut IM"]
        case 2, 4, 21: return /*deltGlutIMSCList*/ ["", "R Delt IM", "R Delt SC", "L Delt IM", "L Delt SC", "R Glut IM", "R Glut SC", "L Glut IM", "L Glut SC"]
        case 10: return /*forearmSCList*/ ["", "R Forearm SC", "L Forearm SC"]
        case 11, 13: return /*deltIMOnlyList*/ ["", "R Delt IM", "L Delt IM"]
        case 12: return /*deltIMSCList*/ ["", "R Delt IM", "R Delt SC", "L Delt IM", "L Delt SC"]
        case 15: return /*glutIMOnlyList*/ ["", "R Glut IM", "L Glut IM"]
        case 17: return /*upperArmSCOnlyList*/ ["", "R Upper Arm SC", "L Upper Arm SC"]
        case 9: return /*jointInjList*/ ["", "R Knee", "L Knee", "Both Knees", "R Shoulder", "L Shoulder", "Both Shoulders", "R Elbow", "L Elbow", "Both Elbows"]
        case 18: return /*kneeInjList*/ ["", "R Knee", "L Knee", "Both Knees"]
        case 31: return /*fluTypeList*/ fluTypeList
        case 35: return /*rocAmountList*/ ["", "1 gm/2.1 ml", "500 mg/1 ml"]
        case 26: return /*torAmountList*/ ["", "30", "60"]
        case 20: return /*hepVacList*/ ["", "A1", "A2", "B1", "B2", "B3", "TRx1", "TRx2", "TRx3"]
        //case 14: return /*dxList*/ ["", "v58.69", "v70.0"]
        default: return [""]
        }
    }
    
    func processInjectionsUsing(_ data:[(Int, String?)]) -> String {
        var resultArray = [String]()
        var results = String()
        var torDose = "NO DOSE CHOSEN"
        var vaccineType = "NO VACCINE TYPE CHOSEN"
        var rocDose = "NO DOSE CHOSEN"
        var hepVaccine = "NO VACCINE CHOSEN"
        
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
        
		func getHepVaccineTypeFrom(_ data:String) -> String {
			switch data {
			case "A1": return "Hepatitis A Vaccine #1: 0.5 ml"
			case "A2": return "Hepatitis A Vaccine #2: 0.5 ml"
			case "B1": return "Hepatitis B Vaccine #1: 0.5 ml"
			case "B2": return "Hepatitis B Vaccine #2: 0.5 ml"
			case "B3": return "Hepatitis B Vaccine #3: 0.5 ml"
			case "TRx1": return "Hepatitis Trx Vaccine #1: 0.5 ml"
			case "TRx2": return "Hepatitis Trx Vaccine #2: 0.5 ml"
			case "TRx3": return "Hepatitis Trx Vaccine #3: 0.5 ml"
			default: return ""
			}
		}
        
        for item in data {
            switch item.0 {
            case 26: torDose = item.1!
            case 31: vaccineType = item.1!
            case 35: rocDose = item.1!
            case 20: hepVaccine = getHepVaccineTypeFrom(item.1!)
            default: continue
            }
        }
        
        for item in data {
            switch item.0 {
            case 1: resultArray.append("Decadron 4 mg/1 ml + Kenalog 40 mg/1 ml \(item.1!), consent signed.")
            case 2: resultArray.append("Celestone 6 mg/1 ml \(item.1!), consent signed.")
            case 3: resultArray.append("Solumedrol 125 mg \(item.1!) consent signed.")
            case 4: resultArray.append("B12 1000 mcg/1 ml \(item.1!) consent signed.")
            case 5: resultArray.append("Phenergan 25 mg \(item.1!) consent signed.")
            case 7: resultArray.append("Testosterone Cypionate 200 mg/1 ml \(item.1!) consent signed.")
            case 6: resultArray.append("Toradol (Ketoralac) \(torDose) mg \(item.1!) consent signed.")
            case 8: resultArray.append("Estradiol Cypionate 5 mg/1ml \(item.1!) consent signed.")
            case 9: resultArray.append(getSiteSpecificArthroVerbiageFrom(item.1!))
            case 10: resultArray.append("PPD (Purified Protein Derivative) Mantoux TB Skin Test 0.1 ml/5 TU \(item.1!), consent signed.")
            case 11: resultArray.append("Flu shot: \(vaccineType) 0.5 ml \(item.1!) consent signed education: VIS given.")
            case 12: resultArray.append("Pneumovax 23: 0.5 ml \(item.1!) consent signed education: VIS given.")
            case 13: resultArray.append("Tdap 0.5 ml \(item.1!) consent signed.")
            case 14: resultArray.append("Nubain 10 mg + Phenergan 25 mg \(item.1!) consent signed.")
            case 15: resultArray.append("Rocephin \(rocDose) Lidocaine \(item.1!) consent signed.")
            case 16: resultArray.append("DepoProvera 150 mg/1 ml \(item.1!) consent signed.")
            case 17: resultArray.append("Procrit/Epogen 10,000 u \(item.1!) consent signed.")
            case 18: resultArray.append("Arthrocentesis \(item.1!) medial flexed knee approach, with injection of 1 cc 1% lidocaine + Synvisc ONE, after cleansed and prepped with betadine and alcohol.  Pt tolerated procedure well. EBL: none. Consent signed.")
            case 19: resultArray.append("Trigger point injection with Lidocaine 1 ml + Celestone 6 mg/1 ml \(item.1!).")
            case 21: resultArray.append("\(hepVaccine) \(item.1!), consent signed, education: VIS given.")
            case 22: resultArray.append(item.1!)
            default: continue
            }
        }
        
        if !resultArray.isEmpty {
            results = "Injection(s) given:\n\(resultArray.joined(separator: "\n"))"
        }
        
        return results
    }
    

    func processOfficeProceduresUsing(_ data:[(Int, String?)]) -> String {
        var resultArray = [String]()
        var results = String()
        
        func determineNebTreatmentFrom(_ type:String) -> String {
            switch type {
            case "Albuterol": return "Abluterol Sulfate 0.083% (2.5 mg/3 ml)"
            case "Atrovent": return "Atrovent (Ipratropium Bromide) 0.02% (0.5 mg/2.5 ml)"
            case "Duoneb": return "Duoneb (Ipratropium Bromide 0.5 mg + Albuterol sulfate 3 mg) in 3 ml"
            default: return ""
            }
        }
        
        for item in data {
            switch item.0 {
            case 1: resultArray.append("Pap smear")
            case 2: resultArray.append("Digital rectal exam")
            case 3: resultArray.append("Hemoccult Stool cards x 3 given for colon cancer screening.")
            case 4: resultArray.append("Incision and drainage of abscess, consent signe.d")
            case 5: resultArray.append("EKG, consent signed.")
            case 6: resultArray.append("Ear lavage of \(item.1!), consent signed.")
            case 7: resultArray.append("Nebulizer treatment using \(determineNebTreatmentFrom(item.1!)) solution.")
            case 8: resultArray.append("Cryo treatment x \(item.1!), consent signed.")
                case 9: resultArray.append("Skin tag removal x \(item.1!), consent signed.")
                case 10: resultArray.append("Suture/staple removal x \(item.1!), consent signed.")
            default: continue
            }
        }
            
            if !resultArray.isEmpty {
                results = "Office procedure(s) performed:\n\(resultArray.joined(separator: "\n"))"
            }
            return results
        }
    
    
    func processLabsOrderedUsing(_ data:[(Int, String?)]) -> String {
        var resultArray = [String]()
        var results = String()
        
        for item in data {
            switch item.0 {
            case 1: resultArray.append("Urine dip, consent signed.")
            case 2: resultArray.append("UCG, consent signed.")
            case 3: resultArray.append("UDS, consent signed.")
            case 4: resultArray.append("m UDS, consent signed.")
            case 5: resultArray.append("Rapid Flu A&B swab, consent signed.")
			case 26: resultArray.append("Flu swab tests positive for Influenza A")
			case 27: resultArray.append("Flu swab tests positive for Influenza B")
			case 6: resultArray.append("Flu swab tests negative for Influenza A")
			case 7: resultArray.append("Flu swab tests negative for Influenza B")
            case 10: resultArray.append("Glucometer finger blood sugar done in office today with a result of \(item.1!).")
            default: continue
            }
        }
        
        if !resultArray.isEmpty {
            results = "Lab(s) ordered:\n\(resultArray.joined(separator: "\n"))"
        }
        
        return results
    }
    
    func processABIResults(left:String, right:String) -> String {
        var resultArray = [String]()
        var results = String()
        if !left.isEmpty {
            resultArray.append("Left ABI Index: \(left)")
        }
        if !right.isEmpty {
            resultArray.append("Right ABI Index: \(right)")
        }
        if !resultArray.isEmpty {
            results = resultArray.joined(separator: "\n")
        }
        
        return results
    }
    

}
