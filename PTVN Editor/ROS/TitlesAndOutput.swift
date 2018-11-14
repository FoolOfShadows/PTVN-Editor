//
//  TitlesAndOutput.swift
//  PTVN Editor
//
//  Created by Fool on 11/13/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Foundation
struct ROSTitles {
    //General
    let wtLoss = "Wt Loss"
    let wtGain = "Wt Gain"
    let appLoss = "App Loss"
    let fever = "Fever"
    let chills = "Chills"
    let sweats = "Sweats"
    let fatigue = "Fatigue"
    let weakness = "Weakness"
    let insomnia = "Insomnia"
    //GUE
    let pnflUrin = "Pnfl Urin"
    let blood = "Blood"
    let frequency = "Frequency"
    let urgency = "Urgency"
    let uIncont = "U Incont"
    let sIncont = "S Incont"
    let nocturia = "Nocturia"
    let hesitency = "Hesitancy"
    let eds = "EDS"
    let decLibido = "Dec Libido"
    let irrPeriods = "Irr Periods"
    let vagDis = "Vag Dis"
    let brstDis = "Brst Dis"
    let hotFlashes = "Hot Flashes"
    let flushing = "Flushing"
    let goiter = "Goiter"
    let swlGlands = "Swl Glands"
    let thirst = "Thirst"
    let heatInt = "Heat Int"
    let coldInt = "Cold Int"
    //PSYCH
    let stress = "Stress"
    let depression = "Depression"
    let anxiety = "Anxiety"
    let panic = "Panic"
    let mood = "Mood"
    let crying = "Crying"
    let poorConc = "Poor Conc"
    let memory = "Memory"
    let confusion = "Confusion"
    let hallucinations = "Hallucinations"
    let suicidalHom = "Suicidal/Hom"
    let paranoia = "Paranoia"
    let grief = "Grief"
    //GI
    let abPain = "Ab Pain"
    let pelvicPain = "Pelvic Pain"
    let nausea = "Nausea"
    let vomiting = "Vomiting"
    let diarrhea = "Diarrhea"
    let constipation = "Constipation"
    let hemorrhoids = "Hemorrhoids"
    let bloodyStool = "Bloody Stool"
    let bloodyVomit = "Bloody Vomit"
    let gas = "Gas"
    let bloating = "Bloating"
    let indigestion = "Indigestion"
    let heartburn = "Heartburn"
    let trblSwallowing = "Trbl Swallowing"
    let earlyFullness = "Early Fullness"
    //EYE
    let blurryVision = "Blurry Vision"
    let poorVision = "Poor Vision"
    let wateryItchyRed = "Watery/Itchy/Red"
    let doubleVision = "Double Vision"
    let eyePain = "Eye Pain"
    //ENT
    let earAche = "Ear Ache"
    let earDrainage = "Ear Drainage"
    let hearingLoss = "Hearing Loss"
    let ringingEars = "Ringing Ears"
    let runnyNose = "Runny Nose"
    let sneezing = "Sneezing"
    let congestion = "Congestion"
    let nasalDrip = "Nasal Drip"
    let noseBleed = "Nose Bleed"
    let smellLoss = "Smell Loss"
    let tasteLoss = "Taste Loss"
    let soreThroat = "Sore Throat"
    let mouthSores = "Mouth Sores"
    let hoarse = "Hoarse"
    let laryngitis = "Laryngitis"
    //MSK
    //let "Weakness"title
    let stiffness = "Stiffness"
    let swelling = "Swelling"
    let jointAche = "Joint Ache"
    let muscleAche = "Muscle Ache"
    let cramps = "Cramps"
    let spasms = "Spasms"
    //ENDO
    let bruising = "Bruising"
    let transfusion = "Transfusion"
    
