//
//  RadiologyVewController.swift
//  LIROS
//
//  Created by Fool on 10/19/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class RadRefViewController: NSViewController {
	@IBOutlet var radiologyView: NSView!
	//Radiology Interface
	@IBOutlet weak var radTypePopup: NSPopUpButton!
	@IBOutlet weak var radAreaPopup: NSPopUpButton!
	@IBOutlet weak var radSidePopup: NSPopUpButton!
	@IBOutlet weak var radReasonView: NSTextField!
	@IBOutlet weak var radOrders: NSTextField!
	
	//Referral Interface
	@IBOutlet weak var refAreaPopup: NSPopUpButton!
	@IBOutlet weak var refTypePopup: NSPopUpButton!
	@IBOutlet weak var refReasonView: NSTextField!
	@IBOutlet weak var refOrdersView: NSTextField!
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
	let nc = NotificationCenter.default
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		radTypePopup.clearPopUpButton(menuItems: radTypeChoices)
		radSidePopup.clearPopUpButton(menuItems: radEmptySide)
		radTypeSelected(radTypePopup)
		radAreaSelected(radAreaPopup)
		
		refAreaPopup.clearPopUpButton(menuItems: refAreaChoices)
		refTypePopup.clearPopUpButton(menuItems: radEmptySide)
		refAreaSelected(refAreaPopup)
    }
	
