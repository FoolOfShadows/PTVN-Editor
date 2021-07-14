//
//  Extremeties VC.swift
//  Physical Exam 2
//
//  Created by Fool on 1/9/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class Extremities_VC: NSViewController, ProcessTabProtocol, NSTextFieldDelegate, NSControlTextEditingDelegate/*, NSSpeechRecognizerDelegate*/ {
	var selfView = NSView()
	

    
    
    @IBOutlet weak var extSectionsView: NSView!
    @IBOutlet weak var issueBox: NSBox!
    @IBOutlet weak var extScroll: NSScrollView!
	@IBOutlet weak var pulsesView: NSView!
    @IBOutlet weak var pulsesScroll: NSScrollView!
	@IBOutlet weak var bunionView: NSStackView!
	@IBOutlet weak var callusView: NSStackView!
	@IBOutlet weak var clubbingView: NSStackView!
	@IBOutlet weak var lQtyPulsesPopup: NSPopUpButton!
	@IBOutlet weak var rQtyPulsesPopup: NSPopUpButton!
	@IBOutlet weak var lAreaPulsesCombo: NSComboBox!
	@IBOutlet weak var rAreaPulsesCombo: NSComboBox!
	@IBOutlet weak var lCRCombo: NSComboBox!
	@IBOutlet weak var rCRCombo: NSComboBox!
    
    //PE Diabetic Foot Exam Outlets
    
    @IBOutlet weak var callusLHeelCB: NSButton!
    @IBOutlet weak var callusRHeelCB: NSButton!
    @IBOutlet weak var callusLBallCB: NSButton!
    @IBOutlet weak var callusRBallCB: NSButton!
    @IBOutlet weak var callusL1ToeCB: NSButton!
    @IBOutlet weak var callusR1ToeCB: NSButton!
    @IBOutlet weak var callusL2ToeCB: NSButton!
    @IBOutlet weak var callusR2ToeCB: NSButton!
    @IBOutlet weak var callusL3ToeCB: NSButton!
    @IBOutlet weak var callusR3ToeCB: NSButton!
    @IBOutlet weak var callusL4ToeCB: NSButton!
    @IBOutlet weak var callusR4ToeCB: NSButton!
    @IBOutlet weak var callusL5ToeCB: NSButton!
    @IBOutlet weak var callusR5ToeCB: NSButton!
    @IBOutlet weak var callusLAllToesCB: NSButton!
    @IBOutlet weak var callusRAllToesCB: NSButton!
    @IBOutlet weak var callusLMedialCB: NSButton!
    @IBOutlet weak var callusRMedialCB: NSButton!
    @IBOutlet weak var callusLLateralCB: NSButton!
    @IBOutlet weak var callusRLateralCB: NSButton!
    @IBOutlet weak var callusLBothCB: NSButton!
    @IBOutlet weak var callusRBothCB: NSButton!
    var callusCheckBoxes:[NSButton] = []
    
    @IBOutlet weak var bunionsLMedialCB: NSButton!
    @IBOutlet weak var bunionsRMedialCB: NSButton!
    @IBOutlet weak var bunionsLLateralCB: NSButton!
    @IBOutlet weak var bunionsRLateralCB: NSButton!
    @IBOutlet weak var bunionsLBothCB: NSButton!
    @IBOutlet weak var bunionsRBothCB: NSButton!
    var bunionCheckBoxes:[NSButton] = []
    
    @IBOutlet weak var hammerToesL1ToeCB: NSButton!
    @IBOutlet weak var hammerToesR1ToeCB: NSButton!
    @IBOutlet weak var hammerToesL2ToeCB: NSButton!
    @IBOutlet weak var hammerToesR2ToeCB: NSButton!
    @IBOutlet weak var hammerToesL3ToeCB: NSButton!
    @IBOutlet weak var hammerToesR3ToeCB: NSButton!
    @IBOutlet weak var hammerToesL4ToeCB: NSButton!
    @IBOutlet weak var hammerToesR4ToeCB: NSButton!
    @IBOutlet weak var hammerToesL5ToeCB: NSButton!
    @IBOutlet weak var hammerToesR5ToeCB: NSButton!
    @IBOutlet weak var hammerToesLAllToesCB: NSButton!
    @IBOutlet weak var hammerToesRAllToesCB: NSButton!
    var hammerToesCheckBoxes:[NSButton] = []
    
    @IBOutlet weak var onychomycosisL1ToeCB: NSButton!
    @IBOutlet weak var onychomycosisR1ToeCB: NSButton!
    @IBOutlet weak var onychomycosisL2ToeCB: NSButton!
    @IBOutlet weak var onychomycosisR2ToeCB: NSButton!
    @IBOutlet weak var onychomycosisL3ToeCB: NSButton!
    @IBOutlet weak var onychomycosisR3ToeCB: NSButton!
    @IBOutlet weak var onychomycosisL4ToeCB: NSButton!
    @IBOutlet weak var onychomycosisR4ToeCB: NSButton!
    @IBOutlet weak var onychomycosisL5ToeCB: NSButton!
    @IBOutlet weak var onychomycosisR5ToeCB: NSButton!
    @IBOutlet weak var onychomycosisLAllToesCB: NSButton!
    @IBOutlet weak var onychomycosisRAllToesCB: NSButton!
    var onychomycosisCheckBoxes:[NSButton] = []
    
    @IBOutlet weak var cyanosisL1ToeCB: NSButton!
    @IBOutlet weak var cyanosisR1ToeCB: NSButton!
    @IBOutlet weak var cyanosisL2ToeCB: NSButton!
    @IBOutlet weak var cyanosisR2ToeCB: NSButton!
    @IBOutlet weak var cyanosisL3ToeCB: NSButton!
    @IBOutlet weak var cyanosisR3ToeCB: NSButton!
    @IBOutlet weak var cyanosisL4ToeCB: NSButton!
    @IBOutlet weak var cyanosisR4ToeCB: NSButton!
    @IBOutlet weak var cyanosisL5ToeCB: NSButton!
    @IBOutlet weak var cyanosisR5ToeCB: NSButton!
    @IBOutlet weak var cyanosisLAllToesCB: NSButton!
    @IBOutlet weak var cyanosisRAllToesCB: NSButton!
    var cyanosisCheckBoxes:[NSButton] = []
    
    @IBOutlet weak var vsLToesCB: NSButton!
    @IBOutlet weak var vsRToesCB: NSButton!
    @IBOutlet weak var vsLHeelCB: NSButton!
    @IBOutlet weak var vsRHeelCB: NSButton!
    @IBOutlet weak var vsLFootCB: NSButton!
    @IBOutlet weak var vsRFootCB: NSButton!
    @IBOutlet weak var vsLAnkleCB: NSButton!
    @IBOutlet weak var vsRAnkleCB: NSButton!
    @IBOutlet weak var vsLCalfCB: NSButton!
    @IBOutlet weak var vsRCalfCB: NSButton!
    @IBOutlet weak var vsLKneeCB: NSButton!
    @IBOutlet weak var vsRKneeCB: NSButton!
    @IBOutlet weak var vsLThighCB: NSButton!
    @IBOutlet weak var vsRThighCB: NSButton!
    @IBOutlet weak var vsLAbdomenCB: NSButton!
    @IBOutlet weak var vsRAbdomenCB: NSButton!
    @IBOutlet weak var vsLDecreasedCB: NSButton!
    @IBOutlet weak var vsRDecreasedCB: NSButton!
    @IBOutlet weak var vsLAbsentCB: NSButton!
    @IBOutlet weak var vsRAbsentCB: NSButton!
    var vibrationSenseCheckBoxes:[NSButton] = []
    
    @IBOutlet weak var mfLToesCB: NSButton!
    @IBOutlet weak var mfRToesCB: NSButton!
    @IBOutlet weak var mfLHeelCB: NSButton!
    @IBOutlet weak var mfRHeelCB: NSButton!
    @IBOutlet weak var mfLFootCB: NSButton!
    @IBOutlet weak var mfRFootCB: NSButton!
    @IBOutlet weak var mfLAnkleCB: NSButton!
    @IBOutlet weak var mfRAnkleCB: NSButton!
    @IBOutlet weak var mfLCalfCB: NSButton!
    @IBOutlet weak var mfRCalfCB: NSButton!
    @IBOutlet weak var mfLKneeCB: NSButton!
    @IBOutlet weak var mfRKneeCB: NSButton!
    @IBOutlet weak var mfLThighCB: NSButton!
    @IBOutlet weak var mfRThighCB: NSButton!
    @IBOutlet weak var mfLAbdomenCB: NSButton!
    @IBOutlet weak var mfRAbdomenCB: NSButton!
    @IBOutlet weak var mfLDecreasedCB: NSButton!
    @IBOutlet weak var mfRDecreasedCB: NSButton!
    @IBOutlet weak var mfLAbsentCB: NSButton!
    @IBOutlet weak var mfRAbsentCB: NSButton!
    var monofilamentCheckBoxes:[NSButton] = []
    
    
    
    //    var extTextView: NSTextView {