    //RESP
    let wheezing = "Wheezing"
    let dryCough = "Dry Cough"
    let prodCough = "Prod Cough"
    let bldySputum = "Bldy Sputum"
    let sob = "SOB"
    let dyspnea = "Dyspnea"
    let snoring = "Snoring"
    let apnea = "Apnea"
    let daySleep = "Daytime Sleep"
    let pleurisy = "Pleurisy"
    let pnflBreaths = "Pnfl Breaths"
    //NEURO
    let seizures = "Seizures"
    let strokeSymp = "Stroke Symp"
    let headaches = "Headaches"
    let tremors = "Tremors"
    let twitches = "Twitches"
    let jerks = "Jerks"
    let numbness = "Numbness"
    let tingling = "Tingling"
    let fainting = "Fainting"
    let vertigo = "Vertigo"
    let dizziness = "Dizziness"
    let lightHd = "Light-hd"
    let balance = "Balance"
    let falling = "Falling"
    //CARDIO
    let chestPain = "Chest Pain"
    let angina = "Angina"
    let palpitations = "Palpitations"
    let palpRacing = "Palp - Racing"
    let palpSkipping = "Palp - Skipping"
    let irrHeartBeat = "Irr Heart Beat"
    let legCramps = "Leg Cramps"
    //let "Swelling"title
    let diffBreathing = "Diff Breathing"
    let wakeGasping = "Wake Gasping"
    //DERM
    let /*"Bruising",*/ itching = "Itching"
    let jaundice = "Jaundice"
    let rash = "Rash"
    let hives = "Hives"
    let lumps = "Lumps"
    let sores = "Sores"
    let ulcers = "Ulcers"
    //let "Swl Glands""Swollen glands"
    let hairLoss = "Hair Loss"
    let excessHair = "Excess Hair"
    let drySknEyeMth = "Dry Skn/Eye/Mth"
    let poorHealing = "Poor Healing"
    let moleChange = "Mole Change"
    let abcesses = "Abscesses"
    
