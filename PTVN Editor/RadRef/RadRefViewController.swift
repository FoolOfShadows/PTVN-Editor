//
//  RadiologyVewController.swift
//  LIROS
//
//  Created by Fool on 10/19/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class RadRefViewController: NSViewController, NSTextFieldDelegate {
	@IBOutlet var radiologyView: NSView!
    @IBOutlet weak var typeView: NSView!
    @IBOutlet weak var areaView: NSView!
    @IBOutlet weak var sideView: NSView!
	@IBOutlet weak var reasonView: NSTextField!
	@IBOutlet weak var radScroll: NSScrollView!
    
    var radOrders: NSTextView {
        get {
            return radScroll.contentView.documentView as! NSTextView
        }
    }
    
    let caseLists = enumLists()

    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
	let nc = NotificationCenter.default
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reasonView.delegate = self
		
    }
	
    override func controlTextDidEndEditing(_ obj: Notification) {
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
            switch sender.title {
            case "XRAY": areaView.addButtonsToViewWithNames(caseLists.xrayCases, andSelector: #selector(setSideSelections))
            case "MRI": areaView.addButtonsToViewWithNames(caseLists.mriCases, andSelector: #selector(setSideSelections))
            case "MAM": areaView.addButtonsToViewWithNames(caseLists.mamCases, andSelector: #selector(setSideSelections))
            case "BMD": areaView.addButtonsToViewWithNames(caseLists.bmdCases, andSelector: #selector(setSideSelections))
            case "USND": areaView.addButtonsToViewWithNames(caseLists.usndCases, andSelector: #selector(setSideSelections))
            case "CT": areaView.addButtonsToViewWithNames(caseLists.ctCases, andSelector: #selector(setSideSelections))
            case "MRA": areaView.addButtonsToViewWithNames(caseLists.mraCases, andSelector: #selector(setSideSelections))
            case "Cardio": areaView.addButtonsToViewWithNames(caseLists.cardioCases, andSelector: #selector(setSideSelections))
            case "GI": areaView.addButtonsToViewWithNames(caseLists.giCases, andSelector: #selector(setSideSelections))
            case "Resp": areaView.addButtonsToViewWithNames(caseLists.respCases, andSelector: #selector(setSideSelections))
            case "Neuro": areaView.addButtonsToViewWithNames(caseLists.neuroCases, andSelector: #selector(setSideSelections))
            case "NUC": areaView.addButtonsToViewWithNames(caseLists.nucCases, andSelector: #selector(setSideSelections))
            case "Med": areaView.addButtonsToViewWithNames(caseLists.refMedSide, andSelector: #selector(setSideSelections))
            case "Surg": areaView.addButtonsToViewWithNames(caseLists.refSurgSide, andSelector: #selector(setSideSelections))
            case "Ther": areaView.addButtonsToViewWithNames(caseLists.refTherSide, andSelector: #selector(setSideSelections))
            default: return
            }
        } else if sender.state == .off {
            clearAreaSideViews()
        }
        
    }
    
    @objc func setSideSelections(_ sender:NSButton) {
        if sender.state == .on {
            sideView.subviews.forEach({ $0.removeFromSuperview() })
            if let buttons = sender.superview?.subviews {
                for button in buttons {
                    if (button as! NSButton).title != sender.title {
                        (button as! NSButton).state = .off
                    }
                }
            }
            switch sender.title {
            //Basic sides
            case radXRAYAreas.ribs.rawValue, radXRAYAreas.kneeStanding.rawValue, radXRAYAreas.hip.rawValue, radXRAYAreas.femur.rawValue, radXRAYAreas.tibFib.rawValue, radXRAYAreas.ankle.rawValue, radXRAYAreas.foot.rawValue, radXRAYAreas.shoulder.rawValue, radXRAYAreas.elbow.rawValue, radXRAYAreas.wrist.rawValue, radXRAYAreas.hand.rawValue, radMAMAreas.diagnostic.rawValue, radUSNDAreas.breast.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radRLBSide, andSelector: nil)
            case radXRAYAreas.spine.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.spineSide + caseLists.xraySpineSide, andSelector: nil)
            case radUSNDAreas.vDoppler.rawValue, radUSNDAreas.aDoppler.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radUSNDDopplerSide, andSelector: nil)
            //Contrast
            case radCTAreas.head.rawValue, radCTAreas.chest.rawValue, radCTAreas.orbits.rawValue, radMRIAreas.brain.rawValue, radMRIAreas.pelvis.rawValue, radMRIAreas.chest.rawValue, radMRIAreas.orbits.rawValue, radMRAAreas.brain.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.contrast, andSelector: nil)
            case radCTAreas.abdomen.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radCTAbSide, andSelector: nil)
            case radCTAreas.extremity.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radExtremitySide, andSelector: nil)
            case radCTAreas.myelogram.rawValue, radMRIAreas.spine.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.spineSide, andSelector: nil)
            case radMRIAreas.extremity.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radExtremityContrastSide, andSelector: nil)
            case radMRIAreas.abdomen.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radMRIAbSide, andSelector: nil)
            case radMRAAreas.extremities.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radMRAExtremitySide, andSelector: nil)
            case radCardioAreas.ECHO.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radECHOSide, andSelector: nil)
            case radCardioAreas.stressTest.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radSTSTSide, andSelector: nil)
            case radCardioAreas.holter.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radHLTRSide, andSelector: nil)
            case radRespAreas.sleep.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radSleepSide, andSelector: nil)
            case radRespAreas.PFT.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radPFTSide, andSelector: nil)
            case radRespAreas.spirometry.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radSpiroSide, andSelector: nil)
            case radRespAreas.ABG.rawValue:
                sideView.addButtonsToViewWithNames(caseLists.radABGside, andSelector: nil)
                
            default:
                return
            }
        } else if sender.state == .off {
            sideView.subviews.forEach({ $0.removeFromSuperview() })
        }
    }
	
	
	@IBAction func addOrderToView(_ sender: Any) {
        var returnValues = [String]()
        returnValues.append(typeView.getActiveButtonInView())
        returnValues.append(areaView.getActiveButtonInView())
        returnValues.append(sideView.getActiveButtonInView())
        if !reasonView.stringValue.isEmpty {
            returnValues.append(reasonView.stringValue)
        }
        radOrders.addToViewsExistingText(returnValues.filter {$0 != "" }.joined(separator: " - "))
	}
	

	

	
	
	@IBAction func processRadRef(_ sender: Any) {
		var finalResults = [String]()
        let resultsArray = radOrders.string.components(separatedBy: "\n")
        print(resultsArray)
        let radResults = resultsArray.filter { !$0.contains("Med") && !$0.contains("Surg") && !$0.contains("Ther") }
        let refResults = resultsArray.filter { $0.contains("Med") || $0.contains("Surg") || $0.contains("Ther") }
        print(refResults)
		if !radResults.isEmpty {
			finalResults.append("Tests ordered:\n\(radResults.joined(separator: "\n").addCharacterToBeginningOfEachLine("••"))")
		}
        if !refResults.isEmpty {
            finalResults.append("Referrals made to:\n\(refResults.joined(separator: "\n").cleanTheTextOf(["Med - ", "Surg - ", "Ther - "]).addCharacterToBeginningOfEachLine("••"))")
        }
		
        //print(finalResults)
        theData.plan.addToExistingText(finalResults.joined(separator: "\n"))
        
        let firstVC = presenting as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        //I don't know why I added this, but I dont' seem to need it
        //firstVC.view.window?.isDocumentEdited = true
        self.dismiss(self)
		
	}
	
    func clearAreaSideViews() {
        areaView.subviews.forEach({ $0.removeFromSuperview() })
        sideView.subviews.forEach({ $0.removeFromSuperview() })
        reasonView.stringValue = ""
    }
    
	@IBAction func clearRadRef(_ sender: Any) {
        clearAreaSideViews()
        typeView.turnButtonsInViewOff()
		radOrders.string = ""
		reasonView.stringValue = ""
	}
}
