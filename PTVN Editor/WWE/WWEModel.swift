//
//  WWEModel.swift
//  LIROS
//
//  Created by Fool on 12/13/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Foundation

struct WellWomanExam {
    static var fxOther = String()
    
    func processFxMatricesData(_ data:[(matrix:Int, selections:[Int])]) -> String {
        var resultArray = [String]()
        var results = String()
        for item in data {
            if let section = FxSection.init(rawValue: item.matrix) {
                resultArray.append("\(section.fullValue): \(processMatrixSelections(item.selections))")
            }
        }
        if !resultArray.isEmpty {
            results = "Family history reported:\n\(resultArray.joined(separator: "\n"))"
        }
        return results
    }
    
    func processMatrixSelections(_ selections:[Int]) -> String {
        var resultArray = [String]()
        
        for selection in selections {
            if let theSelection = FamilyRelationship.init(rawValue: selection) {
                resultArray.append(theSelection.fullValue)
            }
        }
        
        return resultArray.joined(separator: ", ")
    }
    
    func processWWEQuestionsFrom(_ data:[(Int, String?)]) -> String {
        var birthControlMed = String()
        var allergies = String()
        
        for item in data {
            switch item.0 {
            case 23: birthControlMed = " (\(item.1!))"
            case 72: allergies = " - \(item.1!)"
            default: continue
            }
        }
        
        var resultArray = [String]()
        for item in data {
            switch item.0 {
            case 1/* LastMammogram*/: resultArray.append("When was your last mammogram? \(item.1!)")
            case 2/* LastPeriod*/: resultArray.append("When was your last period? \(item.1!)")
            case 3/* LastPAP*/: resultArray.append("When was your last PAP test? \(item.1!)")
            case 4/* LastPAPNormal*/: resultArray.append("Were the results normal? YES")
            case 5/* LastPAPNormal*/: resultArray.append("Were the results normal? NO")
            case 6/* EverHadAbnormalPAP*/: resultArray.append("Have you ever had an abnormal PAP test? YES")
            case 7/* EverHadAbnormalPAP*/: resultArray.append("Have you ever had an abnormal PAP test? NO")
            case 8/* DateOfAbnormalPAP*/: resultArray.append("Abnormal PAP results on: \(item.1!)")
            case 9/* FrequencyOfPeriod*/: resultArray.append("How often do you usually get your period? \(item.1!)")
            case 10/* PeriodsRegular*/: resultArray.append("Are your periods usually regular? YES")
            case 11/* PeriodsRegular*/: resultArray.append("Are your periods usually regular? NO")
            case 12/* PeriodLength*/: resultArray.append("How many days do your periods usually last? \(item.1!)")
            case 13/* BloodFlow*/: resultArray.append("The blood flow is: \(item.1!)")
            case 14/* BleedingBetween*/: resultArray.append("Do you have any bleeding between periods? YES")
            case 15/* BleedingBetween*/: resultArray.append("Do you have any bleeding between periods? NO")
                
            case 16/* VaginalDischarge*/: resultArray.append("Do you have any vaginal discharge? YES")
                case 17/* VaginalDischarge*/: resultArray.append("Do you have any vaginal discharge? NO")
            case 18/* SexuallyActive*/: resultArray.append("Are you sexually active? YES")
                case 19/* SexuallyActive*/: resultArray.append("Are you sexually active? NO")
            case 20/* UseBirthControl*/: resultArray.append("If yes, do you and your partner use birth control? YES")
                case 21/* UseBirthControl*/: resultArray.append("If yes, do you and your partner use birth control? NO")
                
            case 22/* BirthControlMethod*/: resultArray.append("Method: \(item.1!)\(birthControlMed)")
                
            case 24/* STD*/: resultArray.append("Have you ever had a sexually transmitted disease? YES")
                case 25/* STD*/: resultArray.append("Have you ever had a sexually transmitted disease? NO")
            case 26/* DES*/: resultArray.append("Has your mother ever been exposed to DES? YES")
                case 27/* DES*/: resultArray.append("Has your mother ever been exposed to DES? NO")
            case 28/* FertilityMedicines*/: resultArray.append("Have you ever used fertility medicines? YES")
                case 29/* FertilityMedicines*/: resultArray.append("Have you ever used fertility medicines? NO")
            case 30/* HotFlashes*/: resultArray.append("Do you have hot flashes? YES")
                case 31/* HotFlashes*/: resultArray.append("Do you have hot flashes? NO")
            case 32/* HormoneReplacement*/: resultArray.append("Are you on hormone replacement? YES")
                case 33/* HormoneReplacement*/: resultArray.append("Are you on hormone replacement? NO")
            case 34/* Smoke*/: resultArray.append("Do you smoke? YES")
                case 35/* Smoke*/: resultArray.append("Do you smoke? NO")
            case 36/* SelfBreastExams*/: resultArray.append("How often do you perform self breast-exams? \(item.1!)")
            case 37/* HXBreastProblems*/: resultArray.append("Do you have a history of breast problems? YES")
                case 38/* HXBreastProblems*/: resultArray.append("Do you have a history of breast problems? NO")
            case 39/* BeenAbused*/: resultArray.append("Have you ever been abused? YES")
                case 40/* BeenAbused*/: resultArray.append("Have you ever been abused? NO")
            case 41/* FeelSafe*/: resultArray.append("Do you feel safe? YES")
                case 42/* FeelSafe*/: resultArray.append("Do you feel safe? NO")
            case 70/* Allergies*/: resultArray.append("Do you have any allergies? YES\(allergies)")
                case 71/* Allergies*/: resultArray.append("Do you have any allergies? NO")
            //case /* Allergens*/: resultArray.append(" \(item.1!)")
            case 73/* PeriodPain*/: resultArray.append("Pain during your usual period: \(item.1!)")
            case 74/* SexPain*/: resultArray.append("Pain during sex: \(item.1!)")
            case 75/* PMSPain*/: resultArray.append("PMS (premenstrual tension syndrome): \(item.1!)")
            case 76/* Pregnancies*/: resultArray.append("If you have been pregnant, please indicate how many ...:\nPregnancies: \(item.1!)")
            case 77/* Abortions*/: resultArray.append("Abortions: \(item.1!)")
            case 78/* Miscarriages*/: resultArray.append("Miscarriages: \(item.1!)")
            case 79/* LivingChildren*/: resultArray.append("Living children: \(item.1!)")
            case 80/* LiveBirths*/: resultArray.append("Full-term live births: \(item.1!)")
            case 81/* PrematureBirths*/: resultArray.append("Premature births: \(item.1!)")
            case 82/* OtherConcerns*/: resultArray.append("Please list any other concerns: \(item.1!)")
            default: continue
            }
        }
        
        
        return resultArray.joined(separator: "\n")
    }
    