    func getTitleFor(_ output:String) -> String {
        switch output {
        //General
        case ROSOutput().wtLoss: return ROSTitles().wtLoss
        case ROSOutput().wtGain: return ROSTitles().wtGain
        case ROSOutput().appLoss: return ROSTitles().appLoss
        case ROSOutput().fever: return ROSTitles().fever
        case ROSOutput().chills: return ROSTitles().chills
        case ROSOutput().sweats: return ROSTitles().sweats
        case ROSOutput().fatigue: return ROSTitles().fatigue
        case ROSOutput().weakness: return ROSTitles().weakness
        case ROSOutput().insomnia: return ROSTitles().insomnia
        //GUE
        case ROSOutput().pnflUrin: return ROSTitles().pnflUrin
        case ROSOutput().blood: return ROSTitles().blood
        case ROSOutput().frequency: return ROSTitles().frequency
        case ROSOutput().urgency: return ROSTitles().urgency
        case ROSOutput().uIncont: return ROSTitles().uIncont
        case ROSOutput().sIncont: return ROSTitles().sIncont
        case ROSOutput().nocturia: return ROSTitles().nocturia
        case ROSOutput().hesitency: return ROSTitles().hesitency
        case ROSOutput().eds: return ROSTitles().eds
        case ROSOutput().decLibido: return ROSTitles().decLibido
        case ROSOutput().irrPeriods: return ROSTitles().irrPeriods
        case ROSOutput().vagDis: return ROSTitles().vagDis
        case ROSOutput().brstDis: return ROSTitles().brstDis
        case ROSOutput().hotFlashes: return ROSTitles().hotFlashes
        case ROSOutput().flushing: return ROSTitles().flushing
        case ROSOutput().goiter: return ROSTitles().goiter
        case ROSOutput().swlGlands: return ROSTitles().swlGlands
        case ROSOutput().thirst: return ROSTitles().thirst
        case ROSOutput().heatInt: return ROSTitles().heatInt
        case ROSOutput().coldInt: return ROSTitles().coldInt
        //PSYCH
        case ROSOutput().stress: return ROSTitles().stress
        case ROSOutput().depression: return ROSTitles().depression
        case ROSOutput().anxiety: return ROSTitles().anxiety
        case ROSOutput().panic: return ROSTitles().panic
        case ROSOutput().mood: return ROSTitles().mood
        case ROSOutput().crying: return ROSTitles().crying
        case ROSOutput().poorConc: return ROSTitles().poorConc
        case ROSOutput().memory: return ROSTitles().memory
        case ROSOutput().confusion: return ROSTitles().confusion
        case ROSOutput().hallucinations: return ROSTitles().hallucinations
        case ROSOutput().suicidalHom: return ROSTitles().suicidalHom
        case ROSOutput().paranoia: return ROSTitles().paranoia
        case ROSOutput().grief: return ROSTitles().grief
        //GI
        case ROSOutput().abPain: return ROSTitles().abPain
        case ROSOutput().pelvicPain: return ROSTitles().pelvicPain
        case ROSOutput().nausea: return ROSTitles().nausea
        case ROSOutput().vomiting: return ROSTitles().vomiting
        case ROSOutput().diarrhea: return ROSTitles().diarrhea
        case ROSOutput().constipation: return ROSTitles().constipation
        case ROSOutput().hemorrhoids: return ROSTitles().hemorrhoids
        case ROSOutput().bloodyStool: return ROSTitles().bloodyStool
        case ROSOutput().bloodyVomit: return ROSTitles().bloodyVomit
        case ROSOutput().gas: return ROSTitles().gas
        case ROSOutput().bloating: return ROSTitles().bloating
        case ROSOutput().indigestion: return ROSTitles().indigestion
        case ROSOutput().heartburn: return ROSTitles().heartburn
        case ROSOutput().trblSwallowing: return ROSTitles().trblSwallowing
        case ROSOutput().earlyFullness: return ROSTitles().earlyFullness
        //EYE
        case ROSOutput().blurryVision: return ROSTitles().blurryVision
        case ROSOutput().poorVision: return ROSTitles().poorVision
        case ROSOutput().wateryItchyRed: return ROSTitles().wateryItchyRed
        case ROSOutput().doubleVision: return ROSTitles().doubleVision
        case ROSOutput().eyePain: return ROSTitles().eyePain
        //ENT
        case ROSOutput().earAche: return ROSTitles().earAche
        case ROSOutput().earDrainage: return ROSTitles().earDrainage
        case ROSOutput().hearingLoss: return ROSTitles().hearingLoss
        case ROSOutput().ringingEars: return ROSTitles().ringingEars
        case ROSOutput().runnyNose: return ROSTitles().runnyNose
        case ROSOutput().sneezing: return ROSTitles().sneezing
        case ROSOutput().congestion: return ROSTitles().congestion
        case ROSOutput().nasalDrip: return ROSTitles().nasalDrip
        case ROSOutput().noseBleed: return ROSTitles().noseBleed
        case ROSOutput().smellLoss: return ROSTitles().smellLoss
        case ROSOutput().tasteLoss: return ROSTitles().tasteLoss
        case ROSOutput().soreThroat: return ROSTitles().soreThroat
        case ROSOutput().mouthSores: return ROSTitles().mouthSores
        case ROSOutput().hoarse: return ROSTitles().hoarse
        case ROSOutput().laryngitis: return ROSTitles().laryngitis
            //MSK
        //case "Weakness": return title
        case ROSOutput().stiffness: return ROSTitles().stiffness
        case ROSOutput().swelling: return ROSTitles().swelling
        case ROSOutput().jointAche: return ROSTitles().jointAche
        case ROSOutput().muscleAche: return ROSTitles().muscleAche
        case ROSOutput().cramps: return ROSTitles().cramps
        case ROSOutput().spasms: return ROSTitles().spasms
        //ENDO
        case ROSOutput().bruising: return ROSTitles().bruising
        case ROSOutput().transfusion: return ROSTitles().transfusion
            
        //RESP
        case ROSOutput().wheezing: return ROSTitles().wheezing
        case ROSOutput().dryCough: return ROSTitles().dryCough
        case ROSOutput().prodCough: return ROSTitles().prodCough
        case ROSOutput().bldySputum: return ROSTitles().bldySputum
        case ROSOutput().sob: return ROSTitles().sob
        case ROSOutput().dyspnea: return ROSTitles().dyspnea
        case ROSOutput().snoring: return ROSTitles().snoring
        case ROSOutput().apnea: return ROSTitles().apnea
        case ROSOutput().daySleep: return ROSTitles().daySleep
        case ROSOutput().pleurisy: return ROSTitles().pleurisy
        case ROSOutput().pnflBreaths: return ROSTitles().pnflBreaths
        //NEURO
        case ROSOutput().seizures: return ROSTitles().seizures
        case ROSOutput().strokeSymp: return ROSTitles().strokeSymp
        case ROSOutput().headaches: return ROSTitles().headaches
        case ROSOutput().tremors: return ROSTitles().tremors
        case ROSOutput().twitches: return ROSTitles().twitches
        case ROSOutput().jerks: return ROSTitles().jerks
        case ROSOutput().numbness: return ROSTitles().numbness
        case ROSOutput().tingling: return ROSTitles().tingling
        case ROSOutput().fainting: return ROSTitles().fainting
        case ROSOutput().vertigo: return ROSTitles().vertigo
        case ROSOutput().dizziness: return ROSTitles().dizziness
        case ROSOutput().lightHd: return ROSTitles().lightHd
        case ROSOutput().balance: return ROSTitles().balance
        case ROSOutput().falling: return ROSTitles().falling
        //CARDIO
        case ROSOutput().chestPain: return ROSTitles().chestPain
        case ROSOutput().angina: return ROSTitles().angina
        case ROSOutput().palpitations: return ROSTitles().palpitations
        case ROSOutput().palpRacing: return ROSTitles().palpRacing
        case ROSOutput().palpSkipping: return ROSTitles().palpSkipping
        case ROSOutput().irrHeartBeat: return ROSTitles().irrHeartBeat
        case ROSOutput().legCramps: return ROSTitles().legCramps
        //case "Swelling": return title
        case ROSOutput().diffBreathing: return ROSTitles().diffBreathing
        case ROSOutput().wakeGasping: return ROSTitles().wakeGasping
        //DERM
        case /*"Bruising",*/ ROSOutput().itching: return ROSTitles().itching
        case ROSOutput().jaundice: return ROSTitles().jaundice
        case ROSOutput().rash: return ROSTitles().rash
        case ROSOutput().hives: return ROSTitles().hives
        case ROSOutput().lumps: return ROSTitles().lumps
        case ROSOutput().sores: return ROSTitles().sores
        case ROSOutput().ulcers: return ROSTitles().ulcers
        //case "Swl Glands": return "Swollen glands"
        case ROSOutput().hairLoss: return ROSTitles().hairLoss
        case ROSOutput().excessHair: return ROSTitles().excessHair
        case ROSOutput().drySknEyeMth: return ROSTitles().drySknEyeMth
        case ROSOutput().poorHealing: return ROSTitles().poorHealing
        case ROSOutput().moleChange: return ROSTitles().moleChange
        case ROSOutput().abcesses: return ROSTitles().abcesses
        //DEFAULT
        default: return ""
        }
    }
}

