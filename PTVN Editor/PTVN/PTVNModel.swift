//
//  MessageModel.swift
//  PhoneMessages
//
//  Created by Fool on 3/6/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa


enum SectionDelimiters:String {
    case patientNameStart = "#PATIENTNAME"
    case patientNameEnd = "PATIENTNAME#"
    case patientDOBStart = "#PATIENTDOB"
    case patientDOBEnd = "PATIENTDOB#"
    case patientAgeStart = "#PATIENTAGE"
    case patientAgeEnd = "PATIENTAGE#"
    case ccStart = "#CC"
    case ccEnd = "CC#"
    case problemsStart = "#PROBLEMS"
    case problemEnd = "PROBLEMS#"
    case subjectiveStart = "#SUBJECTIVE"
    case subjectiveEnd = "SUBJECTIVE#"
    case newPMHStart = "#NEWPMH"
    case newPMHEnd = "NEWPMH#"
    case assessmentStart = "#ASSESSMENT"
    case assessmentEND = "ASSESSMENT#"
    case planStart = "#PLAN"
    case planEnd = "PLAN#"
    case objectiveStart = "#OBJECTIVE"
    case objectiveEnd = "OBJECTIVE#"
    case medStart = "#MEDICATIONS"
    case medEnd = "MEDICATIONS#"
    case allergiesStart = "#ALLERGIES"
    case allergiesEnd = "ALLERGIES#"
    case preventiveStart = "#PREVENTIVE"
    case preventiveEnd = "PREVENTIVE#"
    case pmhStart = "#PMH"
    case pmhEnd = "PMH#"
    case pshStart = "#PSH"
    case pshEnd = "PSH#"
    case nutritionStart = "#NUTRITION"
    case nutritionEnd = "NUTRITION#"
    case socialStart = "#SOCIAL"
    case socialEnd = "SOCIAL#"
    case familyStart = "#FAMILY"
    case familyEnd = "FAMILY#"
    case diagnosisStart = "#DIAGNOSIS"
    case diagnosisEnd = "DIAGNOSIS#"
    case rosStart = "#ROS"
    case rosEnd = "ROS#"
    case visitDateStart = "#VISITDATE"
    case visitDateEnd = "VISITDATE#"
    case otherStart = "#OTHER"
    case otherEnd = "OTHER#"
}



struct PTVN {
    
    var theText:String
    private let currentDate = Date()
    private let formatter = DateFormatter()
    private var messageDate:String {
        formatter.dateStyle = DateFormatter.Style.short
        return formatter.string(from: currentDate)
    }
//    var labelDate:String {
//        formatter.dateFormat = "yyMMdd"
//        return formatter.string(from: currentDate)
//    }
    
    var visitDate = String()
    var ptName = String()
    //var ptLabelName:String {return getFileLabellingName(ptInnerName)}
    var ptAge = String()
    var ptDOB = String()
    var cc = String()
    var allergies = String()
    var medicines = String()
    var preventive = String()
    var pmh = String()
    var psh = String()
    var nutrition = String()
    var social = String()
    var family = String()
    var diagnoses = String()
    var ros = String()
    var assessment = String()
    var objective = String()
    var subjective = String()
    var plan = String()
//    var lastAppointment:String {return getLastAptInfoFrom(theText)}
//    var nextAppointment:String {return getNextAptInfoFrom(theText)}
    
