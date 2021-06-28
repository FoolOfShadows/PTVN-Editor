//
//  PreventiveController.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 8/17/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa


class PreventiveController: NSViewController, NSTextFieldDelegate, NSControlTextEditingDelegate {
	
	@IBOutlet weak var winPrint: NSWindow!

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
	
    @IBOutlet var previousPrevView: NSTextView!

    @IBOutlet weak var previousPrevScroll: NSScrollView!
//    var previousPrevView: NSTextView {
//        get {
//            return previousPrevScroll.contentView.documentView as! NSTextView
//        }
//    }
    var controllers = [NSControl]()
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    var trackedData = TrackedMeasures(source: "")
    
    let dateFormatter = DateFormatter()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        controllers = [pnvTextView, pnvNotDue, fluTextView, fluNotDue, hepBTextView, hepBNotDue, mamTextView, mamNotDue, papTextView, papNotDue, dreTextView, dreNotDue, psaTextView, psaNotDue, guaTextView, guaNotDue, flexSigTextView, flexSigNotDue, clnTextView, clnNotDue, enemaTextView, enemaNotDue, diabetesTrainingTextView, diabetesTrainingNotDue, bmdTextView, bmdNotDue, glaucomaTextView, glaucomaNotDue, nutritionTherapyTextView, nutritionTherapyNotDue, cholesterolTextView, cholesterolNotDue, hdlTextView, hdlNotDue, triglyceridesTextView, triglyceridesNotDue, glucoseToleranceTextView, glucoseToleranceNotDue, abUSNDTextView, abUSNDNotDue, hivTextView, hivNotDue]
        for controller in controllers {
            if let textController = controller as? NSTextField {
                textController.delegate = self
            }
        }
        setFontSizeOf(16, forFields: [previousPrevView])
        //previousPrevView.textStorage?.font = NSFont(name: "Times New Roman", size: 16)
        previousPrevView.string = getPrevDataFrom(theData.preventive)
        trackedData = TrackedMeasures(source: theData.preventive)
        pnvTextView.stringValue = trackedData.tmPNV
        fluTextView.stringValue = trackedData.tmFLU
        mamTextView.stringValue = trackedData.tmMGM
        papTextView.stringValue = trackedData.tmPAP
        clnTextView.stringValue = trackedData.tmCOLO
        dreTextView.stringValue = trackedData.tmDRE
        bmdTextView.stringValue = trackedData.tmBMD
        glaucomaTextView.stringValue = trackedData.tmEYE
        hivTextView.stringValue = trackedData.tmHIV
        if let oneYear = Date().addingDays(366) {
            nextMWVTextView.stringValue = "Next AWV should be \(dateFormatter.string(from: oneYear)) or later"
        } else {
            nextMWVTextView.stringValue = "Unable to calculate next visit date."
        }
        
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }
    
    func controlTextDidChange(_ obj: Notification) {
        print("changing text")
        guard let theTextField = obj.object as? NSTextField else { return }
        
        let tfTag = theTextField.tag
        for controller in controllers {
            if let matchingCheckBox = controller as? NSButton {
                if matchingCheckBox.tag == tfTag {
                    matchingCheckBox.state = .off
                }
            }
        }
    }
	
	@IBAction func processPreventiveMeasures(_ sender: NSButton) {
		let results = prepPrenventiveMeasures()
        
		if !results.isEmpty {
            theData.plan.addToExistingText(results)
            
            let firstVC = presentingViewController as! ViewController
            firstVC.theData = theData
            currentPTVNDelegate?.returnPTVNValues(sender: self)
            self.dismiss(self)
		}
	}
    
    func prepPrenventiveMeasures() -> String {
        var results = String()
        var resultMeasures = [String]()
        
        for controller in controllers {
            if let converted = controller as? NSTextField {
                if !converted.stringValue.isEmpty {
                    resultMeasures.append(putTogetherData(tag: converted.tag, value: "due \(converted.stringValue)"))
                }
            } else if let converted = controller as? NSButton {
                if converted.state.rawValue == 1 {
                    resultMeasures.append(putTogetherData(tag: converted.tag, value: "not due"))
                }
            }
        }
        if !resultMeasures.isEmpty {
            results = resultMeasures.joined(separator: "\n")
        }
        return results
    }
    
    func putTogetherData(tag: Int, value: String) -> String {
        switch tag {
        case 1: return "Pneumococcal vaccination \(value)."
        case 2: return "Influenza vaccination \(value)."
        case 3: return "Hepatitis B vaccination \(value)."
        case 4: return "Mammogram \(value)."
        case 5: return "PAP smear \(value)."
        case 6: return "Bone mineral density \(value)."
        case 7: return "Digital rectal exam \(value)."
        case 8: return "Prostate specific antigen (PSA) \(value)."
        case 9: return "Stool blood screening \(value)."
        case 10: return "Flexible sigmoidoscopy \(value)."
        case 11: return "Screening colonoscopy \(value)."
        case 12: return "Barium enema \(value)."
        case 13: return "Aortic aneurysm sonogram screening \(value)."
        case 14: return "Glaucoma screening \(value)."
        case 15: return "Diabetic self-management training \(value)."
        case 16: return "Medical nutrition therapy \(value)."
        case 17: return "Total cholestroal (HDL) \(value)."
        case 18: return "High density lipids (HDL) \(value)."
        case 19: return "Triglycerides \(value)."
        case 20: return "Fasting blood sugar/glucose tolerance test \(value)."
        case 21: return "HIV screening \(value)."
        default:
            return "No usable values found"
        }
    }
	
	@IBAction func processClear(_ sender: AnyObject) {
//		processClearMeasures(measures: measures)
//		nextMWVTextView.stringValue = String()
	}

	
	
	@IBAction func takePrintMeasures(_ sender: AnyObject) {
		var results = prepPrenventiveMeasures()
		if !results.isEmpty {
            let pasteBoard = NSPasteboard.general
			pasteBoard.clearContents()
            pasteBoard.setString(results, forType: NSPasteboard.PasteboardType.string)
			//Swift.print(results)
		}
		
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
    
    @IBAction func updateCheckBoxValue(_ sender: NSButton) {
        if sender.state == .on {
            let tfTag = sender.tag
            for controller in controllers {
                if let matchingTextField = controller as? NSTextField {
                    if matchingTextField.tag == tfTag {
                        matchingTextField.stringValue = ""
                    }
                }
            }
        }
        
    }
    }
	