struct ROSOutput {
    //General
    let wtLoss = "weight loss"
    let wtGain = "weight gain"
    let appLoss = "loss of appetite"
    let fever = "fever"
    let chills = "chills"
    let sweats = "sweats"
    let fatigue = "fatigue/malaise"
    let weakness = "weakness"
    let insomnia = "insomnia"
    //GUE
    let pnflUrin = "painful urination"
    let blood = "blood in urine"
    let frequency = "frequency in urination"
    let urgency = "urgency in urination"
    let uIncont = "urinary incontinence"
    let sIncont = "stool incontinence"
    let nocturia = "nocturia"
    let hesitency = "hesitancy or dribbling"
    let eds = "erectile disfunction"
    let decLibido = "decreased libido"
    let irrPeriods = "irregular Periods"
    let vagDis = "vaginal discharge"
    let brstDis = "breast discharge"
    let hotFlashes = "hot flashes"
    let flushing = "flushing"
    let goiter = "goiter"
    let swlGlands = "swollen glands"
    let thirst = "excessive thirst"
    let heatInt = "heat intolerance"
    let coldInt = "cold intolerance"
    //PSYCH
    let stress = "stress"
    let depression = "depression"
    let anxiety = "anxiety/nerves"
    let panic = "panic attacks"
    let mood = "mood swings"
    let crying = "crying"
    let poorConc = "poor concentration"
    let memory = "memory loss"
    let confusion = "confusion"
    let hallucinations = "hallucinations (audio/visual)"
    let suicidalHom = "suicidal/homicidal thoughts"
    let paranoia = "paranoid thoughts"
    let grief = "grief"
    //GI
    let abPain = "abdominal pain"
    let pelvicPain = "pelvic pain"
    let nausea = "nausea"
    let vomiting = "vomiting"
    let diarrhea = "diarrhea"
    let constipation = "constipation"
    let hemorrhoids = "hemorrhoids"
    let bloodyStool = "bloody or black stool"
    let bloodyVomit = "bloody vomit"
    let gas = "gas"
    let bloating = "bloating"
    let indigestion = "indigestion"
    let heartburn = "heartburn"
    let trblSwallowing = "trouble swallowing"
    let earlyFullness = "early satiety/fullness"
    //EYE
    let blurryVision = "blurry vision"
    let poorVision = "poor vision"
    let wateryItchyRed = "watery/itchy/red eyes"
    let doubleVision = "double vision"
    let eyePain = "eye pain"
    //ENT
    let earAche = "ear ache"
    let earDrainage = "ear drainage"
    let hearingLoss = "hearing loss"
    let ringingEars = "tinnitus (ringing ears)"
    let runnyNose = "runny nose"
    let sneezing = "sneezing"
    let congestion = "nasal/sinus congestion"
    let nasalDrip = "post nasal drip"
    let noseBleed = "nose bleed"
    let smellLoss = "loss of smell"
    let tasteLoss = "loss of taste"
    let soreThroat = "sore throat"
    let mouthSores = "mouth sores"
    let hoarse = "hoarse voice"
    let laryngitis = "laryngitis"
    //MSK
    //let "Weakness"title
    let stiffness = "stiffness"
    let swelling = "swelling"
    let jointAche = "joint ache"
    let muscleAche = "muscle ache"
    let cramps = "cramps"
    let spasms = "spasms"
    //ENDO
    let bruising = "bruising"
    let transfusion = "blood transfusion"
    