    func getListItemsForID(_ id:Int) -> [String] {
        switch id {
        case 3/*lastPapChoices*/: return["", "1 year ago", "2 years ago", "3 or more years ago"]
        case 9/*periodFrequencyChoices*/: return ["", "14", "21", "24", "26", "28", "30", "32", "34"]
        case 12/*periodLengthChoices*/: return ["", "1", "2", "3", "4", "5", "6", "7", "8"]
        case 13/*bloodFlowChoices*/: return ["", "light", "moderate", "heavy"]
        case 22/*birthControlMethods*/: return ["", "OCP", "condoms", "diaphram", "IUD", "depo injection"]
        case 36/*selfExamFrequencyChoices*/: return ["", "weekly", "monthly", "twice per month", "every few months", "yearly"]
        case 77, 78: return ["", "0", "1", "2", "3", "4", "5"]
        case 76, 79, 80: return ["", "0", "1", "2", "3", "4", "5", "6"]
        case 81: return ["", "0", "1", "2", "3", "4"]
        default: return [""]
        }
    }
    
    enum FxSection:Int {
        case breast = 100
        case colon = 200
        case uterine = 300
        case overian = 400
        case other = 500
        case osteoporosis = 600
        case heart = 700
        
        var fullValue: String {
            switch self {
            case .breast: return "Breast cancer"
            case .colon: return "Colon cancer"
            case .uterine: return "Uterine cancer"
            case .overian: return "Overian cancer"
            case .other: return "Other cancers\(fxOther)"
            case .osteoporosis: return "Osteoporosis"
            case .heart: return "Heart disease"
            }
        }
    }
    