    init(theText: String) {
        self.theText = theText
        self.visitDate = theText.simpleRegExMatch(Regexes().visitDate).cleanTheTextOf([SectionDelimiters.visitDateStart.rawValue, SectionDelimiters.visitDateEnd.rawValue])
        self.ptName = theText.simpleRegExMatch(Regexes().name).cleanTheTextOf([SectionDelimiters.patientNameStart.rawValue, SectionDelimiters.patientNameEnd.rawValue])
        //var ptLabelName:String {return getFileLabellingName(ptInnerName)}
        self.ptAge = theText.simpleRegExMatch(Regexes().age).cleanTheTextOf([SectionDelimiters.patientAgeStart.rawValue, SectionDelimiters.patientAgeEnd.rawValue])
        self.ptDOB = theText.simpleRegExMatch(Regexes().dob).cleanTheTextOf([SectionDelimiters.patientDOBStart.rawValue, SectionDelimiters.patientDOBEnd.rawValue])
        self.cc = theText.simpleRegExMatch(Regexes().cc).cleanTheTextOf([SectionDelimiters.ccStart.rawValue, SectionDelimiters.ccEnd.rawValue])
        self.allergies = theText.simpleRegExMatch(Regexes().allergies).cleanTheTextOf([SectionDelimiters.allergiesStart.rawValue, SectionDelimiters.allergiesEnd.rawValue])
        self.medicines = theText.simpleRegExMatch(Regexes().medications).cleanTheTextOf([SectionDelimiters.medStart.rawValue, SectionDelimiters.medEnd.rawValue])
        self.preventive = theText.simpleRegExMatch(Regexes().preventive).cleanTheTextOf([SectionDelimiters.preventiveStart.rawValue, SectionDelimiters.preventiveEnd.rawValue])
        self.pmh = theText.simpleRegExMatch(Regexes().pmh).cleanTheTextOf([SectionDelimiters.pmhStart.rawValue, SectionDelimiters.pmhEnd.rawValue])
        self.psh = theText.simpleRegExMatch(Regexes().psh).cleanTheTextOf([SectionDelimiters.pshStart.rawValue, SectionDelimiters.pshEnd.rawValue])
        self.nutrition = theText.simpleRegExMatch(Regexes().nutrition).cleanTheTextOf([SectionDelimiters.nutritionStart.rawValue, SectionDelimiters.nutritionEnd.rawValue])
        self.social = theText.simpleRegExMatch(Regexes().social).cleanTheTextOf([SectionDelimiters.socialStart.rawValue, SectionDelimiters.socialEnd.rawValue])
        self.family = theText.simpleRegExMatch(Regexes().family).cleanTheTextOf([SectionDelimiters.familyStart.rawValue, SectionDelimiters.familyEnd.rawValue])
        self.diagnoses = theText.simpleRegExMatch(Regexes().diagnoses).cleanTheTextOf([SectionDelimiters.diagnosisStart.rawValue, SectionDelimiters.diagnosisEnd.rawValue])
        self.ros = theText.simpleRegExMatch(Regexes().ros).cleanTheTextOf([SectionDelimiters.rosStart.rawValue, SectionDelimiters.rosEnd.rawValue])
        self.assessment = theText.simpleRegExMatch(Regexes().assessment).cleanTheTextOf([SectionDelimiters.assessmentStart.rawValue, SectionDelimiters.assessmentEND.rawValue])
        self.objective = theText.simpleRegExMatch(Regexes().objective).cleanTheTextOf([SectionDelimiters.objectiveStart.rawValue, SectionDelimiters.objectiveEnd.rawValue])
        self.subjective = theText.simpleRegExMatch(Regexes().subjective).cleanTheTextOf([SectionDelimiters.subjectiveStart.rawValue, SectionDelimiters.subjectiveEnd.rawValue])
        self.plan = theText.simpleRegExMatch(Regexes().plan).cleanTheTextOf([SectionDelimiters.planStart.rawValue, SectionDelimiters.planEnd.rawValue])
    }
    
