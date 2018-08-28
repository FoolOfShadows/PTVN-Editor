//
//  ProcInjViewController.swift
//  LIROS
//
//  Created by Fool on 12/7/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class ProcInjViewController: NSViewController, NSTextFieldDelegate {
	
	@IBOutlet var procInjTabView: NSView!
	@IBOutlet weak var injectionsBox: NSBox!
	@IBOutlet weak var proceduresBox: NSBox!
	@IBOutlet weak var labBox: NSBox!
	@IBOutlet weak var abiBox: NSBox!
	
	//Procedures
	@IBOutlet weak var earLavagePopup: NSPopUpButton!
	@IBOutlet weak var nebulizerPopup: NSPopUpButton!
	
	
    //ABI
    @IBOutlet weak var lSysAnkleView: NSTextField!
    @IBOutlet weak var lDiaAnkleView: NSTextField!
    @IBOutlet weak var lAnklePulseView: NSTextField!
    @IBOutlet weak var lSysBrachView: NSTextField!
    @IBOutlet weak var lDiaBrachView: NSTextField!
    @IBOutlet weak var lBrachPulseView: NSTextField!
    @IBOutlet weak var lABIIndexView: NSTextField!
    @IBOutlet weak var rSysAnkleView: NSTextField!
    @IBOutlet weak var rDiaAnkleView: NSTextField!
    @IBOutlet weak var rAnklePulseView: NSTextField!
    @IBOutlet weak var rSysBrachView: NSTextField!
    @IBOutlet weak var rDiaBrachView: NSTextField!
    @IBOutlet weak var rBrachPulseView: NSTextField!
    @IBOutlet weak var rABIIndexView: NSTextField!
	
	@IBOutlet var samplesView: NSTextView!
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
	let nc = NotificationCenter.default
	
    override func viewDidLoad() {
        super.viewDidLoad()
		clearProcInjTab(self)
		lSysAnkleView.delegate = self
		lSysBrachView.delegate = self
		rSysAnkleView.delegate = self
		rSysBrachView.delegate = self
    }
	
	override func controlTextDidChange(_ obj: Notification) {
		if let lAnkle = Double(lSysAnkleView.stringValue), let lBrach = Double(lSysBrachView.stringValue) {
			lABIIndexView.stringValue = String(format: "%.2f", lAnkle/lBrach)
		}
		if let rAnkle = Double(rSysAnkleView.stringValue), let rBrach = Double(rSysBrachView.stringValue) {
			rABIIndexView.stringValue = String(format: "%.2f", rAnkle/rBrach)
		}
	}
	
	func setUpMenuItemsForButtonsIn(_ view: NSView) {
		for item in view.subviews {
			if item is NSPopUpButton {
				(item as! NSPopUpButton).clearPopUpButton(menuItems: ProcInjModel().getListItemsForID(item.tag))
			} else if item is NSComboBox {
				(item as! NSComboBox).clearComboBox(menuItems: ProcInjModel().getListItemsForID(item.tag))
			} else {
				setUpMenuItemsForButtonsIn(item)
			}
		}
	}
    
	@IBAction func clearProcInjTab(_ sender: Any) {
		procInjTabView.clearControllers()
		earLavagePopup.clearPopUpButton(menuItems: ProcInjModel().earLavageList)
		nebulizerPopup.clearPopUpButton(menuItems: ProcInjModel().nebulizerList)
		setUpMenuItemsForButtonsIn(injectionsBox)
	}
	
    @IBAction func processProcInjTab(_ sender: Any) {
        var finalResults = [String]()
        finalResults.append(ProcInjModel().processOfficeProceduresUsing(getButtonsIn(view: proceduresBox)))
        finalResults.append(ProcInjModel().processInjectionsUsing(getButtonsIn(view: injectionsBox)))
        finalResults.append(ProcInjModel().processLabsOrderedUsing(getButtonsIn(view: labBox)))
        //finalResults.append(ProcInjModel().processABIResults(left: lABIIndexView.stringValue, right: rABIIndexView.stringValue))
        if !samplesView.string.isEmpty {
            finalResults.append("Samples given:\n\(samplesView.string)")
        }
        
		
		
		
		let filteredResults = finalResults.filter {!$0.isEmpty}
		
        theData.plan.addToExistingText(filteredResults.joined(separator: "\n"))
        if !processABI().isEmpty {
            theData.objective.addToExistingText(processABI())
        }
        
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
	}
    
    func processABI() -> String {
        var resultsArray = [String]()
        var leftResults = [String]()
        var rightResults = [String]()
        var results = String()
        
        if !lSysAnkleView.stringValue.isEmpty && !lDiaAnkleView.stringValue.isEmpty && !lAnklePulseView.stringValue.isEmpty {
            leftResults.append("BP L Leg: \(lSysAnkleView.stringValue)/\(lDiaAnkleView.stringValue), P \(lAnklePulseView.stringValue)")
        }
        if !lSysBrachView.stringValue.isEmpty && !lDiaBrachView.stringValue.isEmpty && !lBrachPulseView.stringValue.isEmpty {
            leftResults.append("BP L Arm: \(lSysBrachView.stringValue)/\(lDiaBrachView.stringValue), P \(lBrachPulseView.stringValue)")
        }
        if !lABIIndexView.stringValue.isEmpty {
            leftResults.append("Ankle Brachial Index = \(lABIIndexView.stringValue)")
        }
        if !leftResults.isEmpty {
            resultsArray.append("Left: \(leftResults.joined(separator: "; "))")
        }
        
        if !rSysAnkleView.stringValue.isEmpty && !rDiaAnkleView.stringValue.isEmpty && !rAnklePulseView.stringValue.isEmpty {
            rightResults.append("BP R Leg: \(rSysAnkleView.stringValue)/\(rDiaAnkleView.stringValue), P \(rAnklePulseView.stringValue)")
        }
        if !rSysBrachView.stringValue.isEmpty && !rDiaBrachView.stringValue.isEmpty && !rBrachPulseView.stringValue.isEmpty {
            rightResults.append("BP R Arm: \(rSysBrachView.stringValue)/\(rDiaBrachView.stringValue), P \(rBrachPulseView.stringValue)")
        }
        if !rABIIndexView.stringValue.isEmpty {
            rightResults.append("Ankle Brachial Index = \(rABIIndexView.stringValue)")
        }
        if !rightResults.isEmpty {
            resultsArray.append("Right: \(rightResults.joined(separator: "; "))")
        }
        
        if !resultsArray.isEmpty {
            results = "Ankle Brachial Indexes:\n\(resultsArray.joined(separator: "\n"))"
        }
        
        return results
    }
}