//        get {
//            return extScroll.contentView.documentView as! NSTextView
//        }
//    }
    var pulsesTextView: NSTextView {
        get {
            return pulsesScroll.contentView.documentView as! NSTextView
        }
    }
    
    var callusResults:[String] = []
    var bunionResults:[String] = []
    var hammerToesResults:[String] = []
    var onychomycosisResults:[String] = []
    var cyanosisResults:[String] = []
    var vibrationSenseResults:[String] = []
    var monofilamentResults:[String] = []
    
    var edemaTypeBox = NSBox()
    var edemaPittingBox = NSBox()
    var sideBox = NSBox()
    var edemaAreaBox = NSBox()
    var edemaModifierBox = NSBox()
    var extremitiesBox = NSBox()
    var leftDigitsBox = NSBox()
    var rightDigitsBox = NSBox()
    var leftSenseStrengthBox = NSBox()
    var rightSenseStrengthBox = NSBox()
    var leftSenseAreaBox = NSBox()
    var rightSenseAreaBox = NSBox()
    var leftCallusAreaBox = NSBox()
    var rightCallusAreaBox = NSBox()
    var medialBunionBox = NSBox()
    var lateralBunionBox = NSBox()
    
    var boxes = [NSBox]()
    
    let caseLists = extEnumLists()
    
    let defaultFont:NSFont = .systemFont(ofSize: 13)
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
	
	override func viewDidLoad() {
        print("Extremities view has loaded")
        super.viewDidLoad()
		selfView = self.view
        clearExtremitiesTab()
        
        selectAllNormsInView()
        
        (lCRCombo as NSTextField).delegate = self
        (rCRCombo as NSTextField).delegate = self
        
        //Set up the font settings for the text views
        let theUserFont:NSFont = NSFont.systemFont(ofSize: 18)
        let fontAttributes = NSDictionary(object: theUserFont, forKey: kCTFontAttributeName as! NSCopying)
        pulsesTextView.typingAttributes = fontAttributes as! [NSAttributedString.Key : Any]
        //extTextView.typingAttributes = fontAttributes as! [NSAttributedString.Key : Any]
        
        //Populate the checkbox arrays
        callusCheckBoxes = [callusLHeelCB, callusRHeelCB, callusLBallCB, callusRBallCB, callusL1ToeCB, callusR1ToeCB, callusL2ToeCB, callusR2ToeCB, callusL3ToeCB, callusR3ToeCB, callusL4ToeCB, callusR4ToeCB, callusL5ToeCB, callusR5ToeCB, callusLAllToesCB, callusRAllToesCB, callusLMedialCB, callusRMedialCB, callusLLateralCB, callusRLateralCB, callusLBothCB, callusRBothCB]
        bunionCheckBoxes = [bunionsLMedialCB, bunionsRMedialCB, bunionsLLateralCB, bunionsRLateralCB, bunionsLBothCB, bunionsRBothCB]
        hammerToesCheckBoxes = [hammerToesL1ToeCB, hammerToesR1ToeCB, hammerToesL2ToeCB, hammerToesR2ToeCB, hammerToesL3ToeCB, hammerToesR3ToeCB, hammerToesL4ToeCB, hammerToesR4ToeCB, hammerToesL5ToeCB, hammerToesR5ToeCB, hammerToesLAllToesCB, hammerToesRAllToesCB]
        onychomycosisCheckBoxes = [onychomycosisL1ToeCB, onychomycosisR1ToeCB, onychomycosisL2ToeCB, onychomycosisR2ToeCB, onychomycosisL3ToeCB, onychomycosisR3ToeCB, onychomycosisL4ToeCB, onychomycosisR4ToeCB, onychomycosisL5ToeCB, onychomycosisR5ToeCB, onychomycosisLAllToesCB, onychomycosisRAllToesCB]
        cyanosisCheckBoxes = [cyanosisL1ToeCB, cyanosisR1ToeCB, cyanosisL2ToeCB, cyanosisR2ToeCB, cyanosisL3ToeCB, cyanosisR3ToeCB, cyanosisL4ToeCB, cyanosisR4ToeCB, cyanosisL5ToeCB, cyanosisR5ToeCB, cyanosisLAllToesCB, cyanosisRAllToesCB]
        vibrationSenseCheckBoxes = [vsLToesCB, vsRToesCB, vsLHeelCB, vsRHeelCB, vsLFootCB, vsRFootCB, vsLAnkleCB, vsRAnkleCB, vsLCalfCB, vsRCalfCB, vsLKneeCB, vsRKneeCB, vsLThighCB, vsRThighCB, vsLAbdomenCB, vsRAbdomenCB, vsLDecreasedCB, vsRDecreasedCB, vsLAbsentCB, vsRAbsentCB]
        monofilamentCheckBoxes = [mfLToesCB, mfRToesCB, mfLHeelCB, mfRHeelCB, mfLFootCB, mfRFootCB, mfLAnkleCB, mfRAnkleCB, mfLCalfCB, mfRCalfCB, mfLKneeCB, mfRKneeCB, mfLThighCB, mfRThighCB, mfLAbdomenCB, mfRAbdomenCB, mfLDecreasedCB, mfRDecreasedCB, mfLAbsentCB, mfRAbsentCB]
        
        let allCheckBoxes = callusCheckBoxes + bunionCheckBoxes + hammerToesCheckBoxes + onychomycosisCheckBoxes + cyanosisCheckBoxes + vibrationSenseCheckBoxes + monofilamentCheckBoxes
        allCheckBoxes.turnButtonsOff()

        addAlternateTitles()
        for checkBox in allCheckBoxes {
            checkBox.action = #selector(selectExamSite)
            print("Selector added to button \(checkBox.alternateTitle)")
        }
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }
    
