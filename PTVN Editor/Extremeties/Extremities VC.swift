//
//  Extremeties VC.swift
//  Physical Exam 2
//
//  Created by Fool on 1/9/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class Extremities_VC: NSViewController, ProcessTabProtocol, NSTextFieldDelegate/*, NSSpeechRecognizerDelegate*/ {
	var selfView = NSView()
	

	@IBOutlet weak var edemaView: NSView!
	//@IBOutlet var edemaTextView: NSTextView!
    @IBOutlet weak var edemaScroll: NSScrollView!
	@IBOutlet weak var pulsesView: NSView!
	//@IBOutlet var pulsesTextView: NSTextView!
    @IBOutlet weak var pulsesScroll: NSScrollView!
	@IBOutlet weak var digitAssessmentView: NSView!
	//@IBOutlet var digitAssessmentTextView: NSTextView!
    @IBOutlet weak var digitAssessmentScroll: NSScrollView!
	@IBOutlet weak var limbAssessmentView: NSView!
	//@IBOutlet var limbAssessmentTextView: NSTextView!
    @IBOutlet weak var limbAssessmentScroll: NSScrollView!
	@IBOutlet weak var bunionView: NSStackView!
	@IBOutlet weak var callusView: NSStackView!
	@IBOutlet weak var limbView: NSView!
	@IBOutlet weak var limbSideView: NSStackView!
	@IBOutlet weak var limbDecAbView: NSStackView!
	@IBOutlet weak var clubbingView: NSStackView!
	@IBOutlet weak var lQtyPulsesPopup: NSPopUpButton!
	@IBOutlet weak var rQtyPulsesPopup: NSPopUpButton!
	@IBOutlet weak var lAreaPulsesCombo: NSComboBox!
	@IBOutlet weak var rAreaPulsesCombo: NSComboBox!
	@IBOutlet weak var lCRCombo: NSComboBox!
	@IBOutlet weak var rCRCombo: NSComboBox!
    
    var edemaTextView: NSTextView {
        get {
            return edemaScroll.contentView.documentView as! NSTextView
        }
    }
    var pulsesTextView: NSTextView {
        get {
            return pulsesScroll.contentView.documentView as! NSTextView
        }
    }
    var digitAssessmentTextView: NSTextView {
        get {
            return digitAssessmentScroll.contentView.documentView as! NSTextView
        }
    }
    var limbAssessmentTextView: NSTextView {
        get {
            return limbAssessmentScroll.contentView.documentView as! NSTextView
        }
    }
    
	
	var digitAssessment = DigitAssessment()
	var limbAssessment = LimbAssessment()
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    
    
    //let recognizer = NSSpeechRecognizer()!
    //let commands = ["callus right", "callus left", "callus bilateral"]
	
	override func viewDidLoad() {
        super.viewDidLoad()
		//loadedViewControllers.append(self)
		selfView = self.view
        clearExtremitiesTab()
        
        //let nc = NotificationCenter.default
        //nc.addObserver(self, selector: #selector(selectAllNormsInView), name: NSNotification.Name(rawValue: "SetAllToNorm"), object: nil)
        //nc.addObserver(self, selector: #selector(heardCommand), name: NSNotification.Name(rawValue: "callus right"), object: nil)
        selectAllNormsInView()
        
        (lCRCombo as NSTextField).delegate = self
        (rCRCombo as NSTextField).delegate = self
        
       //recognizer.delegate = self
       //recognizer.commands = commands
    
        
    }
    
    override func viewDidAppear() {
        //recognizer.startListening()
    }
    

    override func controlTextDidChange(_ notification: Notification) {
        if !lCRCombo.stringValue.isEmpty || !rCRCombo.stringValue.isEmpty {
            //print("One of these fields has info")
            let theButtons = selfView.getButtonsInView()
            theButtons.filter ({$0.tag == 5})[0].state = .off
        }
    }

	
	@IBAction func clearTab(_ sender: Any) {
		clearExtremitiesTab()
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
		resultArray.append(edemaTextView.string)
		resultArray.append(pulsesTextView.string)
		resultArray.append(CapillaryRefill().processSectionFrom(getActiveButtonInfoIn(view: self.view)))
		resultArray.append(Clubbing().processSectionFrom(getActiveButtonInfoIn(view: clubbingView)))
		resultArray.append(Bunions().processSectionFrom(getActiveButtonInfoIn(view: bunionView)))
		resultArray.append(Callus().processSectionFrom(getActiveButtonInfoIn(view: callusView)))
		resultArray.append(digitAssessmentTextView.string)
		resultArray.append(limbAssessmentTextView.string)
		
		resultArray = resultArray.filter {!$0.isEmpty}
		if !resultArray.isEmpty {
			return "EXTREMITIES: \(resultArray.filter {$0 != ""}.joined(separator: ", "))"
			
		}
		return ""
	}
	
	func clearExtremitiesTab() {
		self.view.clearControllers()
		self.view.populateSelectionsInViewUsing(Extremities())
		digitAssessment = DigitAssessment()
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
			case "n:":
				return [Int](1...7)
			case "l:":
				return [Int](1...5)
			case "r:":
				return [Int](1...5)
			default:
				return [Int]()
			}
		}
		
		let name = sender.title
		turnButtons(getButtonsInView(sender.superview!), InRange: normalButtonRangesForSection(name.lowercased()), ToState: sender.state)
	}
	
	@IBAction func processSectionsToTextViews(_ sender: NSButton) {
		switch sender.tag {
		case 1000: edemaTextView.addToViewsExistingText(Edema().processSectionFrom(getActiveButtonInfoIn(view: edemaView)))
		case 1001: pulsesTextView.addToViewsExistingText(Pulses().processSectionFrom(getActiveButtonInfoIn(view: pulsesView)))
		case 1002: digitAssessmentTextView.string = (digitAssessment.processSectionFrom(getActiveButtonInfoIn(view: digitAssessmentView)))
		case 1003: limbAssessmentTextView.addToViewsExistingText(limbAssessment.processSectionFrom(getActiveButtonInfoIn(view: limbAssessmentView)))
		default: return
		}
		sender.superview?.clearControllers()
		sender.superview?.populateSelectionsInViewUsing(Extremities())
	}
	
	@IBAction func setPropertiesOfRelatedButtons(_ sender:NSButton) {
		setPropertiesOfButtonsBasedOnTag(sender.tag)
	}
	
	func setPropertiesOfButtonsBasedOnTag(_ tag:Int) {
		
		func makeLimbsExclusive() {
			for subview in limbView.subviews {
				if let button = subview as? NSButton {
					button.action = #selector(selectOnlyOne(_:))
					button.state = .off
				}
			}
		}
		func makeLimbsNonexclusive() {
			for subview in limbView.subviews {
				if let button = subview as? NSButton {
					button.action = nil
					button.state = .off
				}
			}
		}
		switch tag {
		case 80, 81:
			makeLimbsExclusive()
			limbDecAbView.makeButtonsInViewActive()
		case 82, 83:
			makeLimbsNonexclusive()
			limbDecAbView.makeButtonsInViewInactive()
		default: return
		}
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
    
    @objc func heardCommand() {
        let callusViews = callusView.subviews
//        switch command {
//        case "callus right":
            if let right = callusViews[0] as? NSButton {
                right.state = .on
                selectOnlyOne(right)
            }
//            print("Heard: \(command) as callus right")
//        case "callus left":
//            if let left = callusViews[1] as? NSButton {
//                left.state = .on
//                selectOnlyOne(left)
//            }
//            print("Heard: \(command) as callus left")
//        case "callus bilateral":
//            if let bilateral = callusViews[2] as? NSButton {
//                bilateral.state = .on
//                selectOnlyOne(bilateral)
//            }
//            print("Heard: \(command) as callus bilateral")
//        default:
//            return
//        }
    }
    
    @objc func selectAllNormsInView() {
        let normButtons = self.view.getNormalButtonsInView()
        for button in normButtons {
            button.state = .on
            selectNorms(button)
        }
    }
    
    override func viewDidDisappear() {
        //recognizer.stopListening()
    }

}
