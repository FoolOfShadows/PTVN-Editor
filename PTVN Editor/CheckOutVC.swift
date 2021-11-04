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
        let theUserFont:NSFont = NSFont.systemFont(ofSize: 16)
        let fontAttributes = NSDictionary(object: theUserFont, forKey: kCTFontAttributeName as! NSCopying)
        notesView.typingAttributes = fontAttributes as! [NSAttributedString.Key : Any]
        
        demoView.stringValue = """
\(theData.ptName)
        
Summary of your visit with Dr. Dawn Whelchel on \(theData.visitLongDate()).
"""
notesView.string = prepDataForView()
    }
    
    @IBAction func printCheckOutReport(_ sender: Any) {
        let results = """

\(demoView.stringValue)
        
\(notesView.string)
"""
        //FIXME: Need to print this to letterhead
        //FIXME: Will need to calculate the font size like in the LabLetter module
        let printTextView = NSTextView()
        printTextView.setFrameSize(NSSize(width: 680, height: 0))
        printTextView.textStorage?.font = NSFont(name: "Times New Roman", size: 14)
        printTextView.string = results
        
        
//        let myPrintInfo = NSPrintInfo.shared
//
//        myPrintInfo.leftMargin = 40
//        myPrintInfo.bottomMargin = 40
//        myPrintInfo.isVerticallyCentered = false
//
//        let myPrintOperation = NSPrintOperation(view: printTextView, printInfo: myPrintInfo)
//        myPrintOperation.run()
        printBlankPageWithText(printTextView.string, fontSize: 14, window: self.view.window!, andCloseWindow: false)
        //printLetterheadWithText(printTextView.string, fontSize: 14, window: self.view.window!, andCloseWindow: true, defaultCopies: 1)
    }
    
    private func prepDataForView() -> String {
        var medValues = String()
        var refillValues = String()
        var radValues = String()
        var assessmentValues = String()
        var vitalsValues = String()
        //var planValues = String()
        var changedMedValues = String()
        var followupValues = String()
        
        if !theData.medicines.isEmpty {
            medValues = theData.medicines.replacingOccurrences(of: "DISCONTINUED THIS VIST:", with: "Medications being discontinued at this visit:")
            medValues = "Medications active for this visit:\n\(medValues)"
        }
        let refills = theData.plan.getLinesStartingWith("~~").joined(separator: "\n").cleanTheTextOf(["~~", "»"])
        if !refills.isEmpty {
            refillValues = "Medications being prescribed/refilled this visit:\n(New medications will be called in within 4 hours of your visit, refills by the end of the day)\n\(refills)"
        }
        let refrad = theData.plan.getLinesStartingWith("••").joined(separator: "\n").cleanTheTextOf(["••", "»"])
        if !refrad.isEmpty {
            radValues = "Referrals/Radiology being ordered:\n(We will call you when the test or referral has been scheduled)\n\(refrad)"
        }
        var changedMeds = theData.plan.getLinesStartingWith("``")
        changedMeds += theData.plan.getLinesStartingWith("`~")
        if !changedMeds.isEmpty {
            changedMedValues = "Medications changed this visit:\n\(changedMeds.joined(separator: "\n").cleanTheTextOf(["``", "`~", "»"]))"
        }
        let assessment = theData.assessment.removeWhiteSpace()
        if !assessment.isEmpty {
            assessmentValues = "Active diagnoses this visit:\n\(assessment.replacingOccurrences(of: "Lvl", with: "Visit level"))"
        }
        let followup = theData.plan.getLinesStartingWith("`•")
        if !followup.isEmpty {
            followupValues = followup[0].cleanTheTextOf(["`•", "»"])
        }
        let objective = theData.objective
        //if !objective.isEmpty {
        let objectiveArray = objective.convertListToArray()
        for line in objectiveArray {
            if line.contains("T:") && line.contains("P:") {
                vitalsValues = "Vitals this visit:\n\(line)"
                break
            }
            //}
        }
        
//        let plan = theData.plan.removeWhiteSpace()
//        if !plan.isEmpty {
//            let badBits = ["Tests ordered:", "Referrals made to:", "••.*", "~~.*", "REFILLS REQUESTED:", "``", ]
//            let cleanPlan = plan.cleanTheTextOf(badBits)
//            planValues = cleanPlan
//        }
        
        let values = [refillValues, changedMedValues, radValues, vitalsValues, /*planValues,*/ assessmentValues, medValues, followupValues]
        let usedValues = values.filter { !$0.isEmpty }
        return usedValues.joined(separator: "\n\n")
    }
}