    enum FamilyRelationship:Int {
        case mother = 0
        case father
        case brother
        case sister
        case maternalGrandmother
        case maternalGrandfather
        case paternalGrandmother
        case paternalGrandfather
        case maternalAunt
        case maternalUncle
        case paternalAunt
        case paternalUncle
        case cousin
        case son
        case daughter
        case none
        
        var fullValue: String {
            switch self {
            case .mother: return "mother"
            case .father: return "father"
            case .brother: return "brother"
            case .sister: return "sister"
            case .maternalGrandmother: return "maternal grandmother"
            case .maternalGrandfather: return "maternal grandfather"
            case .paternalGrandmother: return "paternal grandmother"
            case .paternalGrandfather: return "paternal grandfather"
            case .maternalAunt: return "maternal aunt"
            case .maternalUncle: return "maternal uncle"
            case .paternalAunt: return "paternal aunt"
            case .paternalUncle: return "paternal uncle"
            case .cousin: return "cousin"
            case .son: return "son"
            case .daughter: return "daughter"
            case .none: return "no history"
            }
        }
    }
    
    
    enum WWEQuestions:String {
        case LastMammogram = "When was your last mammogram?"
        case LastPeriod = "When was your last period?"
        case LastPAP = "When was your last PAP test?"
        case LastPAPNormal = "Were the results normal?"
        case EverHadAbnormalPAP = "Have you ever had an abnormal PAP test?"
        case DateOfAbnormalPAP = "Abnormal PAP results on:"
        case FrequencyOfPeriod = "How often do you usually get your period?"
        case PeriodsRegular = "Are your periods usually regular?"
        case PeriodLength = "How many days do your periods usually last?"
        case BloodFlow = "The blood flow is:"
        case BleedingBetween = "Do you have any bleeding between periods?"
        case VaginalDischarge = "Do you have any vaginal discharge?"
        case SexuallyActive = "Are you sexually active?"
        case UseBirthControl = "If yes, do you and your partner use birth control?"
        case BirthControlMethod = "Method:"
        case STD = "Have you ever had a sexually transmitted disease?"
        case DES = "Has your mother ever been exposed to DES?"
        case FertilityMedicines = "Have you ever used fertility medicines?"
        case HotFlashes = "Do you have hot flashes?"
        case HormoneReplacement = "Are you on hormone replacement?"
        case Smoke = "Do you smoke?"
        case SelfBreastExams = "How often do you perform self breast-exams?"
        case HXBreastProblems = "Do you have a history of breast problems?"
        case BeenAbused = "Have you ever been abused?"
        case FeelSafe = "Do you feel safe?"
        //"\(finalFamilyHistory(historyList: familyHistory)!)" +
        case Allergies = "Do you have any allergies?"
        case Allergens = ""
        //"On a scale of 0 to 10, with 0 being no symptoms and 10 being severe symptoms, how would you describe the following:\n" +
        case PeriodPain = "Pain during your usual period:"
        case SexPain = "Pain during sex:"
        case PMSPain = "PMS (premenstrual tension syndrome):"
        //"If you have been pregnant, please indicate how many:\n" +
        case Pregnancies = "Pregnancies:"
        case Abortions = "Abortions:"
        case Miscarriages = "Miscarriages:"
        case LivingChildren = "Living children:"
        case LiveBirths = "Full-term live births:"
        case PrematureBirths = "Premature births:"
        case OtherConcerns = "Please list any other concerns:"
    }
    
}


