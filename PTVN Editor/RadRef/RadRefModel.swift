//
//  RadiologyModel.swift
//  LIROS
//
//  Created by Fool on 10/19/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Foundation

let radTypeChoices = ["XRAY", "MAM", "BMD", "Ultrasound", "CT", "MRI", "MRA", "Cardio", "GI", "Resp", "Neuro", "NUC"]
let radMRIAreas = ["brain", "spine", "neck soft tissue", "extremity", "abdomen", "pelvis", "chest", "sinuses", "orbits"]
let radCTAreas = ["angio brain", "angio abdomen/pelvis with runoff", "head", "chest", "coronary calcium", "coronary arteries", "abdomen", "sinus", "neck soft tissue", "extremity", "myelogram", "orbits", "facial bones", "temporal bones", "spine", "pelvis", "enterography", "colonography"]
let radXRAYAreas = ["chest PA and Lateral", "rib series", "abdomen flat and upright", "spine", "knee series with standing film", "hip", "pelvis", "femur", "tib fib", "ankle", "foot", "shoulder series", "elbow", "wrist", "hand", "plain myelogram", "upper GI", "barium swallow", "swallow function study", "gastrograffin enema"]
let radMRAAreas = ["brain", "neck and great vessels", "extremities", "abdoment and pelvis"]
let radUSNDAreas = ["thyroid", "gallbladder/RUQ", "complete abdominal", "kidneys", "pelvic", "pelvic - transvaginal", "testicle/scrotum", "breast", "carotid artery doppler","venous doppler", "venous reflux doppler", "arterial doppler"]
let radMAMAreas = ["screening bilateral", "diagnostic"]
let radBMDAreas = ["Dexa bone mineral density"]
let radNUCAreas = ["gallbladder HIDA scan", "NGES nuclear gastric emptying study", "thyroid uptake scan", "breast scan", "bone scan 3 phase"]
let radNeuroAreas = ["EEG", "EMG - nerve conduction study", "PET scan"]
let radRespAreas = ["sleep study", "MSLT (multiple sleep latency test)", "MWT (maintenance of wakefulness test)", "overnight pulse ox", "PFT", "spirometry", "ABG"]
let radGIAreas = ["colonoscopy", "EGD"]
let radCardioAreas = ["ECHO", "EKG", "stress test", "holter monitor", "30 day cardiac event monitor", "tilt table test"]

let radEmptySide = [""]
let radContrast = ["with and without contrast", "without contrast", "with contrast"]
let radSpineSide = ["C", "T", "L", "CTL"]
let radXraySpineSide = ["C", "T", "L", "CTL", "Sacrum/Coxyx"]
let radMRIAbSides = ["and pelvis with PO&IV contrast", "and pelvis with PO contrast", "and pelvis without contrast", "with and without contrast", "without contrast", "with contrast"]
let radRLBSides = ["", "right side", "left side", "bilateral"]
let radExtremeties = ["right arm", "left arm", "right leg", "left leg"]
let radExtremetiesContrast = ["right arm without contrast", "right arm with contrast", "left arm without contrast", "left arm with contrast", "right leg without contrast", "right leg with contrast", "left leg without contrast", "left leg with contrast"]
//let radUSNDSidesBreast = ["right", "left", "bilateral"]
let radUSNDSidesDoppler = ["BLE", "LLE", "RLE", "BUE", "BLE", "BRE"]
let radCTAbSides = ["and pelvis with oral and IV contrast", "and pelvis renal stone protocol", "and pelvis with oral contrast", "and pelvis without oral and IV contrast", "and pelvis with and without oral and IV contrast", "and pelvis with and without contrast", "and pelvis without contrast", "without contrast", "with and without contrast", "with contrast"]
let radCTChest = radContrast + ["PE protocol", "low dose lung cancer screen", "high resolution"]
let radMRAExSides = ["bilateral upper", "bilateral lower"]
let radRespSleepSides = ["home", "(polysomnagram)", "split night", "CPAP titration study"]
let radRespPFTSides = ["complete", "basic"]
let radRespSpiroSides = ["", "with pre/post bronchodilator", "exercise"]
let radRespABGSides = ["room air", "with O2"]
let radCardioECHOSides = ["", "trans esophageal", "with bubble study"]
let radCardioSTSTSides = ["EKG exercise", "treadmill myoview", "Lexiscan myoview", "treadmill stress ECHO"]
let radCardioHLTRSides = ["24 hour", "48 hour"]


let refAreaChoices = ["Medical", "Surgical", "Therapy/Ancillary"]
let refMedChoices = ["Allergist", "Cardiologist", "Chiropractor", "Dentist", "Dermatologist", "Endocrinologist", "Gastroenterologist", "Immunologist", "Infectious Disease", "Nephrologist", "Neurologist", "Oncologist/Hematologist", "Radiation Oncologist", "Optometrist", "Peripheral Vascular Specialist", "Physical medicine and Rehab", "Psychiatrist", "Pulmonologist", "Rheumatologist"]
let refSurgChoices = ["Bariatric Surgeon", "Cardiothoracic/Vascular Surgeon", "Colorectal Surgeon", "ENT/Otolaryngology", "General Surgeon", "Gynecologist", "Gynecologic Oncology", "Neurosurgeon", "Obstretician", "Ophthalmology", "Oral Surgeon", "Orthopedic", "Pain Managment", "Podiatrist", "Urologist"]
let refTherChoices = ["Counselor", "Diabetic Education", "Home Health", "Lymphedema Clinic", "Nutritionist", "Psychologist", "Social Worker", "Occupational Therapy", "Physical Therapy", "Speech Therapy", "Wound Clinic"]