    //RESP
    let wheezing = "wheezing"
    let dryCough = "dry cough"
    let prodCough = "productive cough"
    let bldySputum = "bloody sputum"
    let sob = "shortness of breath"
    let dyspnea = "dyspnea on exertion"
    let snoring = "snoring"
    let apnea = "apnea"
    let daySleep = "excess daytime sleepiness"
    let pleurisy = "pleurisy"
    let pnflBreaths = "painful breaths"
    //NEURO
    let seizures = "seizures"
    let strokeSymp = "TIA or stroke symptoms"
    let headaches = "headaches"
    let tremors = "tremors"
    let twitches = "twitches"
    let jerks = "jerks"
    let numbness = "numbness"
    let tingling = "tingling"
    let fainting = "syncope/fainting"
    let vertigo = "vertigo/spinning"
    let dizziness = "dizziness"
    let lightHd = "light-headed"
    let balance = "poor balance"
    let falling = "falling"
    //CARDIO
    let chestPain = "chest pain"
    let angina = "angina"
    let palpitations = "palpitations"
    let palpRacing = "palpitations - racing"
    let palpSkipping = "palpitations - skipping"
    let irrHeartBeat = "irregular heart beat"
    let legCramps = "leg cramps"
    //let "Swelling"title
    let diffBreathing = "can't breath lying down"
    let wakeGasping = "wake up gasping for air"
    //DERM
    let /*"Bruising",*/ itching = "itching"
    let jaundice = "jaundice"
    let rash = "rash"
    let hives = "hives"
    let lumps = "lumps"
    let sores = "sores"
    let ulcers = "ulcers"
    //let "Swl Glands""Swollen glands"
    let hairLoss = "hair loss"
    let excessHair = "excess hair"
    let drySknEyeMth = "dry skin/eyes/mouth"
    let poorHealing = "poor healing wounds"
    let moleChange = "changing moles"
    let abcesses = "abscesses/boils"
    
