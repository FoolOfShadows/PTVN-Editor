//
//  PreventiveController.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 8/17/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

class PreventiveController: NSViewController {
	
	@IBOutlet weak var winPrint: NSWindow!
	//@IBOutlet var printTextView: NSTextView!
	
	
	@IBOutlet weak var pnvTextView: NSTextField!
	@IBOutlet weak var pnvNotDue: NSButton!
	@IBOutlet weak var fluTextView: NSTextField!
	@IBOutlet weak var fluNotDue: NSButton!
	@IBOutlet weak var hepBTextView: NSTextField!
	@IBOutlet weak var hepBNotDue: NSButton!
	@IBOutlet weak var mamTextView: NSTextField!
	@IBOutlet weak var mamNotDue: NSButton!
	@IBOutlet weak var papTextView: NSTextField!
	@IBOutlet weak var papNotDue: NSButton!
	@IBOutlet weak var dreTextView: NSTextField!
	@IBOutlet weak var dreNotDue: NSButton!
	@IBOutlet weak var psaTextView: NSTextField!
	@IBOutlet weak var psaNotDue: NSButton!
	@IBOutlet weak var guaTextView: NSTextField!
	@IBOutlet weak var guaNotDue: NSButton!
	@IBOutlet weak var flexSigTextView: NSTextField!
	@IBOutlet weak var flexSigNotDue: NSButton!
	@IBOutlet weak var clnTextView: NSTextField!
	@IBOutlet weak var clnNotDue: NSButton!
	@IBOutlet weak var enemaTextView: NSTextField!
	@IBOutlet weak var enemaNotDue: NSButton!
	@IBOutlet weak var diabetesTrainingTextView: NSTextField!
	@IBOutlet weak var diabetesTrainingNotDue: NSButton!
	@IBOutlet weak var bmdTextView: NSTextField!
	@IBOutlet weak var bmdNotDue: NSButton!
	@IBOutlet weak var glaucomaTextView: NSTextField!
	@IBOutlet weak var glaucomaNotDue: NSButton!
	@IBOutlet weak var nutritionTherapyTextView: NSTextField!
	@IBOutlet weak var nutritionTherapyNotDue: NSButton!
	@IBOutlet weak var cholesterolTextView: NSTextField!
	@IBOutlet weak var cholesterolNotDue: NSButton!
	@IBOutlet weak var hdlTextView: NSTextField!
	@IBOutlet weak var hdlNotDue: NSButton!
	@IBOutlet weak var triglyceridesTextView: NSTextField!
	@IBOutlet weak var triglyceridesNotDue: NSButton!
	@IBOutlet weak var glucoseToleranceTextView: NSTextField!
	@IBOutlet weak var glucoseToleranceNotDue: NSButton!
	@IBOutlet weak var abUSNDTextView: NSTextField!
	@IBOutlet weak var abUSNDNotDue: NSButton!
	@IBOutlet weak var hivTextView: NSTextField!
	@IBOutlet weak var hivNotDue: NSButton!
	@IBOutlet weak var nextMWVTextView: NSTextField!
	
    //@IBOutlet var previousPrevView: NSTextView!
    @IBOutlet weak var previousPrevScroll: NSScrollView!
    var previousPrevView: NSTextView {
        get {
            return previousPrevScroll.contentView.documentView as! NSTextView
        }
    }
    
	
	
