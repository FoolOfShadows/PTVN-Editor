//
//  ViewController.swift
//  PTVN Editor
//
//  Created by Fool on 4/6/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa
import Quartz

protocol ptvnDelegate: class {
    func returnPTVNValues(sender: NSViewController)
}

class ViewController: NSViewController, NSTextViewDelegate, NSTextFieldDelegate, ptvnDelegate {

    @IBOutlet weak var ptNameView: NSTextField!
    @IBOutlet weak var ptDOBView: NSTextField!
    @IBOutlet weak var ptVisitView: NSTextField!
    @IBOutlet weak var ccScroll: NSScrollView!
    //@IBOutlet weak var ccView: NSTextField!
    @IBOutlet var rosView: NSTextView!
    @IBOutlet var subjectiveView: NSTextView!
    @IBOutlet var preventiveView: NSTextView!
    @IBOutlet var pmhView: NSTextView!
    @IBOutlet var nutritionView: NSTextView!
    @IBOutlet var socialView: NSTextView!
    @IBOutlet var familyView: NSTextView!
    @IBOutlet var allergyView: NSTextView!
    @IBOutlet var medsView: NSTextView!
    //@IBOutlet var vitalsView: NSTextView!
    @IBOutlet var objectiveView: NSTextView!
    @IBOutlet var pshView: NSTextView!
    @IBOutlet var assessmentView: NSTextView!
    @IBOutlet var planView: NSTextView!
    @IBOutlet weak var pharmacyView: NSTextField!
    
    var ccView: NSTextView {
        get {
            return ccScroll.contentView.documentView as! NSTextView
        }
    }
    
    //Instantiate a PTVN instance
    var theData = PTVN(theText: "")
    var document = Document()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the font settings for the text views
        let theUserFont:NSFont = NSFont.systemFont(ofSize: 18)
        let fontAttributes = NSDictionary(object: theUserFont, forKey: kCTFontAttributeName as! NSCopying)
        let theTextViews = [ccView, medsView, rosView, subjectiveView, preventiveView, pmhView, nutritionView, socialView, familyView, allergyView, medsView, objectiveView, pshView, assessmentView, planView]
        theTextViews.forEach { view in
            view!.typingAttributes = fontAttributes as! [NSAttributedStringKey : Any]
        }
        
        //Set up delegation for the text views and fields to be able to respond to typing
        ccView.delegate = self
        medsView.delegate = self
        rosView.delegate = self
        subjectiveView.delegate = self
        preventiveView.delegate = self
        pmhView.delegate = self
        nutritionView.delegate = self
        socialView.delegate = self
        familyView.delegate = self
        allergyView.delegate = self
        medsView.delegate = self
        //vitalsView.delegate = self
        objectiveView.delegate = self
        pshView.delegate = self
        assessmentView.delegate = self
        planView.delegate = self
        pharmacyView.delegate = self
        
        //Set up selections in lists with data from text file
        if let fluList = getSectionDataStartingFrom("START FLU", andEndingWith: "END FLU") {
            fluTypeList = [""] + fluList
        }
        if let medsList = getSectionDataStartingFrom("START COMMON MEDS", andEndingWith: "END COMMON MEDS") {
            commonMedsList = [""] + medsList
        }
        if let whereFluList = getSectionDataStartingFrom("START WHERE FLU", andEndingWith: "END WHERE FLU") {
            whereFlu = [""] + whereFluList
        }
        if let declinesFluList = getSectionDataStartingFrom("START DECLINES FLU", andEndingWith: "END DECLINES FLU") {
            //print("\n\n\n\(declinesFluList)\n\n\n")
            declinesFlu = [""] + declinesFluList
        }
        