//	override func viewWillAppear() {
//		super.viewWillAppear()
//		print(self)
//		self.view.window?.makeFirstResponder(radTypePopup)
//		radTypePopup.becomeFirstResponder()
//	}
    
	@IBAction func radTypeSelected(_ sender: NSPopUpButton) {
		print("In the radTypeSelected func")
		switch sender.title {
		case "XRAY":
			radAreaPopup.clearPopUpButton(menuItems: radXRAYAreas)
		case "MRI":
			radAreaPopup.clearPopUpButton(menuItems: radMRIAreas)
		case "MRA":
			radAreaPopup.clearPopUpButton(menuItems: radMRAAreas)
		case "CT":
			radAreaPopup.clearPopUpButton(menuItems: radCTAreas)
		case "Ultrasound":
			radAreaPopup.clearPopUpButton(menuItems: radUSNDAreas)
		case "MAM":
			radAreaPopup.clearPopUpButton(menuItems: radMAMAreas)
		case "BMD":
			radAreaPopup.clearPopUpButton(menuItems: radBMDAreas)
		case "NUC":
			radAreaPopup.clearPopUpButton(menuItems: radNUCAreas)
		case "Neuro":
			radAreaPopup.clearPopUpButton(menuItems: radNeuroAreas)
		case "Resp":
			radAreaPopup.clearPopUpButton(menuItems: radRespAreas)
		case "GI":
			radAreaPopup.clearPopUpButton(menuItems: radGIAreas)
		case "Cardio":
			radAreaPopup.clearPopUpButton(menuItems: radCardioAreas)
		default:
			radAreaPopup.clearPopUpButton(menuItems: ["Selected rad type not recognized"])
		}
		radAreaSelected(radAreaPopup)
	}
	
	@IBAction func radAreaSelected(_ sender: NSPopUpButton) {
		switch radTypePopup.title {
		case "MRI":
			switch sender.title {
			case "brain", "chest", "orbits", "neck", "pelvis":
				radSidePopup.clearPopUpButton(menuItems: radContrast)
			case "spine":
				radSidePopup.clearPopUpButton(menuItems: radSpineSide)
			case "abdomen":
				radSidePopup.clearPopUpButton(menuItems: radMRIAbSides)
			case "extremity":
				radSidePopup.clearPopUpButton(menuItems: radExtremetiesContrast)
			default:
				radSidePopup.clearPopUpButton(menuItems: radEmptySide)
			}
		case "Ultrasound":
			switch sender.title {
			case "venous doppler", "arterial doppler":
				radSidePopup.clearPopUpButton(menuItems: radUSNDSidesDoppler)
			case "breast":
				radSidePopup.clearPopUpButton(menuItems: radRLBSides)
			default:
				radSidePopup.clearPopUpButton(menuItems: radEmptySide)
			}
		case "XRAY":
			switch sender.title {
			case "rib series", "shoulder series", "knee series with standing film", "hip", "femur", "tib fib", "ankle", "foot", "elbow", "wrist", "hand":
				radSidePopup.clearPopUpButton(menuItems: radRLBSides)
			case "spine":
				radSidePopup.clearPopUpButton(menuItems: radXraySpineSide)
			default:
				radSidePopup.clearPopUpButton(menuItems: radEmptySide)
			}
		case "MAM":
			switch sender.title {
			case "diagnostic":
				radSidePopup.clearPopUpButton(menuItems: radRLBSides)
			default:
				radSidePopup.clearPopUpButton(menuItems: radEmptySide)
			}
		case "CT":
			switch sender.title {
			case "chest", "orbits", "neck", "head":
				radSidePopup.clearPopUpButton(menuItems: radContrast)
			case "abdomen":
				radSidePopup.clearPopUpButton(menuItems: radCTAbSides)
			case "myelogram":
				radSidePopup.clearPopUpButton(menuItems: radSpineSide)
			case "extremity":
				radSidePopup.clearPopUpButton(menuItems: radExtremeties)
			default:
				radSidePopup.clearPopUpButton(menuItems: radEmptySide)
			}
		case "MRA":
			switch sender.title {
			case "brain":
				radSidePopup.clearPopUpButton(menuItems: radContrast)
			case "extremities":
				radSidePopup.clearPopUpButton(menuItems: radMRAExSides)
			default:
				radSidePopup.clearPopUpButton(menuItems: radEmptySide)
			}
		case "Resp":
			switch sender.title {
			case "sleep study":
				radSidePopup.clearPopUpButton(menuItems: radRespSleepSides)
			case "PFT":
				radSidePopup.clearPopUpButton(menuItems: radRespPFTSides)
			case "spirometry":
				radSidePopup.clearPopUpButton(menuItems: radRespSpiroSides)
			case "ABG":
				radSidePopup.clearPopUpButton(menuItems: radRespABGSides)
			default:
				radSidePopup.clearPopUpButton(menuItems: radEmptySide)
			}
		case "Cardio":
			switch sender.title {
			case "ECHO":
				radSidePopup.clearPopUpButton(menuItems: radCardioECHOSides)
			case "stress test":
				radSidePopup.clearPopUpButton(menuItems: radCardioSTSTSides)
			case "holter monitor":
				radSidePopup.clearPopUpButton(menuItems: radCardioHLTRSides)
			default:
				radSidePopup.clearPopUpButton(menuItems: radEmptySide)
			}
		default:
			radSidePopup.clearPopUpButton(menuItems: radEmptySide)
		}
	}
	
	
	@IBAction func addRadOrder(_ sender: Any) {
		guard let type = radTypePopup.titleOfSelectedItem else { return }
		guard let area = radAreaPopup.titleOfSelectedItem else { return }
		var existingRads = radOrders.stringValue
		if !existingRads.isEmpty {
			existingRads = existingRads + "\n"
		}
		var result = "\(existingRads)\(type) - \(area)"
		if let side = radSidePopup.titleOfSelectedItem {
			result += " \(side)"
		}
		if !radReasonView.stringValue.isEmpty {
			result += " for \(radReasonView.stringValue)"
		}
		
		radOrders.stringValue = result
		radReasonView.stringValue = ""
		
	}
	
	@IBAction func refAreaSelected(_ sender: NSPopUpButton) {
		switch refAreaPopup.title {
		case "Medical":
			refTypePopup.clearPopUpButton(menuItems: refMedChoices)
		case "Surgical":
			refTypePopup.clearPopUpButton(menuItems: refSurgChoices)
		case "Therapy/Ancillary":
			refTypePopup.clearPopUpButton(menuItems: refTherChoices)
		default:
			refTypePopup.clearPopUpButton(menuItems: radEmptySide)
		}
	}
	
	@IBAction func addRefOrder(_ sender: Any) {
		guard let type = refTypePopup.titleOfSelectedItem else { return }
		var existingRefs = refOrdersView.stringValue
		if !existingRefs.isEmpty {
			existingRefs = existingRefs + "\n"
		}
		var result = "\(existingRefs)\(type)"
		if !refReasonView.stringValue.isEmpty {
			result += " for \(refReasonView.stringValue)"
		}
		refOrdersView.stringValue = result
		refReasonView.stringValue = ""
	}
	
	
	@IBAction func processRadRef(_ sender: Any) {
		var finalResults = [String]()
		if !radOrders.stringValue.isEmpty {
			finalResults.append("Tests ordered:\n\(radOrders.stringValue)")
		}
		if !refOrdersView.stringValue.isEmpty {
			finalResults.append("Referrals made to:\n\(refOrdersView.stringValue)")
		}
		
        
        theData.plan.addToExistingText(finalResults.joined(separator: "\n"))
        
        let firstVC = presenting as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
		
	}
	
	
	@IBAction func clearRadRef(_ sender: Any) {
		radOrders.stringValue = ""
		refOrdersView.stringValue = ""
		radReasonView.stringValue = ""
		refReasonView.stringValue = ""
	}
}
