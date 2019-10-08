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
    
    var extTextView: NSTextView {
        get {
            return extScroll.contentView.documentView as! NSTextView
        }
    }
    var pulsesTextView: NSTextView {
        get {
            return pulsesScroll.contentView.documentView as! NSTextView
        }
    }
    
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
        extTextView.typingAttributes = fontAttributes as! [NSAttributedString.Key : Any]
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
            case "Edema": setUpBoxesForEdema()
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
        extTextView.addToViewsExistingText("\(issueBox.getActiveButtonInView().capitalized) - \(returnValues.joined(separator: "; "))")
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
		resultArray.append(Bunions().processSectionFrom(getActiveButtonInfoIn(view: bunionView)))
		resultArray.append(Callus().processSectionFrom(getActiveButtonInfoIn(view: callusView)))
        resultArray.append(extTextView.string.components(separatedBy: "\n").joined(separator: ", "))
        
		
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
	
//    @IBAction func setPropertiesOfRelatedButtons(_ sender:NSButton) {
//        setPropertiesOfButtonsBasedOnTag(sender.tag)
//    }
	
//    func setPropertiesOfButtonsBasedOnTag(_ tag:Int) {
//
//        func makeLimbsExclusive() {
//            for subview in limbView.subviews {
//                if let button = subview as? NSButton {
//                    button.action = #selector(selectOnlyOne(_:))
//                    button.state = .off
//                }
//            }
//        }
//        func makeLimbsNonexclusive() {
//            for subview in limbView.subviews {
//                if let button = subview as? NSButton {
//                    button.action = nil
//                    button.state = .off
//                }
//            }
//        }
//        switch tag {
//        case 80, 81:
//            makeLimbsExclusive()
//            limbDecAbView.makeButtonsInViewActive()
//        case 82, 83:
//            makeLimbsNonexclusive()
//            limbDecAbView.makeButtonsInViewInactive()
//        default: return
//        }
//    }
	
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
    
//    @objc func heardCommand() {
//        let callusViews = callusView.subviews
////        switch command {
////        case "callus right":
//            if let right = callusViews[0] as? NSButton {
//                right.state = .on
//                selectOnlyOne(right)
//            }
////            print("Heard: \(command) as callus right")
////        case "callus left":
////            if let left = callusViews[1] as? NSButton {
////                left.state = .on
////                selectOnlyOne(left)
////            }
////            print("Heard: \(command) as callus left")
////        case "callus bilateral":
////            if let bilateral = callusViews[2] as? NSButton {
////                bilateral.state = .on
////                selectOnlyOne(bilateral)
////            }
////            print("Heard: \(command) as callus bilateral")
////        default:
////            return
////        }
//    }
    
    @objc func selectAllNormsInView() {
        let normButtons = self.view.getNormalButtonsInView()
        for button in normButtons {
            button.state = .on
            selectNorms(button)
        }
    }
    
//    override func viewDidDisappear() {
//        //recognizer.stopListening()
//    }

}
