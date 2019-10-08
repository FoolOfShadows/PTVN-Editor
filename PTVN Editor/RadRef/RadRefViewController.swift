//
//  RadiologyVewController.swift
//  LIROS
//
//  Created by Fool on 10/19/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class RadRefViewController: NSViewController, NSTextFieldDelegate, NSControlTextEditingDelegate {
	@IBOutlet var radiologyView: NSView!
    @IBOutlet weak var typeView: NSBox!
	@IBOutlet weak var reasonView: NSTextField!
	@IBOutlet weak var radScroll: NSScrollView!
    
    var radOrders: NSTextView {
        get {
            return radScroll.contentView.documentView as! NSTextView
        }
    }
    
    var areaBox = NSBox()
    var detailsBox = NSBox()
    
    let caseLists = enumLists()

    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    let defaultFont:NSFont = .systemFont(ofSize: 13)
	
	let nc = NotificationCenter.default
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reasonView.delegate = self
        
        //Set up the font settings for the text views
        let theUserFont:NSFont = NSFont.systemFont(ofSize: 18)
        let fontAttributes = NSDictionary(object: theUserFont, forKey: kCTFontAttributeName as! NSCopying)
        radOrders.typingAttributes = fontAttributes as! [NSAttributedString.Key : Any]

        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
		
    }
	
    /*override*/ func controlTextDidEndEditing(_ obj: Notification) {
        //Capture the tapped key, see if it's the Return key
        //and if it is, process all the data into the results field
        if let sendingKey = obj.userInfo?["NSTextMovement"] as? Int {
            if sendingKey == NSReturnTextMovement {
                addOrderToView(self)
            }
        }
    }
    
    @IBAction func setAreaSelections(_ sender:NSButton) {
        if sender.state == .on {
            clearAreaSideViews()
            if let buttons = sender.superview?.subviews {
                for button in buttons {
                    if (button as! NSButton).title != sender.title {
                        (button as! NSButton).state = .off
                    }
                }
            }
            var buttonList = [String]()
            switch sender.title {
            case "XRAY": buttonList = caseLists.xrayCases
            case "MRI": buttonList = caseLists.mriCases
            case "MAM": buttonList = caseLists.mamCases
            case "BMD": buttonList = caseLists.bmdCases
            case "USND": buttonList = caseLists.usndCases
            case "CT": buttonList = caseLists.ctCases
            case "MRA": buttonList = caseLists.mraCases
            case "Cardio": buttonList = caseLists.cardioCases
            case "GI": buttonList = caseLists.giCases
            case "Resp": buttonList = caseLists.respCases
            case "Neuro": buttonList = caseLists.neuroCases
            case "NUC": buttonList = caseLists.nucCases
            case "Med": buttonList = caseLists.refMedSide
            case "Surg": buttonList = caseLists.refSurgSide
            case "Ther": buttonList = caseLists.refTherSide
            default: return
            }
            areaBox.addButtonsToViewWithNames(buttonList, andSelector: #selector(setSideSelections))
            areaBox.setUpSectionBoxUsingTitle(title: "Area", font: defaultFont, referenceView: typeView, andButtonList: buttonList, inView: self.radiologyView, withHeightAdjustment: 17)
        } else if sender.state == .off {
            clearAreaSideViews()
        }
        
    }
    
    
    @objc func setSideSelections(_ sender:NSButton) {
        if sender.state == .on {
            detailsBox.subviews.forEach({ $0.removeFromSuperview() })
            detailsBox.removeFromSuperview()
            detailsBox = NSBox()
            if let buttons = sender.superview?.subviews {
                for button in buttons {
                    if (button as! NSButton).title != sender.title {
                        (button as! NSButton).state = .off
                    }
                }
            }
            var buttonList = [String]()
            switch sender.title {
            //Basic sides
            case radXRAYAreas.ribs.rawValue, radXRAYAreas.kneeStanding.rawValue, radXRAYAreas.hip.rawValue, radXRAYAreas.femur.rawValue, radXRAYAreas.tibFib.rawValue, radXRAYAreas.ankle.rawValue, radXRAYAreas.foot.rawValue, radXRAYAreas.shoulder.rawValue, radXRAYAreas.elbow.rawValue, radXRAYAreas.wrist.rawValue, radXRAYAreas.hand.rawValue, radMAMAreas.diagnostic.rawValue, radUSNDAreas.breast.rawValue:
                buttonList = caseLists.radRLBSide
            case radXRAYAreas.spine.rawValue:
                buttonList = caseLists.spineSide + caseLists.xraySpineSide
            case radUSNDAreas.vDoppler.rawValue, radUSNDAreas.aDoppler.rawValue:
                buttonList = caseLists.radUSNDDopplerSide
            //Contrast
            case radCTAreas.head.rawValue, radCTAreas.chest.rawValue, radCTAreas.orbits.rawValue, radMRIAreas.brain.rawValue, radMRIAreas.pelvis.rawValue, radMRIAreas.chest.rawValue, radMRIAreas.orbits.rawValue, radMRAAreas.brain.rawValue:
                buttonList = caseLists.contrast
            case radCTAreas.abdomen.rawValue:
                buttonList = caseLists.radCTAbSide
            case radCTAreas.extremity.rawValue:
                buttonList = caseLists.radExtremitySide
            case radCTAreas.myelogram.rawValue, radMRIAreas.spine.rawValue:
                buttonList = caseLists.spineSide
            case radMRIAreas.extremity.rawValue:
                buttonList = caseLists.radExtremityContrastSide
            case radMRIAreas.abdomen.rawValue:
                buttonList = caseLists.radMRIAbSide
            case radMRAAreas.extremities.rawValue:
                buttonList = caseLists.radMRAExtremitySide
            case radCardioAreas.ECHO.rawValue:
                buttonList = caseLists.radECHOSide
            case radCardioAreas.stressTest.rawValue:
                buttonList = caseLists.radSTSTSide
            case radCardioAreas.holter.rawValue:
                buttonList = caseLists.radHLTRSide
            case radRespAreas.sleep.rawValue:
                buttonList = caseLists.radSleepSide
            case radRespAreas.PFT.rawValue:
                buttonList = caseLists.radPFTSide
            case radRespAreas.spirometry.rawValue:
                buttonList = caseLists.radSpiroSide
            case radRespAreas.ABG.rawValue:
                buttonList = caseLists.radABGside

            default:
                return
            }
            detailsBox.addButtonsToViewWithNames(buttonList, andSelector: nil)
            detailsBox.setUpSectionBoxUsingTitle(title: "Details", font: defaultFont, referenceView: areaBox, andButtonList: buttonList, inView: self.radiologyView, withHeightAdjustment: 17)
        } else if sender.state == .off {
            detailsBox.subviews.forEach({ $0.removeFromSuperview() })
        }
    }
	
	
	@IBAction func addOrderToView(_ sender: Any) {
        var returnValues = [String]()
        returnValues.append(typeView.getActiveButtonInView())
        returnValues.append(areaBox.getActiveButtonInView())
        returnValues.append(detailsBox.getActiveButtonInView())
        if !reasonView.stringValue.isEmpty {
            returnValues.append(reasonView.stringValue)
        }
        radOrders.addToViewsExistingText(returnValues.filter {$0 != "" }.joined(separator: " - "))
        clearAreaSideViews()
        typeView.turnButtonsInViewOff()
	}
	

	

	
	
	@IBAction func processRadRef(_ sender: Any) {
		var finalResults = [String]()
        
        //Check to see if there are uncommitted selections, and add them to the radOrders field
        if !areaBox.getActiveButtonInView().isEmpty {
            addOrderToView(self)
        }
        
        let resultsArray = radOrders.string.components(separatedBy: "\n")
        //print(resultsArray)
        let radResults = resultsArray.filter { !$0.contains("Med") && !$0.contains("Surg") && !$0.contains("Ther") }
        let refResults = resultsArray.filter { $0.contains("Med") || $0.contains("Surg") || $0.contains("Ther") }
        //print(refResults)
        print("Rad results contains:\n\(radResults)")
		if !radResults.isEmpty && radResults != [""] {
			finalResults.append("Tests ordered:\n\(radResults.joined(separator: "\n").addCharacterToBeginningOfEachLine("••"))")
		}
        if !refResults.isEmpty {
            finalResults.append("Referrals made to:\n\(refResults.joined(separator: "\n").cleanTheTextOf(["Med - ", "Surg - ", "Ther - "]).addCharacterToBeginningOfEachLine("••"))")
        }
		
        //print(finalResults)
        theData.plan.addToExistingText(finalResults.joined(separator: "\n"))
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        //I don't know why I added this, but I dont' seem to need it
        //firstVC.view.window?.isDocumentEdited = true
        self.dismiss(self)
		
	}
	
    private func clearAreaSideViews() {
        radiologyView.subviews.forEach({ if let theSub = $0 as? NSBox {
            if theSub.title != "Test/Ref" {
                $0.removeFromSuperview()
            }
            }
            
        })
//        areaBox.subviews.forEach({ $0.removeFromSuperview() })
//        detailsBox.subviews.forEach({ $0.removeFromSuperview() })
        reasonView.stringValue = ""
        
        areaBox = NSBox()
        detailsBox = NSBox()
    }
    
	@IBAction func clearRadRef(_ sender: Any) {
        clearAreaSideViews()
        typeView.turnButtonsInViewOff()
		radOrders.string = ""
		reasonView.stringValue = ""
	}
}