    var saveValue:String {return """
        #PTVNFILE#
        \(SectionDelimiters.patientNameStart.rawValue)
        \(ptName)
        \(SectionDelimiters.patientNameEnd.rawValue)
        
        \(SectionDelimiters.patientDOBStart.rawValue)
        \(ptDOB)
        \(SectionDelimiters.patientDOBEnd.rawValue)
        
        \(SectionDelimiters.patientAgeStart.rawValue)
        \(ptAge)
        \(SectionDelimiters.patientAgeEnd.rawValue)
        
        \(SectionDelimiters.visitDateStart.rawValue)
        \(visitDate)
        \(SectionDelimiters.visitDateEnd.rawValue)
        
        \(SectionDelimiters.ccStart.rawValue)
        \(cc)
        \(SectionDelimiters.ccEnd.rawValue)
        
        \(SectionDelimiters.medStart.rawValue)
        \(medicines)
        \(SectionDelimiters.medEnd.rawValue)
        
        \(SectionDelimiters.allergiesStart.rawValue)
        \(allergies)
        \(SectionDelimiters.allergiesEnd.rawValue)
        
        \(SectionDelimiters.preventiveStart.rawValue)
        \(preventive)
        \(SectionDelimiters.preventiveEnd.rawValue)
        
        \(SectionDelimiters.pmhStart.rawValue)
        \(pmh)
        \(SectionDelimiters.pmhEnd.rawValue)
        
        \(SectionDelimiters.pshStart.rawValue)
        \(psh)
        \(SectionDelimiters.pshEnd.rawValue)
        
        \(SectionDelimiters.nutritionStart.rawValue)
        \(nutrition)
        \(SectionDelimiters.nutritionEnd.rawValue)
        
        \(SectionDelimiters.socialStart.rawValue)
        \(social)
        \(SectionDelimiters.socialEnd.rawValue)
        
        \(SectionDelimiters.familyStart.rawValue)
        \(family)
        \(SectionDelimiters.familyEnd.rawValue)
        
        \(SectionDelimiters.diagnosisStart.rawValue)
        \(diagnoses)
        \(SectionDelimiters.diagnosisEnd.rawValue)
        
        \(SectionDelimiters.rosStart.rawValue)
        \(ros)
        \(SectionDelimiters.rosEnd.rawValue)
        
        \(SectionDelimiters.assessmentStart.rawValue)
        \(assessment)
        \(SectionDelimiters.assessmentEND.rawValue)
        
        \(SectionDelimiters.objectiveStart.rawValue)
        \(objective)
        \(SectionDelimiters.objectiveEnd.rawValue)
        
        \(SectionDelimiters.subjectiveStart.rawValue)
        \(subjective)
        \(SectionDelimiters.subjectiveEnd.rawValue)
        
        \(SectionDelimiters.planStart.rawValue)
        \(plan)
        \(SectionDelimiters.planEnd.rawValue)
        """
        
//        \(SectionDelimiters.otherStart.rawValue)
//        \(messageDate)
//        \(SectionDelimiters.otherEnd.rawValue)
}
    
    struct Regexes {
        let name = "(?s)\(SectionDelimiters.patientNameStart.rawValue).*\(SectionDelimiters.patientNameEnd.rawValue)"
        let dob = "(?s)\(SectionDelimiters.patientDOBStart.rawValue).*\(SectionDelimiters.patientDOBEnd.rawValue)"
        let age = "(?s)\(SectionDelimiters.patientAgeStart.rawValue).*\(SectionDelimiters.patientAgeEnd.rawValue)"
        let visitDate = "(?s)\(SectionDelimiters.visitDateStart.rawValue).*\(SectionDelimiters.visitDateEnd.rawValue)"
        let cc = "(?s)\(SectionDelimiters.ccStart.rawValue).*\(SectionDelimiters.ccEnd.rawValue)"
        let social = "(?s)\(SectionDelimiters.socialStart.rawValue).*\(SectionDelimiters.socialEnd.rawValue)"
        let family = "(?s)\(SectionDelimiters.familyStart.rawValue).*\(SectionDelimiters.familyEnd.rawValue)"
        let nutrition = "(?s)\(SectionDelimiters.nutritionStart.rawValue).*\(SectionDelimiters.nutritionEnd.rawValue)"
        let diagnoses = "(?s)\(SectionDelimiters.diagnosisStart.rawValue).*\(SectionDelimiters.diagnosisEnd.rawValue)"
        let medications = "(?s)\(SectionDelimiters.medStart.rawValue).*\(SectionDelimiters.medEnd.rawValue)"
        let allergies = "(?s)\(SectionDelimiters.allergiesStart.rawValue).*\(SectionDelimiters.allergiesEnd.rawValue)"
        let pmh = "(?s)\(SectionDelimiters.pmhStart.rawValue).*\(SectionDelimiters.pmhEnd.rawValue)"
        let psh = "(?s)\(SectionDelimiters.pshStart.rawValue).*\(SectionDelimiters.pshEnd.rawValue)"
        let preventive = "(?s)\(SectionDelimiters.preventiveStart.rawValue).*\(SectionDelimiters.preventiveEnd.rawValue)"
        let ros = "(?s)\(SectionDelimiters.rosStart.rawValue).*\(SectionDelimiters.rosEnd.rawValue)"
        let assessment = "(?s)\(SectionDelimiters.assessmentStart.rawValue).*\(SectionDelimiters.assessmentEND.rawValue)"
        let objective = "(?s)\(SectionDelimiters.objectiveStart.rawValue).*\(SectionDelimiters.objectiveEnd.rawValue)"
        let subjective = "(?s)\(SectionDelimiters.subjectiveStart.rawValue).*\(SectionDelimiters.subjectiveEnd.rawValue)"
        let plan = "(?s)\(SectionDelimiters.planStart.rawValue).*\(SectionDelimiters.planEnd.rawValue)"
    }

    
}


    


