//
//  MSKAssessmentViewController.swift
//  Physical Exam 2
//
//  Created by Fool on 12/21/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class NeuroMSK_VC: NSViewController, ProcessTabProtocol {
	var selfView = NSView()
	

	@IBOutlet weak var neuroBox: NSBox!
	@IBOutlet weak var mskBox: NSBox!
    @IBOutlet weak var generalStrengthBox: NSBox!
	
	@IBOutlet weak var rSLRCombo: NSComboBox!
	@IBOutlet weak var lSLRCombo: NSComboBox!
	@IBOutlet weak var rDTRCombo: NSComboBox!
	@IBOutlet weak var lDTRCombo: NSComboBox!
    
    @IBOutlet weak var typeView: NSBox!
    @IBOutlet weak var ttpCheckbox: NSButton!
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
	let mskAssessmentSection = MSK()
	
    var siteBox = NSBox()
    var toneBox = NSBox()
    var sideBox = NSBox()
    var swellingBox = NSBox()
    var strengthBox = NSBox()
    var directionBox = NSBox()
    var degreeBox = NSBox()
    
    var boxes = [NSBox]()
    
    let caseLists = mskEnumLists()
    
    let defaultFont:NSFont = .systemFont(ofSize: 13)
    
    @IBOutlet weak var mskResultsScroll: NSScrollView!
    var mskResultsTextView: NSTextView {
        get {
            return mskResultsScroll.contentView.documentView as! NSTextView
        }
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
		//loadedViewControllers.append(self)
		selfView = self.view
		clearMSKTab()
        //let nc = NotificationCenter.default
        //nc.addObserver(self, selector: #selector(selectAllNormsInView), name: NSNotification.Name(rawValue: "SetAllToNorm"), object: nil)
        selectAllNormsInView()
        
        //Set up the font settings for the text views
        let theUserFont:NSFont = NSFont.systemFont(ofSize: 18)
        let fontAttributes = NSDictionary(object: theUserFont, forKey: kCTFontAttributeName as! NSCopying)
        mskResultsTextView.typingAttributes = fontAttributes as! [NSAttributedString.Key : Any]
    }
    
    override func viewWillAppear() {
//        let gsSelections = generalStrengthBox.getButtonsInView().filter { (50...60).contains($0.tag)}
//        for selection in gsSelections {
//            selection.action = #selector(self.uniqueSelections(_:))
//        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }
	
	@IBAction func clearTab(_ sender: Any) {
		clearMSKTab()
        clearAllViews()
	}
	
	@IBAction func processNeuroMSKTab(_ sender: NSButton) {
		let results = processTab()
        theData.objective.addToExistingText(results)
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        //self.dismiss(self)
        
        if sender.title == "Process & Continue" {
            self.dismiss(self)
            currentPTVNDelegate?.switchToModule(module: FormButton.skinGynGUDRE)
        } else {
            self.dismiss(self)
        }
		//print(results)
	}
	
	func processTab() -> String {
		mskAssessmentSection.mskAbnormalResults = mskResultsTextView.string
		var resultArray = [String]()
		resultArray.append(Neuro().processSectionFrom(getActiveButtonInfoIn(view: neuroBox)))
		resultArray.append(mskAssessmentSection.processSectionFrom(getActiveButtonInfoIn(view: mskBox)))
		
		return resultArray.filter {$0 != ""}.joined(separator: "\n")
	}
	
	func clearMSKTab() {
		self.view.clearControllers()

		neuroBox.populateSelectionsInViewUsing(Neuro())
        generalStrengthBox.populateSelectionsInViewUsing(MSK())
	}
	
	@IBAction func selectNorms(_ sender: NSButton) {
		func normalButtonRangesForSection(_ section:String) -> [Int] {
			switch section {
			case "neuro":
				return [Int](3...6)
			case "msk":
				return [Int](1...4)
			default:
				return [Int]()
			}
		}
		
		guard let view = sender.superview else { return }
		guard let name = (view.superview as? NSBox)?.title else { return }
		turnButtons(getButtonsInView(sender.superview!), InRange: normalButtonRangesForSection(name.lowercased()), ToState: sender.state)
	}
	
	@IBAction func selectOnlyOne(_ sender: NSButton) {
		if let buttons = sender.superview?.subviews as? [NSButton] {
			for button in buttons {
				if button.title != sender.title {
					button.state = .off
				}
			}
		}
        switchNormOff()
	}
	
	@IBAction func copySLRRight(_ sender: NSButton) {
		if !rSLRCombo.stringValue.isEmpty {
			lSLRCombo.stringValue = rSLRCombo.stringValue
		}
	}
    
    @IBAction func switchNormOff(_ sender: NSButton) {
        let theButtons = self.view.getButtonsInView()
        if sender.state == .on {
            switch sender.tag {
            case 25...29:
                let dtrs = theButtons.filter({$0.tag == 4})[0]
                dtrs.state = .off
            case 35, 36:
                let dtrs = theButtons.filter({$0.tag == 5})[0]
                dtrs.state = .off
            case 101:
                let dtrs = theButtons.filter({$0.tag == 3})[1]
                dtrs.state = .off
            case 102:
                let dtrs = theButtons.filter({$0.tag == 4})[1]
                dtrs.state = .off
            default: return
            }
        }
        
    }
    
    private func switchNormOff() {
        let theButtons = self.view.getButtonsInView()
        let activeButtons = theButtons.filter {$0.state == .on}
        for button in activeButtons {
            switch button.tag {
            case 15...18:
                let dtrs = theButtons.filter({$0.tag == 2})[0]
                dtrs.state = .off
            default: continue
            }
        }
        
    }
    
	@IBAction func copyDTRRight(_ sender: NSButton) {
		if !rDTRCombo.stringValue.isEmpty {
			lDTRCombo.stringValue = rDTRCombo.stringValue
		}
	}
    
    @objc func selectAllNormsInView() {
        let normButtons = self.view.getNormalButtonsInView()
        for button in normButtons {
            button.state = .on
            selectNorms(button)
        }
    }
    
    
    //MSK section stuff
    @IBAction func setAreaSelections(_ sender:NSButton) {
        if sender.state == .on {
            clearAllViews()
            if let buttons = sender.superview?.subviews {
                for button in buttons {
                    if (button as! NSButton).title != sender.title {
                        (button as! NSButton).state = .off
                    }
                }
            }
            switch sender.title {
            case "Head & Spine": setupSiteBoxesWithCases(caseLists.headCases)
            case "Shoulders & Arms": setupSiteBoxesWithCases(caseLists.shoulderCases)
            case "Hands": setupSiteBoxesWithCases(caseLists.handCases)
            case "Hips & Legs": setupSiteBoxesWithCases(caseLists.hipCases)
            case "Feet": setupSiteBoxesWithCases(caseLists.feetCases)
            default: return
            }
        } else if sender.state == .off {
            clearAllViews()
            //testBox.isHidden = true
        }
        
    }
    
    private func setupSiteBoxesWithCases(_ cases:[String]) {
        siteBox.addButtonsToViewWithNames(cases, andSelector: #selector(setSiteSelections))
        siteBox.setUpSectionBoxUsingTitle(title: "Site", font: .systemFont(ofSize: 13), referenceView: typeView, andButtonList: cases, inView: mskBox)
    }
    
    @objc func setSiteSelections(_ sender:NSButton) {
        clearAreaNonSiteViews()
        print(sender.title)
        if sender.state == .on {
            if let buttons = sender.superview?.subviews {
                for button in buttons {
                    if (button as! NSButton).title != sender.title {
                        (button as! NSButton).state = .off
                    }
                }
            }
            switch sender.title {
            case "head": setUpBoxesForHeadNeckSections(withROMSelection: caseLists.generalROMCases)
            case "neck": setUpBoxesForHeadNeckSections(withROMSelection: caseLists.neckROMCases)
            case "traps", "ribs", "Thoracic spine", "pelvis", "sciatic", "deltoid", "bicep", "tricep", "hand", "index finger", "middle finger", "ring finger", "pinky finger", "thumb", "gluteus", "thigh", "quadricep", "hamstring", "calf", "big toe", "2nd toe", "3rd toe", "4th toe", "5th toe":
                setUpBoxesForGeneralSections(withROMSelection: caseLists.generalROMCases, andDegrees: caseLists.generalROMDegrees)
            case "shoulder": setUpBoxesForGeneralSections(withROMSelection: caseLists.shoulderROMCases, andDegrees: caseLists.shoulderRomDegrees)
            case "Lumbar spine": setUpBoxesForGeneralSections(withROMSelection: caseLists.lspineROMCases, andDegrees: caseLists.generalROMDegrees)
            case "elbow": setUpBoxesForGeneralSections(withROMSelection: caseLists.elbowROMCases, andDegrees: caseLists.generalROMDegrees)
            case "forearm": setUpBoxesForGeneralSections(withROMSelection: caseLists.forearmROMCases, andDegrees: caseLists.generalROMDegrees)
            case "wrist": setUpBoxesForGeneralSections(withROMSelection: caseLists.wristROMCases, andDegrees: caseLists.generalROMDegrees)
            case "hip": setUpBoxesForGeneralSections(withROMSelection: caseLists.hipROMCases, andDegrees: caseLists.generalROMDegrees)
            case "knee": setUpBoxesForGeneralSections(withROMSelection: caseLists.kneeROMCases, andDegrees: caseLists.generalROMDegrees)
            case "ankle": setUpBoxesForGeneralSections(withROMSelection: caseLists.ankleROMCases, andDegrees: caseLists.generalROMDegrees)
            case "foot": setUpBoxesForGeneralSections(withROMSelection: caseLists.footROMCases, andDegrees: caseLists.generalROMDegrees)
            case "paraspinal", "sacral":
                setUpBoxesForParaspinalSacralSections()
            case "heel":
                setUpBoxesForHeelSection()
            default:
                return
            }
        } else if sender.state == .off {
            //sideView.subviews.forEach({ $0.removeFromSuperview() })
        }
    }
    
    private func setUpBoxesForGeneralSections(withROMSelection rom:[String], andDegrees degrees:[String]) {
        sideBox.addButtonsToViewWithNames(caseLists.mskSideCases, andSelector: #selector(uniqueSelections))
        sideBox.setUpSectionBoxUsingTitle(title: "Side", font: defaultFont, referenceView: siteBox, andButtonList: caseLists.mskSideCases, inView: mskBox)
        swellingBox.addButtonsToViewWithNames(caseLists.swellingCases, andSelector: nil)
        swellingBox.setUpSectionBoxUsingTitle(title: "Swelling", font: defaultFont, referenceView: sideBox, andButtonList: caseLists.swellingCases, inView: mskBox)
        strengthBox.addButtonsToViewWithNames(caseLists.strengthCases, andSelector: #selector(uniqueSelections))
        strengthBox.setUpSectionBoxUsingTitle(title: "Strength", font: defaultFont, referenceView: swellingBox, andButtonList: caseLists.strengthCases, inView: mskBox)
        directionBox.addButtonsToViewWithNames(rom, andSelector: #selector(uniqueSelections))
        directionBox.setUpSectionBoxUsingTitle(title: "ROM Direction", font: defaultFont, referenceView: strengthBox, andButtonList: rom, inView: mskBox)
        degreeBox.addButtonsToViewWithNames(degrees, andSelector: #selector(uniqueSelections))
        degreeBox.setUpSectionBoxUsingTitle(title: "Deg", font: defaultFont, referenceView: directionBox, andButtonList: degrees, inView: mskBox)
        toneBox.addButtonsToViewWithNames(caseLists.toneCases, andSelector: #selector(turnToneOff))
        toneBox.setUpSectionBoxUsingTitle(title: "Tone", font: .systemFont(ofSize: 13), referenceView: degreeBox, andButtonList: caseLists.toneCases, inView: mskBox)
    }
    private func setUpBoxesForHeadNeckSections(withROMSelection rom:[String]) {
        swellingBox.addButtonsToViewWithNames(caseLists.swellingCases, andSelector: nil)
        swellingBox.setUpSectionBoxUsingTitle(title: "Swelling", font: defaultFont, referenceView: siteBox, andButtonList: caseLists.swellingCases, inView: mskBox)
        strengthBox.addButtonsToViewWithNames(caseLists.strengthCases, andSelector: #selector(uniqueSelections))
        strengthBox.setUpSectionBoxUsingTitle(title: "Strength", font: defaultFont, referenceView: swellingBox, andButtonList: caseLists.strengthCases, inView: mskBox)
        directionBox.addButtonsToViewWithNames(rom, andSelector: #selector(uniqueSelections))
        directionBox.setUpSectionBoxUsingTitle(title: "ROM Direction", font: defaultFont, referenceView: strengthBox, andButtonList: rom, inView: mskBox)
        degreeBox.addButtonsToViewWithNames(caseLists.generalROMDegrees, andSelector: #selector(uniqueSelections))
        degreeBox.setUpSectionBoxUsingTitle(title: "Deg", font: defaultFont, referenceView: directionBox, andButtonList: caseLists.generalROMDegrees, inView: mskBox)
    }
    private func setUpBoxesForParaspinalSacralSections() {
        swellingBox.addButtonsToViewWithNames(caseLists.swellingCases, andSelector: nil)
        swellingBox.setUpSectionBoxUsingTitle(title: "Swelling", font: defaultFont, referenceView: siteBox, andButtonList: caseLists.swellingCases, inView: mskBox)
    }
    private func setUpBoxesForHeelSection() {
        sideBox.addButtonsToViewWithNames(caseLists.mskSideCases, andSelector: #selector(uniqueSelections))
        sideBox.setUpSectionBoxUsingTitle(title: "Side", font: defaultFont, referenceView: siteBox, andButtonList: caseLists.mskSideCases, inView: mskBox)
        swellingBox.addButtonsToViewWithNames(caseLists.swellingCases, andSelector: nil)
        swellingBox.setUpSectionBoxUsingTitle(title: "Swelling", font: defaultFont, referenceView: sideBox, andButtonList: caseLists.swellingCases, inView: mskBox)
    }
    
    
    
    @objc func uniqueSelections(_ sender:NSButton) {
        let normalButtons = mskBox.getButtonsInView().filter { 1...4 ~= $0.tag  }
        print(normalButtons.map { $0.title})
        if sender.state == .on {
            if let buttons = sender.superview?.subviews {
                for button in buttons {
                    if (button as! NSButton).title != sender.title {
                        (button as! NSButton).state = .off
                    }
                }
            }
//            print(type(of:sender.superview))
            if let boxTitle = sender.superview?.superview as? NSBox {
                print(boxTitle.title)
                switch boxTitle.title {
                case "Strength", "General Strength":
                    normalButtons.filter { $0.title == "STR" }[0].state = .off
                case "ROM Direction":
                    normalButtons.filter { $0.title == "ROM" }[0].state = .off
                default: return
                }
            }
        }
    }
    
    @objc func turnToneOff(_ sender: NSButton) {
        if sender.state == .on {
            mskBox.getButtonsInView().filter { $0.title == "Tone" }[0].state = .off
        }
    }
    
    @IBAction func turnOffNT(_ sender:NSButton) {
        if sender.state == .on {
            mskBox.getButtonsInView().filter { $0.title == "NT"}[0].state = .off
        }
    }
    
    @IBAction func clearRadiology(_ sender: Any) {
        clearAllViews()
        typeView.turnButtonsInViewOff()
        mskResultsTextView.string = String()
    }
    
    private func clearAllViews() {
        siteBox.subviews.forEach( {$0.removeFromSuperview() } )
        siteBox.removeFromSuperview()
        siteBox = NSBox()
        clearAreaNonSiteViews()
    }
    private func clearAreaNonSiteViews() {
        boxes = [toneBox, sideBox, swellingBox, strengthBox, directionBox, degreeBox]
        for box in boxes {
            box.subviews.forEach({ $0.removeFromSuperview() } )
            box.removeFromSuperview()
            //box = NSBox()
        }
        //sideBox.removeFromSuperview()
        sideBox = NSBox()
        swellingBox = NSBox()
        strengthBox = NSBox()
        directionBox = NSBox()
        degreeBox = NSBox()
        toneBox = NSBox()
        generalStrengthBox.populateSelectionsInViewUsing(MSK())
    }
    
    @IBAction func uniqueGSModifier(_ sender: NSButton) {
        if sender.state == .on {
            let gsSelections = generalStrengthBox.getButtonsInView()
            switch sender.tag {
            case 80:
                gsSelections.filter {$0.tag == 81}[0].state = .off
            case 81:
                gsSelections.filter {$0.tag == 80}[0].state = .off
            case 85:
                gsSelections.filter {$0.tag == 86}[0].state = .off
            case 86:
                gsSelections.filter {$0.tag == 85}[0].state = .off
            default:
                return
            }
        }
    }
    
    @IBAction func addOrderToView(_ sender: Any) {
        var returnValues = [String]()
        var generalValues = [String]()
        
        boxes = [sideBox, swellingBox, strengthBox, directionBox, degreeBox, toneBox]
        for box in boxes {
            let selections = box.getActiveButtonsInView()
            if !selections.isEmpty {
                if box == strengthBox {
                    returnValues.append("\(box.title): \(selections[0])/5")
                } else {
                    returnValues.append("\(box.title): \(selections.joined(separator: ", "))")
                }
            }
        }
        if ttpCheckbox.state == .on {
            returnValues.insert("tender to palpation", at: 0)
            //returnValues.append("tender to palpatation")
        }
        if !returnValues.isEmpty { mskResultsTextView.addToViewsExistingText("\(siteBox.getActiveButtonInView().capitalized) - \(returnValues.joined(separator: "; "))")
        }
        
        let gsSelections = generalStrengthBox.getButtonsInView()
        let actualSelections = gsSelections.filter { (50...60).contains($0.tag) && !$0.title.isEmpty}
        let titleList = actualSelections.map {$0.title}
        print(titleList)
        if !actualSelections.isEmpty {
            var uModifier = ""
            var lModifier = ""
            for selection in gsSelections where selection.state == .on {
                switch selection.tag {
                case 80, 81:
                    lModifier = selection.title
                case 85, 86:
                    uModifier = selection.title
                default:
                    uModifier = ""
                    lModifier = ""
                }
            }
            print("uMod = \(uModifier)\nlMod = \(lModifier)")
            for selection in actualSelections where !selection.title.isEmpty {
                print(selection.tag)
                switch selection.tag {
                case 50: generalValues.append("BLE: \(selection.title)\(lModifier)/5")
                case 51: generalValues.append("LLE: \(selection.title)\(lModifier)/5")
                case 52: generalValues.append("RLE: \(selection.title)\(lModifier)/5")
                case 55: generalValues.append("BUE: \(selection.title)\(uModifier)/5")
                case 56: generalValues.append("LUE: \(selection.title)\(uModifier)/5")
                case 57: generalValues.append("RUE: \(selection.title)\(uModifier)/5")
                default: continue
                }
            }
            mskResultsTextView.addToViewsExistingText("Extremity strength: \(generalValues.joined(separator: ", "))")
            
        }
    }
    
    func switchNorms(_ sender:NSButton) {
        
    }
}