	var measures = [PreventiveMeasure]()
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let pnvMeasure = PreventiveMeasure(measure: "Pneumococcal vaccination", date: pnvTextView, notDue: pnvNotDue)
        let fluMeasure = PreventiveMeasure(measure: "Influenza vaccination", date: fluTextView, notDue: fluNotDue)
        let hepBMeasure = PreventiveMeasure(measure: "Hepatitis B vaccination", date: hepBTextView, notDue: hepBNotDue)
        let mamMeasure = PreventiveMeasure(measure: "Mammogram", date: mamTextView, notDue: mamNotDue)
        let papMeasure = PreventiveMeasure(measure: "PAP smear", date: papTextView, notDue: papNotDue)
        let dreMeasure = PreventiveMeasure(measure: "Digital rectal exam", date: dreTextView, notDue: dreNotDue)
        let psaMeasure = PreventiveMeasure(measure: "PSA lab", date: psaTextView, notDue: psaNotDue)
        let guaMeasure = PreventiveMeasure(measure: "Stool occult blood test", date: guaTextView, notDue: guaNotDue)
        let flexSigMeasure = PreventiveMeasure(measure: "Flexible sigmoidoscopy exam", date: flexSigTextView, notDue: flexSigNotDue)
        let clnMeasure = PreventiveMeasure(measure: "Screening colonoscopy", date: clnTextView, notDue: clnNotDue)
        let enemaMeasure = PreventiveMeasure(measure: "Barium enema", date: enemaTextView, notDue: enemaNotDue)
        let diabetesTrainingMeasure = PreventiveMeasure(measure: "Diabetes self-management training", date: diabetesTrainingTextView, notDue: diabetesTrainingNotDue)
        let bmdMeasure = PreventiveMeasure(measure: "Bone mineral density test", date: bmdTextView, notDue: bmdNotDue)
        let glaucomaMeasure = PreventiveMeasure(measure: "Glaucoma exam", date: glaucomaTextView, notDue: glaucomaNotDue)
        let nutritionTherapyMeasure = PreventiveMeasure(measure: "Medical nutrition therapy for diabetes or renal disease", date: nutritionTherapyTextView, notDue: nutritionTherapyNotDue)
        let cholesterolMeasure = PreventiveMeasure(measure: "Total cholesterol lab", date: cholesterolTextView, notDue: cholesterolNotDue)
        let hdlMeasure = PreventiveMeasure(measure: "HDL lab", date: hdlTextView, notDue: hdlNotDue)
        let triglyceridesMeasure = PreventiveMeasure(measure: "Triglycerides lab", date: triglyceridesTextView, notDue: triglyceridesNotDue)
        let glucoseToleranceMeasure = PreventiveMeasure(measure: "Glucose tolerance test", date: glucoseToleranceTextView, notDue: glucoseToleranceNotDue)
        let abUSNDMeasure = PreventiveMeasure(measure: "Abdominal aortic aneurysm screening", date: abUSNDTextView, notDue: abUSNDNotDue)
        let hivMeasure = PreventiveMeasure(measure: "HIV screening", date: hivTextView, notDue: hivNotDue)
        measures = [pnvMeasure, fluMeasure, hepBMeasure, mamMeasure, papMeasure, dreMeasure, psaMeasure, guaMeasure, flexSigMeasure, clnMeasure, enemaMeasure, diabetesTrainingMeasure, bmdMeasure, glaucomaMeasure, nutritionTherapyMeasure, cholesterolMeasure, hdlMeasure, triglyceridesMeasure, glucoseToleranceMeasure, abUSNDMeasure, hivMeasure]
        setFontSizeOf(16, forFields: [previousPrevView])
        //previousPrevView.textStorage?.font = NSFont(name: "Times New Roman", size: 16)
        previousPrevView.string = getPrevDataFrom(theData.preventive)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }
	
	func prepareMeasures() -> String {
		var results = processMeasures(measures: measures)
		if !nextMWVTextView.stringValue.isEmpty {
			if !results.isEmpty {
				results += "\n"
			}
			results += "Next Medicare Wellness Exam due after: \(nextMWVTextView.stringValue)"
		}
		return results
	}
	
	@IBAction func processPreventiveMeasures(_ sender: NSButton) {
		let results = prepareMeasures()
		if !results.isEmpty {
            theData.plan.addToExistingText(results)
            
            let firstVC = presentingViewController as! ViewController
            firstVC.theData = theData
            currentPTVNDelegate?.returnPTVNValues(sender: self)
            self.dismiss(self)
		}
	}
	
	@IBAction func processClear(_ sender: AnyObject) {
		processClearMeasures(measures: measures)
		nextMWVTextView.stringValue = String()
	}

	
	
	@IBAction func takePrintMeasures(_ sender: AnyObject) {
		var results = prepareMeasures()
		if !results.isEmpty {
            let pasteBoard = NSPasteboard.general
			pasteBoard.clearContents()
            pasteBoard.setString(results, forType: NSPasteboard.PasteboardType.string)
			//Swift.print(results)
		}
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/dd/YYYY"
		let currentDate = dateFormatter.string(from: Date())
		
		results = "Medicare Wellness Visit\nVisit Date:\(currentDate)\n\n\(theData.ptName)\n\n\(results)"
		
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
	}
	
}