    func getOutputFor(_ title:String) -> String {
        switch title {
        //General
        case ROSTitles().wtLoss: return ROSOutput().wtLoss
        case ROSTitles().wtGain: return ROSOutput().wtGain
        case ROSTitles().appLoss: return ROSOutput().appLoss
        case ROSTitles().fever: return ROSOutput().fever
        case ROSTitles().chills: return ROSOutput().chills
        case ROSTitles().sweats: return ROSOutput().sweats
        case ROSTitles().fatigue: return ROSOutput().fatigue
        case ROSTitles().weakness: return ROSOutput().weakness
        case ROSTitles().insomnia: return ROSOutput().insomnia
        //GUE
        case ROSTitles().pnflUrin: return ROSOutput().pnflUrin
        case ROSTitles().blood: return ROSOutput().blood
        case ROSTitles().frequency: return ROSOutput().frequency
        case ROSTitles().urgency: return ROSOutput().urgency
        case ROSTitles().uIncont: return ROSOutput().uIncont
        case ROSTitles().sIncont: return ROSOutput().sIncont
        case ROSTitles().nocturia: return ROSOutput().nocturia
        case ROSTitles().hesitency: return ROSOutput().hesitency
        case ROSTitles().eds: return ROSOutput().eds
        case ROSTitles().decLibido: return ROSOutput().decLibido
        case ROSTitles().irrPeriods: return ROSOutput().irrPeriods
        case ROSTitles().vagDis: return ROSOutput().vagDis
        case ROSTitles().brstDis: return ROSOutput().brstDis
        case ROSTitles().hotFlashes: return ROSOutput().hotFlashes
        case ROSTitles().flushing: return ROSOutput().flushing
        case ROSTitles().goiter: return ROSOutput().goiter
        case ROSTitles().swlGlands: return ROSOutput().swlGlands
        case ROSTitles().thirst: return ROSOutput().thirst
        case ROSTitles().heatInt: return ROSOutput().heatInt
        case ROSTitles().coldInt: return ROSOutput().coldInt
        //PSYCH
        case ROSTitles().stress: return ROSOutput().stress
        case ROSTitles().depression: return ROSOutput().depression
        case ROSTitles().anxiety: return ROSOutput().anxiety
        case ROSTitles().panic: return ROSOutput().panic
        case ROSTitles().mood: return ROSOutput().mood
        case ROSTitles().crying: return ROSOutput().crying
        case ROSTitles().poorConc: return ROSOutput().poorConc
        case ROSTitles().memory: return ROSOutput().memory
        case ROSTitles().confusion: return ROSOutput().confusion
        case ROSTitles().hallucinations: return ROSOutput().hallucinations
        case ROSTitles().suicidalHom: return ROSOutput().suicidalHom
        case ROSTitles().paranoia: return ROSOutput().paranoia
        case ROSTitles().grief: return ROSOutput().grief
        //GI
        case ROSTitles().abPain: return ROSOutput().abPain
        case ROSTitles().pelvicPain: return ROSOutput().pelvicPain
        case ROSTitles().nausea: return ROSOutput().nausea
        case ROSTitles().vomiting: return ROSOutput().vomiting
        case ROSTitles().diarrhea: return ROSOutput().diarrhea
        case ROSTitles().constipation: return ROSOutput().constipation
        case ROSTitles().hemorrhoids: return ROSOutput().hemorrhoids
        case ROSTitles().bloodyStool: return ROSOutput().bloodyStool
        case ROSTitles().bloodyVomit: return ROSOutput().bloodyVomit
        case ROSTitles().gas: return ROSOutput().gas
        case ROSTitles().bloating: return ROSOutput().bloating
        case ROSTitles().indigestion: return ROSOutput().indigestion
        case ROSTitles().heartburn: return ROSOutput().heartburn
        case ROSTitles().trblSwallowing: return ROSOutput().trblSwallowing
        case ROSTitles().earlyFullness: return ROSOutput().earlyFullness
        //EYE
        case ROSTitles().blurryVision: return ROSOutput().blurryVision
        case ROSTitles().poorVision: return ROSOutput().poorVision
        case ROSTitles().wateryItchyRed: return ROSOutput().wateryItchyRed
        case ROSTitles().doubleVision: return ROSOutput().doubleVision
        case ROSTitles().eyePain: return ROSOutput().eyePain
        //ENT
        case ROSTitles().earAche: return ROSOutput().earAche
        case ROSTitles().earDrainage: return ROSOutput().earDrainage
        case ROSTitles().hearingLoss: return ROSOutput().hearingLoss
        case ROSTitles().ringingEars: return ROSOutput().ringingEars
        case ROSTitles().runnyNose: return ROSOutput().runnyNose
        case ROSTitles().sneezing: return ROSOutput().sneezing
        case ROSTitles().congestion: return ROSOutput().congestion
        case ROSTitles().nasalDrip: return ROSOutput().nasalDrip
        case ROSTitles().noseBleed: return ROSOutput().noseBleed
        case ROSTitles().smellLoss: return ROSOutput().smellLoss
        case ROSTitles().tasteLoss: return ROSOutput().tasteLoss
        case ROSTitles().soreThroat: return ROSOutput().soreThroat
        case ROSTitles().mouthSores: return ROSOutput().mouthSores
        case ROSTitles().hoarse: return ROSOutput().hoarse
        case ROSTitles().laryngitis: return ROSOutput().laryngitis
            //MSK
        //case "Weakness": return title
        case ROSTitles().stiffness: return ROSOutput().stiffness
        case ROSTitles().swelling: return ROSOutput().swelling
        case ROSTitles().jointAche: return ROSOutput().jointAche
        case ROSTitles().muscleAche: return ROSOutput().muscleAche
        case ROSTitles().cramps: return ROSOutput().cramps
        case ROSTitles().spasms: return ROSOutput().spasms
        //ENDO
        case ROSTitles().bruising: return ROSOutput().bruising
        case ROSTitles().transfusion: return ROSOutput().transfusion
            
        //RESP
        case ROSTitles().wheezing: return ROSOutput().wheezing
        case ROSTitles().dryCough: return ROSOutput().dryCough
        case ROSTitles().prodCough: return ROSOutput().prodCough
        case ROSTitles().bldySputum: return ROSOutput().bldySputum
        case ROSTitles().sob: return ROSOutput().sob
        case ROSTitles().dyspnea: return ROSOutput().dyspnea
        case ROSTitles().snoring: return ROSOutput().snoring
        case ROSTitles().apnea: return ROSOutput().apnea
        case ROSTitles().daySleep: return ROSOutput().daySleep
        case ROSTitles().pleurisy: return ROSOutput().pleurisy
        case ROSTitles().pnflBreaths: return ROSOutput().pnflBreaths
        //NEURO
        case ROSTitles().seizures: return ROSOutput().seizures
        case ROSTitles().strokeSymp: return ROSOutput().strokeSymp
        case ROSTitles().headaches: return ROSOutput().headaches
        case ROSTitles().tremors: return ROSOutput().tremors
        case ROSTitles().twitches: return ROSOutput().twitches
        case ROSTitles().jerks: return ROSOutput().jerks
        case ROSTitles().numbness: return ROSOutput().numbness
        case ROSTitles().tingling: return ROSOutput().tingling
        case ROSTitles().fainting: return ROSOutput().fainting
        case ROSTitles().vertigo: return ROSOutput().vertigo
        case ROSTitles().dizziness: return ROSOutput().dizziness
        case ROSTitles().lightHd: return ROSOutput().lightHd
        case ROSTitles().balance: return ROSOutput().balance
        case ROSTitles().falling: return ROSOutput().falling
        //CARDIO
        case ROSTitles().chestPain: return ROSOutput().chestPain
        case ROSTitles().angina: return ROSOutput().angina
        case ROSTitles().palpitations: return ROSOutput().palpitations
        case ROSTitles().palpRacing: return ROSOutput().palpRacing
        case ROSTitles().palpSkipping: return ROSOutput().palpSkipping
        case ROSTitles().irrHeartBeat: return ROSOutput().irrHeartBeat
        case ROSTitles().legCramps: return ROSOutput().legCramps
        //case "Swelling": return title
        case ROSTitles().diffBreathing: return ROSOutput().diffBreathing
        case ROSTitles().wakeGasping: return ROSOutput().wakeGasping
        //DERM
        case /*"Bruising",*/ ROSTitles().itching: return ROSOutput().itching
        case ROSTitles().jaundice: return ROSOutput().jaundice
        case ROSTitles().rash: return ROSOutput().rash
        case ROSTitles().hives: return ROSOutput().hives
        case ROSTitles().lumps: return ROSOutput().lumps
        case ROSTitles().sores: return ROSOutput().sores
        case ROSTitles().ulcers: return ROSOutput().ulcers
        //case "Swl Glands": return "Swollen glands"
        case ROSTitles().hairLoss: return ROSOutput().hairLoss
        case ROSTitles().excessHair: return ROSOutput().excessHair
        case ROSTitles().drySknEyeMth: return ROSOutput().drySknEyeMth
        case ROSTitles().poorHealing: return ROSOutput().poorHealing
        case ROSTitles().moleChange: return ROSOutput().moleChange
        case ROSTitles().abcesses: return ROSOutput().abcesses
        //DEFAULT
        default: return ""
        }
    }
}