//    override func viewDidAppear() {
//        recognizer.startListening()
//    }
    

    /*override*/ func controlTextDidChange(_ notification: Notification) {
        if !lCRCombo.stringValue.isEmpty || !rCRCombo.stringValue.isEmpty {
            //print("One of these fields has info")
            let theButtons = selfView.getButtonsInView()
            theButtons.filter ({$0.tag == 5})[0].state = .off
        }
    }

	
	@IBAction func clearTab(_ sender: Any) {
		clearExtremitiesTab()
        clearAreaNonSiteViews()
	}
    
    
    private func clearAreaNonSiteViews() {
//        boxes = [edemaTypeBox, edemaPittingBox, sideBox, edemaAreaBox, edemaModifierBox, extremitiesBox, leftDigitsBox, rightDigitsBox, leftSenseStrengthBox, leftSenseAreaBox, rightSenseStrengthBox, rightSenseAreaBox, leftCallusAreaBox, rightCallusAreaBox]
//        for box in boxes {
//            box.subviews.forEach({ $0.removeFromSuperview() } )
//        }
        extSectionsView.subviews.forEach({ if let theSub = $0 as? NSBox {
            if theSub.title != "Issue" {
            $0.removeFromSuperview()
            }
            }
        })
        sideBox = NSBox()
        edemaTypeBox = NSBox()
        edemaPittingBox = NSBox()
        edemaAreaBox = NSBox()
        edemaModifierBox = NSBox()
        edemaModifierBox = NSBox()
        extremitiesBox = NSBox()
        leftDigitsBox = NSBox()
        rightDigitsBox = NSBox()
        leftSenseStrengthBox = NSBox()
        leftSenseAreaBox = NSBox()
        rightSenseStrengthBox = NSBox()
        rightSenseAreaBox = NSBox()
        leftCallusAreaBox = NSBox()
        rightCallusAreaBox = NSBox()
        medialBunionBox = NSBox()
        lateralBunionBox = NSBox()
    }
    
    @IBAction func setAreaSelections(_ sender:NSButton) {
        if sender.state == .on {
            clearAreaNonSiteViews()
            if let buttons = sender.superview?.subviews {
                for button in buttons {
                    if (button as! NSButton).title != sender.title {
                        (button as! NSButton).state = .off
                    }
                }
            }
            switchNormOff(sender)
            switch sender.title {
            case "Edema":
                setUpBoxesForEdema()
                edemaTypeBox.activateButtonsWithNames(["+1"])
                edemaPittingBox.activateButtonsWithNames(["pitting"])
                sideBox.activateButtonsWithNames(["bilateral"])
                edemaAreaBox.activateButtonsWithNames(["ankle"])
            case "Cyanosis":
                setUpBoxesForOnchCyHam()
                extremitiesBox.activateButtonsWithNames(["toes"])
                leftDigitsBox.activateButtonsWithNames(["all"])
                rightDigitsBox.activateButtonsWithNames(["all"])
            case "Onychomycosis":
                setUpBoxesForOnchCyHam()
                extremitiesBox.activateButtonsWithNames(["toes"])
                leftDigitsBox.activateButtonsWithNames(["1"])
                rightDigitsBox.activateButtonsWithNames(["1"])
            case "Hammer Toes": setUpBoxesForOnchCyHam()
            case "Vibration Sense":
                setUpBoxesForVibMono()
                leftSenseAreaBox.activateButtonsWithNames(["foot"])
                leftSenseStrengthBox.activateButtonsWithNames(["decreased"])
                rightSenseAreaBox.activateButtonsWithNames(["foot"])
                rightSenseStrengthBox.activateButtonsWithNames(["decreased"])
            case "Monofilament":
                setUpBoxesForVibMono()
                leftSenseAreaBox.activateButtonsWithNames(["toes"])
                leftSenseStrengthBox.activateButtonsWithNames(["absent"])
                rightSenseAreaBox.activateButtonsWithNames(["toes"])
                rightSenseStrengthBox.activateButtonsWithNames(["absent"])
            case "Spider Veins":
                setupBoxesForSpiderVericose()
                leftSenseAreaBox.activateButtonsWithNames(["ankle"])
                rightSenseAreaBox.activateButtonsWithNames(["ankle"])
            case "Vericose Veins":
                setupBoxesForSpiderVericose()
                leftSenseAreaBox.activateButtonsWithNames(["calf"])
                rightSenseAreaBox.activateButtonsWithNames(["calf"])
            case "Calluses":
                setupBoxesForCalluses()
                leftCallusAreaBox.activateButtonsWithNames(["1st toe", "medial"])
                rightCallusAreaBox.activateButtonsWithNames(["1st toe", "medial"])
            case "Bunions":
                setupBoxesForBunions()
                medialBunionBox.activateButtonsWithNames(["bilateral"])
                
            default: return
            }
        } else if sender.state == .off {
            clearAreaNonSiteViews()
        }
        
    }
    
    private func setUpBoxesForEdema() {
        edemaTypeBox.addButtonsToViewWithNames(caseLists.edemaTypeCases, andSelector: #selector(uniqueSelections))
        edemaTypeBox.setUpSectionBoxUsingTitle(title: "Degree", font: defaultFont, referenceView: issueBox, andButtonList: caseLists.edemaTypeCases, inView: self.extSectionsView, withHeightAdjustment: 18)
        edemaPittingBox.addButtonsToViewWithNames(caseLists.edemaPittingCases, andSelector: #selector(uniqueSelections))
        edemaPittingBox.setUpSectionBoxUsingTitle(title: "Pitting", font: defaultFont, referenceView: edemaTypeBox, andButtonList: caseLists.edemaPittingCases, inView: self.extSectionsView, withHeightAdjustment: 18)
        sideBox.addButtonsToViewWithNames(caseLists.sideCases, andSelector: #selector(uniqueSelections))
        sideBox.setUpSectionBoxUsingTitle(title: "Side", font: defaultFont, referenceView: edemaPittingBox, andButtonList: caseLists.sideCases, inView: self.extSectionsView, withHeightAdjustment: 18)
        edemaAreaBox.addButtonsToViewWithNames(caseLists.edemaAreaCases, andSelector: #selector(uniqueSelections))
        edemaAreaBox.setUpSectionBoxUsingTitle(title: "Area", font: defaultFont, referenceView: sideBox, andButtonList: caseLists.edemaAreaCases, inView: self.extSectionsView, withHeightAdjustment: 18)
        edemaModifierBox.addButtonsToViewWithNames(caseLists.edemaModifierCases, andSelector: #selector(uniqueSelections))
        edemaModifierBox.setUpSectionBoxUsingTitle(title: "Modifier", font: defaultFont, referenceView: edemaAreaBox, andButtonList: caseLists.edemaModifierCases, inView: self.extSectionsView, withHeightAdjustment: 18)
    }
    
    private func setUpBoxesForOnchCyHam() {
        extremitiesBox.addButtonsToViewWithNames(caseLists.extremitiesCases, andSelector: #selector(uniqueSelections))
        extremitiesBox.setUpSectionBoxUsingTitle(title: "Extremity", font: defaultFont, referenceView: issueBox, andButtonList: caseLists.extremitiesCases, inView: self.extSectionsView, withHeightAdjustment: 18)
        leftDigitsBox.addButtonsToViewWithNames(caseLists.digitCases, andSelector: nil)
        leftDigitsBox.setUpSectionBoxUsingTitle(title: "Left", font: defaultFont, referenceView: extremitiesBox, andButtonList: caseLists.digitCases, inView: self.extSectionsView, withHeightAdjustment: 18)
        rightDigitsBox.addButtonsToViewWithNames(caseLists.digitCases, andSelector: nil)
        rightDigitsBox.setUpSectionBoxUsingTitle(title: "Right", font: defaultFont, referenceView: leftDigitsBox, andButtonList: caseLists.digitCases, inView: self.extSectionsView, withHeightAdjustment: 18)
    }
    
    private func setUpBoxesForVibMono() {
        leftSenseAreaBox.addButtonsToViewWithNames(caseLists.senseAreaCases, andSelector: #selector(uniqueSelections))
        leftSenseAreaBox.setUpSectionBoxUsingTitle(title: "Left", font: defaultFont, referenceView: issueBox, andButtonList: caseLists.senseAreaCases, inView: self.extSectionsView, withHeightAdjustment: 18)
        leftSenseStrengthBox.addButtonsToViewWithNames(caseLists.senseStrengthCases, andSelector: #selector(uniqueSelections))
        leftSenseStrengthBox.setUpSectionBoxUsingTitle(title: "Sense", font: defaultFont, referenceView: leftSenseAreaBox, andButtonList: caseLists.senseStrengthCases, inView: self.extSectionsView, withHeightAdjustment: 18)
        rightSenseAreaBox.addButtonsToViewWithNames(caseLists.senseAreaCases, andSelector: #selector(uniqueSelections))
        rightSenseAreaBox.setUpSectionBoxUsingTitle(title: "Right", font: defaultFont, referenceView: leftSenseStrengthBox, andButtonList: caseLists.senseAreaCases, inView: self.extSectionsView, withHeightAdjustment: 18)
        rightSenseStrengthBox.addButtonsToViewWithNames(caseLists.senseStrengthCases, andSelector: #selector(uniqueSelections))
        rightSenseStrengthBox.setUpSectionBoxUsingTitle(title: "Sense", font: defaultFont, referenceView: rightSenseAreaBox, andButtonList: caseLists.senseStrengthCases, inView: self.extSectionsView, withHeightAdjustment: 18)
    }
    
    private func setupBoxesForSpiderVericose() {
        leftSenseAreaBox.addButtonsToViewWithNames(caseLists.senseAreaCases, andSelector: #selector(uniqueSelections))
        leftSenseAreaBox.setUpSectionBoxUsingTitle(title: "Left", font: defaultFont, referenceView: issueBox, andButtonList: caseLists.senseAreaCases, inView: self.extSectionsView, withHeightAdjustment: 18)
        rightSenseAreaBox.addButtonsToViewWithNames(caseLists.senseAreaCases, andSelector: #selector(uniqueSelections))
        rightSenseAreaBox.setUpSectionBoxUsingTitle(title: "Right", font: defaultFont, referenceView: leftSenseAreaBox, andButtonList: caseLists.senseAreaCases, inView: self.extSectionsView, withHeightAdjustment: 18)
    }
    
    private func setupBoxesForCalluses() {
        leftCallusAreaBox.addButtonsToViewWithNames(caseLists.callusAreaCases, andSelector: nil)
        leftCallusAreaBox.setUpSectionBoxUsingTitle(title: "Left", font: defaultFont, referenceView: issueBox, andButtonList: caseLists.callusAreaCases, inView: self.extSectionsView, withHeightAdjustment: 18)
        rightCallusAreaBox.addButtonsToViewWithNames(caseLists.callusAreaCases, andSelector: nil)
        rightCallusAreaBox.setUpSectionBoxUsingTitle(title: "Right", font: defaultFont, referenceView: leftCallusAreaBox, andButtonList: caseLists.callusAreaCases, inView: self.extSectionsView, withHeightAdjustment: 18)
    }
    
    private func setupBoxesForBunions() {
        medialBunionBox.addButtonsToViewWithNames(caseLists.sideCases, andSelector: nil)
        medialBunionBox.setUpSectionBoxUsingTitle(title: "Medial", font: defaultFont, referenceView: issueBox, andButtonList: caseLists.sideCases, inView: self.extSectionsView, withHeightAdjustment: 18)
        lateralBunionBox.addButtonsToViewWithNames(caseLists.sideCases, andSelector: nil)
        lateralBunionBox.setUpSectionBoxUsingTitle(title: "Lateral", font: defaultFont, referenceView: medialBunionBox, andButtonList: caseLists.sideCases, inView: self.extSectionsView, withHeightAdjustment: 18)
    }
    
    @objc func uniqueSelections(_ sender:NSButton) {
        if sender.state == .on {
            if let buttons = sender.superview?.subviews {
                for button in buttons {
                    if (button as! NSButton).title != sender.title {
                        (button as! NSButton).state = .off
                    }
                }
            }
        }
    }
    
    @IBAction func addOrderToView(_ sender: Any) {
        var returnValues = [String]()
        boxes = [edemaTypeBox, edemaPittingBox, sideBox, edemaAreaBox, edemaModifierBox, extremitiesBox, leftDigitsBox, rightDigitsBox, leftSenseStrengthBox, leftSenseAreaBox, rightSenseStrengthBox, rightSenseAreaBox, leftCallusAreaBox, rightCallusAreaBox, medialBunionBox, lateralBunionBox]
        for box in boxes {
            let selections = box.getActiveButtonsInView()
            if !selections.isEmpty {
                returnValues.append("\(box.title): \(selections.joined(separator: ", "))")
            }
        }
        //extTextView.addToViewsExistingText("\(issueBox.getActiveButtonInView().capitalized) - \(returnValues.joined(separator: "; "))")
    }
	
	@IBAction func processExtremitiesTab(_ sender: Any) {
		let results = processTab()
        theData.objective.addToExistingText(results)
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
		//print(results)
	}
	
	func processTab() -> String {
		var resultArray = [String]()
		resultArray.append(Extremities().processSectionFrom(getActiveButtonInfoIn(view: self.view)))
		resultArray.append(pulsesTextView.string)
		resultArray.append(CapillaryRefill().processSectionFrom(getActiveButtonInfoIn(view: self.view)))
		resultArray.append(Clubbing().processSectionFrom(getActiveButtonInfoIn(view: clubbingView)))
//		resultArray.append(Bunions().processSectionFrom(getActiveButtonInfoIn(view: bunionView)))
//		resultArray.append(Callus().processSectionFrom(getActiveButtonInfoIn(view: callusView)))
        //resultArray.append(extTextView.string.components(separatedBy: "\n").joined(separator: ", "))
        
        if !callusResults.isEmpty {
            resultArray.append(Extremities().processExtResultsForSection(ExtSectionName.Calluses.rawValue, from: callusResults))
        }
        if !bunionResults.isEmpty {
            resultArray.append(Extremities().processExtResultsForSection(ExtSectionName.Bunions.rawValue, from: bunionResults))
        }
        if !hammerToesResults.isEmpty {
            resultArray.append(Extremities().processExtResultsForSection(ExtSectionName.HammerToes.rawValue, from: hammerToesResults))
        }
        if !onychomycosisResults.isEmpty {
            resultArray.append(Extremities().processExtResultsForSection(ExtSectionName.Onchomycosis.rawValue, from: onychomycosisResults))
        }
        if !cyanosisResults.isEmpty {
            resultArray.append(Extremities().processExtResultsForSection(ExtSectionName.Cyanosis.rawValue, from: cyanosisResults))
        }
        if !vibrationSenseResults.isEmpty {
            resultArray.append(Extremities().processExtResultsForSection(ExtSectionName.VibrationSense.rawValue, from: vibrationSenseResults))
        }
        if !monofilamentResults.isEmpty {
            resultArray.append(Extremities().processExtResultsForSection(ExtSectionName.Monofilament.rawValue, from: monofilamentResults))
        }
        
		resultArray = resultArray.filter {!$0.isEmpty}
		if !resultArray.isEmpty {
			return "EXTREMITIES: \(resultArray.filter {$0 != ""}.joined(separator: ", "))"
			
		}
		return ""
	}
	
	func clearExtremitiesTab() {
		self.view.clearControllers()
		self.view.populateSelectionsInViewUsing(Extremities())
	}
	

	
	@IBAction func selectOnlyOne(_ sender: NSButton) {
		if let buttons = sender.superview?.subviews as? [NSButton] {
			for button in buttons {
				if button.title != sender.title {
					button.state = .off
				}
			}
		}
        switchNormOff(sender)
	}
    
    @IBAction func switchNormOff(_ sender: NSButton) {
        
        if sender.state != .off {
            let theButtons = selfView.getButtonsInView()
            switch sender.tag {
            case 40:
                theButtons.filter ({$0.tag == 3})[0].state = .off
            case 50, 52:
                theButtons.filter ({$0.tag == 4})[0].state = .off
            case 105...110:
                theButtons.filter ({$0.tag == 2})[0].state = .off
            case 55:
                theButtons.filter ({$0.tag == 1})[0].state = .off
            case 80:
                theButtons.filter ({$0.tag == 6})[0].state = .off
            case 81:
                theButtons.filter ({$0.tag == 7})[0].state = .off
            default: return
            }
        }
    }
	
    @IBAction func comboSwitchNormOff(_ sender: NSComboBox) {
        if !sender.stringValue.isEmpty {
            let theButtons = selfView.getButtonsInView()
            switch sender.tag {
            case 24, 25:
                theButtons.filter ({$0.tag == 5})[0].state = .off
            default: return
            }
            
        }
        
    }
    
    @IBAction func selectNorms(_ sender: NSButton) {
		func normalButtonRangesForSection(_ section:String) -> [Int] {
			switch section {
            //If there were "l:" or "r:" buttons at some point
            //I got rid of them at some point
			case "n:":
                //Don't select the Vibe or Monofil normal checkboxes
				return [Int](1...5)
//            case "l:":
//                return [Int](1...5)
//            case "r:":
//                return [Int](1...5)
			default:
				return [Int]()
			}
		}
		
		let name = sender.title
		turnButtons(getButtonsInView(sender.superview!), InRange: normalButtonRangesForSection(name.lowercased()), ToState: sender.state)
	}
	
	@IBAction func processSectionsToTextViews(_ sender: NSButton) {
		switch sender.tag {
		//case 1000: edemaTextView.addToViewsExistingText(Edema().processSectionFrom(getActiveButtonInfoIn(view: edemaView)))
		case 1001: pulsesTextView.addToViewsExistingText(Pulses().processSectionFrom(getActiveButtonInfoIn(view: pulsesView)))
		//case 1002: digitAssessmentTextView.string = (digitAssessment.processSectionFrom(getActiveButtonInfoIn(view: digitAssessmentView)))
		//case 1003: limbAssessmentTextView.addToViewsExistingText(limbAssessment.processSectionFrom(getActiveButtonInfoIn(view: limbAssessmentView)))
		default: return
		}
		sender.superview?.clearControllers()
		sender.superview?.populateSelectionsInViewUsing(Extremities())
	}
	
	
	@IBAction func copyPulsesRight(_ sender: NSButton) {
		if !lAreaPulsesCombo.stringValue.isEmpty {
			rAreaPulsesCombo.stringValue = lAreaPulsesCombo.stringValue
		}
		if !lQtyPulsesPopup.title.isEmpty {
			rQtyPulsesPopup.title = lQtyPulsesPopup.title
		}
	}
	@IBAction func copyCRRight(_ sender: NSButton) {
		if !lCRCombo.stringValue.isEmpty {
			rCRCombo.stringValue = lCRCombo.stringValue
		}
	}
    
    @objc func selectExamSite(_ sender: NSButton) {
        // Tag matching list: 1 - Calluses, 2 - Bunions, 3 - Hammer Toes, 4 - Onychomycosis, 5 - Cyanosis, 6 - Vibration Sense, 7 - Monofilament
        let buttonName = sender.alternateTitle
        let buttonTag = sender.tag
        if sender.state == .on {
            switch sender.tag {
            case 1: callusResults.append(buttonName)
            case 2: bunionResults.append(buttonName)
            case 3: hammerToesResults.append(buttonName)
            case 4: onychomycosisResults.append(buttonName)
            case 5: cyanosisResults.append(buttonName)
            case 6: vibrationSenseResults.append(buttonName)
            case 7: monofilamentResults.append(buttonName)
            default: print("no tag found")
                
            }
            
            
        } else if sender.state == .off {
            switch sender.tag {
            case 1: callusResults = callusResults.filter {$0 != buttonName}
            case 2: bunionResults = bunionResults.filter {$0 != buttonName}
            case 3: hammerToesResults = hammerToesResults.filter {$0 != buttonName}
            case 4: onychomycosisResults = onychomycosisResults.filter {$0 != buttonName}
            case 5: cyanosisResults = cyanosisResults.filter {$0 != buttonName}
            case 6: vibrationSenseResults = vibrationSenseResults.filter {$0 != buttonName}
            case 7: monofilamentResults = monofilamentResults.filter {$0 != buttonName}
            default: print("no tag found")
            }
        }
        print("Button title: \(buttonName)\nBox tag: \(buttonTag)")
    }
    
    
    @objc func selectAllNormsInView() {
        let normButtons = self.view.getNormalButtonsInView()
        for button in normButtons {
            button.state = .on
            selectNorms(button)
        }
    }
    
    private func addAlternateTitles() {
        for item in [callusLHeelCB, vsLHeelCB, mfLHeelCB] {
            item?.alternateTitle = "left heel"
        }
        for item in [callusRHeelCB, vsRHeelCB, mfRHeelCB] {
            item?.alternateTitle = "right heel"
        }
        callusLBallCB.alternateTitle = "left ball"
        callusRBallCB.alternateTitle = "right ball"
        for item in [callusL1ToeCB, hammerToesL1ToeCB, onychomycosisL1ToeCB, cyanosisL1ToeCB] {
            item?.alternateTitle = "left first toe"
        }
        for item in [callusL2ToeCB, hammerToesL2ToeCB, onychomycosisL2ToeCB, cyanosisL2ToeCB] {
            item?.alternateTitle = "left second toe"
        }
        for item in [callusL3ToeCB, hammerToesL3ToeCB, onychomycosisL3ToeCB, cyanosisL3ToeCB] {
            item?.alternateTitle = "left third toe"
        }
        for item in [callusL4ToeCB, hammerToesL4ToeCB, onychomycosisL4ToeCB, cyanosisL4ToeCB] {
            item?.alternateTitle = "left fourth toe"
        }
        for item in [callusL5ToeCB, hammerToesL5ToeCB, onychomycosisL5ToeCB, cyanosisL5ToeCB] {
            item?.alternateTitle = "left fifth toe"
        }
        for item in [callusLAllToesCB, hammerToesLAllToesCB, onychomycosisLAllToesCB, cyanosisLAllToesCB] {
            item?.alternateTitle = "all left toes"
        }
        for item in [callusR1ToeCB, hammerToesR1ToeCB, onychomycosisR1ToeCB, cyanosisR1ToeCB] {
            item?.alternateTitle = "right first toe"
        }
        for item in [callusR2ToeCB, hammerToesR2ToeCB, onychomycosisR2ToeCB, cyanosisR2ToeCB] {
            item?.alternateTitle = "right second toe"
        }
        for item in [callusR3ToeCB, hammerToesR3ToeCB, onychomycosisR3ToeCB, cyanosisR3ToeCB] {
            item?.alternateTitle = "right third toe"
        }
        for item in [callusR4ToeCB, hammerToesR4ToeCB, onychomycosisR4ToeCB, cyanosisR4ToeCB] {
            item?.alternateTitle = "right fourth toe"
        }
        for item in [callusR5ToeCB, hammerToesR5ToeCB, onychomycosisR5ToeCB, cyanosisR5ToeCB] {
            item?.alternateTitle = "right fifth toe"
        }
        for item in [callusRAllToesCB, hammerToesRAllToesCB, onychomycosisRAllToesCB, cyanosisRAllToesCB] {
            item?.alternateTitle = "all right toes"
        }
        for item in [callusLMedialCB, bunionsLMedialCB] {
            item?.alternateTitle = "left medial side"
        }
        for item in [callusRMedialCB, bunionsRMedialCB] {
            item?.alternateTitle = "right medial side"
        }
        for item in [callusLLateralCB, bunionsLLateralCB] {
            item?.alternateTitle = "left lateral side"
        }
        for item in [callusRLateralCB, bunionsRLateralCB] {
            item?.alternateTitle = "right lateral side"
        }
        for item in [callusLBothCB, bunionsLBothCB] {
            item?.alternateTitle = "left medial and lateral side"
        }
        for item in [callusRBothCB, bunionsRBothCB] {
            item?.alternateTitle = "right medial and lateral side"
        }
        for item in [vsLToesCB, mfLToesCB] {
            item?.alternateTitle = "left toes"
        }
        for item in [vsRToesCB, mfRToesCB] {
            item?.alternateTitle = "right toes"
        }
        for item in [vsLFootCB, mfLFootCB] {
            item?.alternateTitle = "left foot"
        }
        for item in [vsRFootCB, mfRFootCB] {
            item?.alternateTitle = "right foot"
        }
        for item in [vsLAnkleCB, mfLAnkleCB] {
            item?.alternateTitle = "left ankle"
        }
        for item in [vsRAnkleCB, mfRAnkleCB] {
            item?.alternateTitle = "right ankle"
        }
        for item in [vsLCalfCB, mfLCalfCB] {
            item?.alternateTitle = "left calf"
        }
        for item in [vsRCalfCB, mfRCalfCB] {
            item?.alternateTitle = "right calf"
        }
        for item in [vsLKneeCB, mfLKneeCB] {
            item?.alternateTitle = "left knee"
        }
        for item in [vsRKneeCB, mfRKneeCB] {
            item?.alternateTitle = "right knee"
        }
        for item in [vsLThighCB, mfLThighCB] {
            item?.alternateTitle = "left thigh"
        }
        for item in [vsRThighCB, mfRThighCB] {
            item?.alternateTitle = "right thigh"
        }
        for item in [vsLAbdomenCB, mfLAbdomenCB,vsRAbdomenCB, mfRAbdomenCB] {
            item?.alternateTitle = "abdomen"
        }
        for item in [vsLDecreasedCB, vsRDecreasedCB, mfLDecreasedCB, mfRDecreasedCB] {
            item?.alternateTitle = "decreased sensation"
        }
        for item in [vsLAbsentCB, vsRAbsentCB, mfLAbsentCB, mfRAbsentCB] {
            item?.alternateTitle = "absent sensation"
        }
        
    }

}
