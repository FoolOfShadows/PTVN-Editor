//
//  CheckOutVC.swift
//  PTVN Editor
//
//  Created by Fool on 6/13/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

class CheckOutVC: NSViewController {
    @IBOutlet weak var demoView: NSTextField!
    @IBOutlet weak var notesScroll: NSScrollView!
    
    var notesView: NSTextView {
        get {
            return notesScroll.contentView.documentView as! NSTextView
        }
    }
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        demoView.stringValue = """
        \(theData.ptName)
        \(theData.ptDOB)
"""
notesView.string = prepDataForView()
    }
    
    @IBAction func printCheckOutReport(_ sender: Any) {
        let results = """
Whelchel Primary Care Medicine
Patient Visit Summary

\(demoView.stringValue)
        
\(notesView.string)
"""
        
        let printTextView = NSTextView()
        printTextView.setFrameSize(NSSize(width: 680, height: 0))
        printTextView.string = results
        printTextView.textStorage?.font = NSFont(name: "Times New Roman", size: 16)
        
        
        let myPrintInfo = NSPrintInfo.shared
        
        myPrintInfo.leftMargin = 40
        myPrintInfo.bottomMargin = 40
        myPrintInfo.isVerticallyCentered = false
        
        let myPrintOperation = NSPrintOperation(view: printTextView, printInfo: myPrintInfo)
        myPrintOperation.run()
        self.dismiss(self)
    }
    
    private func prepDataForView() -> String {
        var medValues = String()
        var refillValues = String()
        var radValues = String()
        
        if !theData.medicines.isEmpty {
            medValues = "Medications for this visit:\n\(theData.medicines)"
        }
        let refills = theData.plan.getLinesStartingWith("~~").joined(separator: "\n").cleanTheTextOf(["~~"])
        if !refills.isEmpty {
            refillValues = "Refills requested:\n\(refills)"
        }
        let refrad = theData.plan.getLinesStartingWith("••").joined(separator: "\n").cleanTheTextOf(["••"])
        if !refrad.isEmpty {
            radValues = "Referrals/Radiology being ordered:\n\(refrad)"
        }
        
        let values = [medValues, refillValues, radValues]
        let usedValues = values.filter { !$0.isEmpty }
        return usedValues.joined(separator: "\n\n")
    }
}
