//
//  RadiologyModel.swift
//  LIROS
//
//  Created by Fool on 10/19/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Foundation

struct enumLists {
    var mriCases:[String] {
        var tempCases = [String]()
        radMRIAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var xrayCases:[String] {
        var tempCases = [String]()
        radXRAYAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var ctCases:[String] {
        var tempCases = [String]()
        radCTAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var mraCases:[String] {
        var tempCases = [String]()
        radMRAAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var usndCases:[String] {
        var tempCases = [String]()
        radUSNDAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var mamCases:[String] {
        var tempCases = [String]()
        radMAMAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var bmdCases:[String] {
        var tempCases = [String]()
        radBMDAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var nucCases:[String] {
        var tempCases = [String]()
        radNUCAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var neuroCases:[String] {
        var tempCases = [String]()
        radNeuroAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var respCases:[String] {
        var tempCases = [String]()
        radRespAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var giCases:[String] {
        var tempCases = [String]()
        radGIAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    var cardioCases:[String] {
        var tempCases = [String]()
        radCardioAreas.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var contrast:[String] {
        var tempCases = [String]()
        radContrast.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var spineSide:[String] {
        var tempCases = [String]()
        radSpineSide.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var xraySpineSide:[String] {
        var tempCases = [String]()
        radXraySpineSide.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radMRIAbSide:[String] {
        var tempCases = [String]()
        radMRIAbSides.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radRLBSide:[String] {
        var tempCases = [String]()
        radRLBSides.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radExtremitySide:[String] {
        var tempCases = [String]()
        radExtremities.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radExtremityContrastSide:[String] {
        var tempCases = [String]()
        radExtremitiesContrast.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radUSNDBreastSide:[String] {
        var tempCases = [String]()
        radUSNDSidesBreast.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radUSNDDopplerSide:[String] {
        var tempCases = [String]()
        radUSNDSidesDoppler.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radCTAbSide:[String] {
        var tempCases = [String]()
        radCTAbSides.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radCTChestSide:[String] {
        var tempCases = [String]()
        radCTChest.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radMRAExtremitySide:[String] {
        var tempCases = [String]()
        radMRAExSides.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radSleepSide:[String] {
        var tempCases = [String]()
        radRespSleepSides.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radPFTSide:[String] {
        var tempCases = [String]()
        radRespPFTSides.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radSpiroSide:[String] {
        var tempCases = [String]()
        radRespSpiroSides.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radABGside:[String] {
        var tempCases = [String]()
        radRespABGSides.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radECHOSide:[String] {
        var tempCases = [String]()
        radCardioECHOSides.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radSTSTSide:[String] {
        var tempCases = [String]()
        radCardioSTSTSides.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var radHLTRSide:[String] {
        var tempCases = [String]()
        radCardioHLTRSides.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var refMedSide:[String] {
        var tempCases = [String]()
        refMedChoices.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var refSurgSide:[String] {
        var tempCases = [String]()
        refSurgChoices.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
    var refTherSide:[String] {
        var tempCases = [String]()
        refTherChoices.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
    
}

enum radMRIAreas:String, CaseIterable {
    case brain
    case spine
    case neck = "neck soft tissue"
    case extremity
    case abdomen
    case pelvis
    case chest
    case sinuses
    case orbits
}

enum radCTAreas:String, CaseIterable {
    case brain = "angio brain"
    case abrunoff = "angio abdomen/pelvis with runoff"
    case head
    case chest
    case calcium = "coronary calcium"
    case arteries = "coronary arteries"
    case abdomen
    case sinus
    case neck = "neck soft tissue"
    case extremity
    case myelogram
    case orbits
    case face = "facial bones"
    case temple = "temporal bones"
    case spine
    case pelvis
    case enterography
    case colonography
}

enum radXRAYAreas:String, CaseIterable {
    case chestPALAT = "chest PA and Lateral"
    case ribs = "rib series"
    case abdomenFlat = "abdomen flat and upright"
    case spine
    case kneeStanding = "knee series with standing film"
    case hip
    case pelvis
    case femur
    case tibFib = "tib fib"
    case ankle
    case foot
    case shoulder = "shoulder series"
    case elbow
    case wrist
    case hand
    case myelogram = "plain myelogram"
    case upperGI = "upper GI"
    case barium = "barium swallow"
    case swallow = "swallow function study"
    case enema = "gastrograffin enema"
}

enum radMRAAreas:String, CaseIterable {
    case brain
    case neck = "neck and great vessels"
    case extremities
    case abdomen = "abdomen and pelvis"
}

enum radUSNDAreas:String, CaseIterable {
    case thyroid
    case gallbladder = "gallbladder/RUQ"
    case abdominal = "complete abdominal"
    case kidneys
    case pelvic
    case transvaginal = "pelvic - transvaginal"
    case testicle = "testicle/scrotum"
    case breast
    case carotid = "carotid artery doppler"
    case vDoppler = "venous doppler"
    case vReflux = "venous reflux doppler"
    case aDoppler = "arterial doppler"
}

enum radMAMAreas:String, CaseIterable {
    case screening = "screening bilateral"
    case diagnostic
}

enum radBMDAreas:String, CaseIterable {
    case bmd = "Dexa bone mineral density"
}

enum radNUCAreas:String, CaseIterable {
    case hida = "gallbladder HIDA scan"
    case nges = "NGES nuclear gastric emptying study"
    case thyroid = "thyroid uptake scan"
    case breast = "breast scan"
    case bone = "bone scan 3 phase"
}

enum radNeuroAreas:String, CaseIterable {
    case EEG
    case emg = "EMG - nerve conduction study"
    case pet = "PET scan"
}

enum radRespAreas:String, CaseIterable {
    case sleep = "sleep study"
    case mslt = "MSLT (multiple sleep latency test)"
    case mwt = "MWT (maintenance of wakefulness test)"
    case pulseOX = "overnight pulse ox"
    case PFT
    case spirometry
    case ABG
}

enum radGIAreas:String, CaseIterable {
    case colonoscopy
    case EGD
}

enum radCardioAreas:String, CaseIterable {
    case ECHO
    case EKG
    case stressTest = "stress test"
    case holter = "holter monitor"
    case monitor = "30 day cardiac event monitor"
    case tilt = "tilt table test"
}

enum radContrast:String, CaseIterable {
    case with = "with contrast"
    case wout = "without contrast"
    case wwithout = "with and without contrast"
}

enum radSpineSide:String, CaseIterable {
    case C
    case T
    case L
    case CTL
}

enum radXraySpineSide:String, CaseIterable {
    //Use in conjunction with radSpineSide enum
    case sacrum = "Sacrum/Coxyx"
}

enum radMRIAbSides:String, CaseIterable {
    case pelvispoiv = "and pelvis with PO&IV contrast"
    case pelviscontrast = "and pelvis with PO contrast"
    case pelviswocontrast = "and pelvis without contrast"
    case wwoutcontrast = "with and without contrast"
    case woconstrast = "without contrast"
    case withcontrast = "with contrast"
}

enum radRLBSides:String, CaseIterable {
    case right = "right side"
    case left = "left side"
    case bilateral
}

enum radExtremities:String, CaseIterable {
    case rightarm = "right arm"
    case leftarm = "left arm"
    case rightleg = "right leg"
    case leftleg = "left leg"
}

enum radExtremitiesContrast:String, CaseIterable {
    case rarmwocontrast = "right arm without contrast"
    case rarmwcontrast = "right arm with contrast"
    case larmwocontrast = "left arm without contrast"
    case larmwcontrast = "left arm with contrast"
    case rlegwocontrast = "right leg without contrast"
    case rlegwcontrast = "right leg with contrast"
    case llegwocontrast = "left leg without contrast"
    case llwcontrast = "left leg with contrast"
}

enum radUSNDSidesBreast:String, CaseIterable {
    case right
    case left
    case bilateral
}

enum radUSNDSidesDoppler:String, CaseIterable {
    case BLE
    case LLE
    case RLE
    case BUE
    case LUE
    case RUE
}

enum radCTAbSides:String, CaseIterable {
    case pelvisiv = "and pelvis with oral and IV contrast"
    case renalstone = "and pelvis renal stone protocol"
    case pelvisoral = "and pelvis with oral contrast"
    case pelviswooraliv = "and pelvis without oral and IV contrast"
    case pelviswwooraliv = "and pelvis with and without oral and IV contrast"
    case pelviswwocontrast = "and pelvis with and without contrast"
    case pelviswo = "and pelvis without contrast"
    case wo = "without contrast"
    case wwo = "with and without contrast"
    case w = "with contrast"
}

enum radCTChest:String, CaseIterable {
    // add radContrast enum when using
    case pe = "PE protocol"
    case lowdose = "low dose lung cancer screen"
    case hires = "high resolution"
}

enum radMRAExSides:String, CaseIterable {
    case bu = "bilateral upper"
    case bl = "bilateral lower"
}

enum radRespSleepSides:String, CaseIterable {
    case home
    case poly = "(polysomnagram)"
    case split = "split night"
    case cpap = "CPAP titration study"
}

enum radRespPFTSides:String, CaseIterable {
    case complete
    case basic
}

enum radRespSpiroSides:String, CaseIterable {
    case brochodilator = "with pre/post bronchodilator"
    case exercise
}

enum radRespABGSides:String, CaseIterable {
    case room = "room air"
    case o2 = "with O2"
}

enum radCardioECHOSides:String, CaseIterable {
    case trans = "trans esophageal"
    case bubble = "with bubble study"
}

enum radCardioSTSTSides:String, CaseIterable {
    case ekg = "EKG exercise"
    case treadmill = "treadmill myoview"
    case lexiscan = "Lexiscan myoview"
    case echo = "treadmill stress ECHO"
}

enum radCardioHLTRSides:String, CaseIterable {
    case oneday = "24 hour"
    case twoday = "48 hour"
}


enum refAreaChoices:String, CaseIterable {
    case Med = "Medical"
    case Surg = "Surgical"
    case Ther = "Therapy/Ancillary"
}

enum refMedChoices:String, CaseIterable {
    case Allergist
    case Cardiologist
    case Chiropractor
    case Dentist
    case Dermatologist
    case Endocrinologist
    case Gastroenterologist
    case Immunologist
    case Infectious = "Infectious Disease"
    case Nephrologist
    case Neurologist
    case OncHemo = "Oncologist/Hematologist"
    case RadOnc = "Radiation Oncologist"
    case Optometrist
    case PVS = "Peripheral Vascular Specialist"
    case Rehab = "Physical medicine and Rehab"
    case Psychiatrist
    case Pulmonologist
    case Rheumatologist
}

enum refSurgChoices:String, CaseIterable {
    case bari = "Bariatric Surgeon"
    case cv = "Cardiothoracic/Vascular Surgeon"
    case colo = "Colorectal Surgeon"
    case ent = "ENT/Otolaryngology"
    case gen = "General Surgeon"
    case Gynecologist
    case gynOnc = "Gynecologic Oncology"
    case Neurosurgeon
    case Obstretician
    case Ophthalmology
    case oral = "Oral Surgeon"
    case Orthopedic
    case pain = "Pain Managment"
    case Podiatrist
    case Urologist
}

enum refTherChoices:String, CaseIterable {
    case Counselor
    case DMEd = "Diabetic Education"
    case HH = "Home Health"
    case lymph = "Lymphedema Clinic"
    case Nutritionist
    case Psychologist
    case sw = "Social Worker"
    case occ = "Occupational Therapy"
    case phys = "Physical Therapy"
    case speech = "Speech Therapy"
    case wc = "Wound Clinic"
}