        //Set up notification center for switching forms
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(switchForm), name: Notification.Name("SwitchForm"), object: nil)
    }
    
    
    override func viewWillAppear() {
        //Populate the view with existing data when loading a file
        //Needs to be here rather than viewDidLoad
        document = self.view.window?.windowController?.document as! Document
        theData = document.theData
        updateView()
        
    }

    //Update the PTVN instance variables as the user is typing into the associated fields
    func textDidChange(_ notification: Notification) {
        guard let theView = notification.object as? NSTextView else { return }
        updateVarForView(theView)
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        guard let theView = obj.object as? NSTextField else { return }
        updateVarForField(theView)
        document.updateChangeCount(.changeDone)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let theSegue = segue.identifier?.rawValue {
            switch theSegue {
            case "showDoctor":
                if let toViewController = segue.destinationController as? DoctorViewController {
                    //For the delegate to work, it needs to be assigned here
                    //rather than in view did load.  Because it's a modal window?
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showROS":
                if let toViewController = segue.destinationController as? ROSViewController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showRadRef":
                if let toViewController = segue.destinationController as? RadRefViewController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showLab":
                if let toViewController = segue.destinationController as? LabsViewController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showHPI":
                if let toViewController = segue.destinationController as? HPIViewController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showPain":
                if let toViewController = segue.destinationController as? PainViewController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showDiabetes":
                if let toViewController = segue.destinationController as? DMViewController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showProcInj":
                if let toViewController = segue.destinationController as? ProcInjViewController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showWWE":
                if let toViewController = segue.destinationController as? WWEViewController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showPEGen":
                if let toViewController = segue.destinationController as? GenPsychHEENTNeck_VC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showPECV":
                if let toViewController = segue.destinationController as? CVChestGILymph_VC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showExtremeties":
                if let toViewController = segue.destinationController as? Extremities_VC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showSkin":
                if let toViewController = segue.destinationController as? SkinGynGUDRE_VC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showBreast":
                if let toViewController = segue.destinationController as? Breast_VC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showNeuro":
                if let toViewController = segue.destinationController as? NeuroMSK_VC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showMWE":
                if let toViewController = segue.destinationController as? MWEController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showESS":
                if let toViewController = segue.destinationController as? ESSController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showIncont":
                if let toViewController = segue.destinationController as? IncontinenceController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showMemory":
                if let toViewController = segue.destinationController as? MemoryController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showPHQ9":
                if let toViewController = segue.destinationController as? PHQ9Controller {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showPreventive":
                if let toViewController = segue.destinationController as? PreventiveController {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showCurrentMeds":
                if let toViewController = segue.destinationController as? MedicineReviewVC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showCheckOut":
                if let toViewController = segue.destinationController as? CheckOutVC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showMood":
                if let toViewController = segue.destinationController as? MoodVC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            default: return
            }
        }
    }
    
    //When one of the form views exits after updating the instance of the PTVN
    //update the document's main view
    func returnPTVNValues(sender: NSViewController) {
        //Because the document's not catching changes returned from the forms
        //it's change count has to be manually updated here to trigger
        //save on closing notice
        updateView()
        document.updateChangeCount(.changeDone)
    }
    
    //Update the main view of the document with data from the PTVN instance
    func updateView() {
        ptNameView.stringValue = theData.ptName
        //print(theData.ptName)
        ptDOBView.stringValue = "\(theData.ptDOB)   (\(theData.ptAge))"
        ptVisitView.stringValue = theData.visitDate
        medsView.string = theData.medicines
        allergyView.string = theData.allergies
        ccView.string = theData.cc
        rosView.string = theData.ros
        subjectiveView.string = theData.subjective
        //print(theData.preventive)
        preventiveView.string = theData.preventive
        pmhView.string = theData.pmh
        nutritionView.string = theData.nutrition
        socialView.string = theData.social
        familyView.string = theData.family
        //vitalsView.string = theData.
        objectiveView.string = theData.objective
        pshView.string = theData.psh
        assessmentView.string = theData.assessment
        planView.string = theData.plan
        pharmacyView.stringValue = theData.pharmacy
        //document.updateChangeCount(.changeDone)
    }
    
    //Update the instance of the PTVN with data being entered into the main document view
    func updateVarForView(_ view:NSTextView) {
        switch view {
        case medsView:
            theData.medicines = medsView.string
            //print(theData.medicines)
        case rosView:
            theData.ros = rosView.string
        case subjectiveView:
            theData.subjective = subjectiveView.string
        case preventiveView:
            theData.preventive = preventiveView.string
        case pmhView:
            theData.pmh = pmhView.string
        case nutritionView:
            theData.nutrition = nutritionView.string
        case socialView:
            theData.social = socialView.string
        case familyView:
            theData.family = familyView.string
        case allergyView:
            theData.allergies = allergyView.string
        case ccView:
            theData.cc = ccView.string
        case objectiveView:
            theData.objective = objectiveView.string
        case pshView:
            theData.psh = pshView.string
        case assessmentView:
            theData.assessment = assessmentView.string
        case planView:
            theData.plan = planView.string
//        case pharmacyView:
//            theData.pharmacy = pharmacyView.stringValue
        default: return
        }
        //document.updateChangeCount(.changeDone)
    }
    
    func updateVarForField(_ field:NSTextField) {
        theData.pharmacy = pharmacyView.stringValue
    }
    
    @IBAction func copyObjective(_ sender: Any) {
        theData.returnSOAPSection(.objective).copyToPasteboard()
    }
    
    @IBAction func copySubjective(_ sender: Any) {
        theData.returnSOAPSection(.subjective).copyToPasteboard()
    }
    
    @IBAction func copyAssessment(_ sender: Any) {
        theData.returnSOAPSection(.assessment).copyToPasteboard()
    }
    
    @IBAction func copyPlan(_ sender: Any) {
        theData.returnSOAPSection(.plan).copyToPasteboard()
    }
    
    @IBAction func getPMHUpdates(_ sender: Any) {
        let updates = theData.getPMHChanges()
        let printTextView = NSTextView()
        printTextView.setFrameSize(NSSize(width: 680, height: 0))
        printTextView.string = "\(theData.ptName):\n\(updates)"
        printTextView.textStorage?.font = NSFont(name: "Times New Roman", size: 16)
        
        
        let myPrintInfo = NSPrintInfo.shared
        
        myPrintInfo.leftMargin = 40
        myPrintInfo.bottomMargin = 40
        myPrintInfo.isVerticallyCentered = false
        
        let myPrintOperation = NSPrintOperation(view: printTextView, printInfo: myPrintInfo)
        myPrintOperation.run()
        //print(updates)
    }
    
    @IBAction func clearPMHPrefixes(_ sender: Any) {
        //Because the cleanTheTextOf methods has the regex option on
        //the carots have to be escaped in the badBits or they won't
        //be recognized
        let badBits = ["\\^\\^"]
        theData.preventive = theData.preventive.cleanTheTextOf(badBits)
        theData.pmh = theData.pmh.cleanTheTextOf(badBits)
        theData.psh = theData.psh.cleanTheTextOf(badBits)
        theData.nutrition = theData.nutrition.cleanTheTextOf(badBits)
        theData.social = theData.social.cleanTheTextOf(badBits)
        theData.family = theData.family.cleanTheTextOf(badBits)
        updateView()
        document.updateChangeCount(.changeDone)
    }

    @IBAction func markAsCharged(_ sender: Any) {
        assessmentView.addToViewsExistingText("(done dmw)")
        updateVarForView(assessmentView)
        document.updateChangeCount(.changeDone)
    }
    
    @objc func switchForm() {
        //print("Notification received")
        let buttons = self.view.getListOfButtons()
        let button = buttons.filter { $0.title == FormButtons.formName }[0]
        button.performClick(self)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
//            button.performClick(self)
//            print("button pressed?")
//        }
        
    }
    
    @IBAction func clearMeds(_ sender: Any) {
        if theData.plan.contains("~~"){
            theData.plan = theData.plan.cleanTheTextOf(["~~"])
            updateView()
            document.updateChangeCount(.changeDone)
        }
    }
    
    @IBAction func clearRads(_ sender: Any) {
        if theData.plan.contains("••"){
            theData.plan = theData.plan.replacingOccurrences(of: "••", with: "DONE - ")
            updateView()
            document.updateChangeCount(.changeDone)
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

