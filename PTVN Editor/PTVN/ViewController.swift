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
    func switchToModule(module: FormButton)
}
protocol browerChoiceDelegate: class {
    func changeBrowserLabel()
}
protocol notesDelegate: class {
    func updateSubjectiveWithNotes(_ notes: String)
    var noteWindowOpen:Bool { get set }
    var noteWindow:NSWindow? { get set }
}

class ViewController: NSViewController, NSTextViewDelegate, NSTextFieldDelegate, NSControlTextEditingDelegate, NSTableViewDataSource, NSTableViewDelegate, ptvnDelegate, browerChoiceDelegate, notesDelegate {

    @IBOutlet weak var ptNameView: NSTextField!
    @IBOutlet weak var ptDOBView: NSTextField!
    @IBOutlet weak var ptVisitView: NSTextField!
    @IBOutlet weak var ccScroll: NSScrollView!
    //@IBOutlet weak var ccView: NSTextField!
    @IBOutlet var rosView: NSTextView!
    @IBOutlet var problemView: NSTextView!
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
    @IBOutlet weak var assessmentTableView: NSTableView!
    @IBOutlet weak var visitLevelView: NSView!
    @IBOutlet var planView: NSTextView!
    @IBOutlet var dxView: NSTextView!
    @IBOutlet weak var commonMedsPopup: NSPopUpButton!
    @IBOutlet weak var pharmacyView: NSTextField!
    @IBOutlet weak var subjectiveActivateSafari: NSButton!
    @IBOutlet weak var objectiveActivateSafari: NSButton!
    @IBOutlet weak var assessmentActivateSafari: NSButton!
    @IBOutlet weak var planActivateSafari: NSButton!
    
    var ccView: NSTextView {
        get {
            return ccScroll.contentView.documentView as! NSTextView
        }
    }
    
    var assessmentString = String()
    var assessmentList = [String]()
    var chosenAssessmentList = [String]()
    
    var followupInfo = (first:String(), second:String(), third:String())
    
    //Instantiate a PTVN instance
    var theData = PTVN(theText: "")
    var document = Document()
    
    var windowCloseDelegate:WindowCloseProtocol?
    
    var noteWindowOpen:Bool = false {
        didSet {
            windowCloseDelegate?.setWindowCloseValue(self.noteWindowOpen)
        }
    }
    
    var noteWindow: NSWindow?
    
    func updateSubjectiveWithNotes(_ notes: String) {
        //print("updating the view with \(notes)")
        subjectiveView.string.addToExistingText(notes)
        updateVarForView(subjectiveView)
    }
    
    @IBAction func openNotesView(_ sender: Any) {
        if noteWindowOpen == false {
        performSegue(withIdentifier: "showNoteWindow", sender: self)
        windowCloseDelegate?.setWindowCloseValue(noteWindowOpen)
        } else {
            //Get the currently existing window passed from the delegate and bring it forward
            if let notesWindow = noteWindow, notesWindow.title == "Notes" {
                notesWindow.makeKeyAndOrderFront(self)
            }
        }
    }
    
    //Create a spellchecking instance
    let spellChecker = OurSpellChecker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the font settings for the text views
        let theUserFont:NSFont = NSFont.systemFont(ofSize: 18)
        let fontAttributes = NSDictionary(object: theUserFont, forKey: kCTFontAttributeName as! NSCopying)
        let theTextViews = [ccView, medsView, rosView, problemView, subjectiveView, preventiveView, pmhView, nutritionView, socialView, familyView, allergyView, medsView, objectiveView, pshView, assessmentView, planView, dxView]
        theTextViews.forEach { view in
            view!.typingAttributes = fontAttributes as! [NSAttributedString.Key : Any]
        }
        
        //Set up the table of previous assessments on the Assessment & Plan tab
        self.assessmentTableView.delegate = self
        self.assessmentTableView.dataSource = self
        
        
        //Set up delegation for the text views and fields to be able to respond to typing
        ccView.delegate = self
        medsView.delegate = self
        rosView.delegate = self
        problemView.delegate = self
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
        dxView.delegate = self
        
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
//        nc.addObserver(self, selector: #selector(switchForm), name: Notification.Name("SwitchForm"), object: nil)
        //Set up notification center for changing browser label
        nc.addObserver(self, selector: #selector(changeBrowserLabel), name: Notification.Name("SetBrowser"), object: nil)
    }
    
    
    override func viewWillAppear() {
        //Populate the view with existing data when loading a file
        //Needs to be here rather than viewDidLoad
        document = self.view.window?.windowController?.document as! Document
        theData = document.theData
        
        //Populate assessmentTableView with Problems subsection of the Subjective section
        let problems = theData.problems
        //print(problems)
        assessmentList = problems.convertListToArray()
        //print(assessmentList)
        self.assessmentTableView.reloadData()
        //chosenAssessmentList = assessmentList
        updateView()
        commonMedsPopup.clearPopUpButton(menuItems: commonMedsList)
        
        changeBrowserLabel()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }

    //Update the PTVN instance variables as the user is typing into the associated fields
    func textDidChange(_ notification: Notification) {
        guard let theView = notification.object as? NSTextView else { return }
        updateVarForView(theView)
    }
    
    /*override*/ func controlTextDidChange(_ obj: Notification) {
        guard let theView = obj.object as? NSTextField else { return }
        updateVarForField(theView)
        document.updateChangeCount(.changeDone)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let theSegue = segue.identifier {
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
                    //theData.plan.addToExistingText(theData.followupInfo)
                    //returnPTVNValues(sender: self)
                    toViewController.theData = theData
                }
            case "showMood":
                if let toViewController = segue.destinationController as? MoodVC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showADHD":
                if let toViewController = segue.destinationController as? ADHDVC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showORTView":
                if let toViewController = segue.destinationController as? OpioidVC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showADAM":
                if let toViewController = segue.destinationController as? ADAMVC {
                    toViewController.currentPTVNDelegate = self
                    toViewController.theData = theData
                }
            case "showNoteWindow":
                //print("segueing from main VC")
                if let toViewController = segue.destinationController as? NoteWindowVC {
                    toViewController.currentNoteDelegate = self
                }
            default: return
            }
        }
    }
    
    //When one of the form views exits after updating the instance of the PTVN
    //update the document's main view
    func returnPTVNValues(sender: NSViewController) {
        //print("Returning PTVN Values from \(sender.title)")
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
        problemView.string = theData.problems
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
        dxView.string = theData.diagnoses
        //self.assessmentTableView.reloadData()
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
        case problemView:
            theData.problems = problemView.string
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
        case dxView:
            theData.diagnoses = dxView.string
//        case pharmacyView:
//            theData.pharmacy = pharmacyView.stringValue
        default: return
        }
        document.updateChangeCount(.changeDone)
    }
    
    func updateVarForField(_ field:NSTextField) {
        theData.pharmacy = pharmacyView.stringValue
    }
    
    @IBAction func copyObjective(_ sender: Any) {
        spellChecker.correctMisspelledWordsIn(theData.returnSOAPSection(.objective)).copyToPasteboard()
        if objectiveActivateSafari.state == NSControl.StateValue.on {
            activateBrowser()
        }
    }
    
    @IBAction func copySubjective(_ sender: Any) {
        spellChecker.correctMisspelledWordsIn(theData.returnSOAPSection(.subjective)).copyToPasteboard()
        if subjectiveActivateSafari.state == NSControl.StateValue.on {
            activateBrowser()
        }
    }
    
    @IBAction func copyAssessment(_ sender: Any) {
        spellChecker.correctMisspelledWordsIn(theData.returnSOAPSection(.assessment)).copyToPasteboard()
        if assessmentActivateSafari.state == NSControl.StateValue.on {
            activateBrowser()
        }
    }
    
    @IBAction func copyPlan(_ sender: Any) {
        spellChecker.correctMisspelledWordsIn(theData.returnSOAPSection(.plan)).copyToPasteboard()
        if planActivateSafari.state == NSControl.StateValue.on {
            activateBrowser()
        }
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
    
    //Lets MA jump directly to the next eval form
//    @objc func switchForm() {
//        //print("Notification received")
//        let buttons = self.view.getListOfButtons()
//        let button = buttons.filter { $0.title == FormButtons.formName }[0]
//        print(button.title)
//        button.performClick(self)
//    }
    
    func switchToModule(module: FormButton) {
        let buttons = self.view.getListOfButtons()
        let button = buttons.filter { $0.title == module.rawValue }[0]
        print(button.title)
        button.performClick(self)
    }
    
    //Changes the label of the "And open [browser]" button to match the user's chosen browser
    @objc func changeBrowserLabel() {
        let defaults = UserDefaults.standard
        let browser = defaults.string(forKey: UserDefaultKeyTitles.browser.rawValue) ?? "Safari"
        
        subjectiveActivateSafari.title = "And Activate \(browser)"
        objectiveActivateSafari.title = "And Activate \(browser)"
        assessmentActivateSafari.title = "And Activate \(browser)"
        planActivateSafari.title = "And Activate \(browser)"
        //print("Delegate notification received, browser set to \(browser), and title set to \(subjectiveActivateSafari.title)")
    }
    
    @IBAction func clearMeds(_ sender: Any) {
        if theData.plan.contains("~~"){
            //theData.plan = theData.plan.cleanTheTextOf(["~~"])
            theData.plan = theData.plan.replacingOccurrences(of: "~~", with: "DONE - ")
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
    
    func activateBrowser() {
        let defaults = UserDefaults.standard
        let browser = defaults.string(forKey: "browser") ?? "Safari"
        NSWorkspace.shared.openFile("/Applications/\(browser).app")
    }
    
    //MARK: Table Handling Functions
    func numberOfRows(in tableView: NSTableView) -> Int {
        print("Table row count = \(assessmentList.count)")
        return assessmentList.count
    }
    
    //Set up the tableview with the data from the assessmentList array
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var result:NSTableCellView
        result = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as! NSTableCellView
        result.textField?.stringValue = assessmentList[row]
        
        return result
    }
    
    @IBAction func processAssessmentTable(_ sender: Any) {
        
        let results = Assessment().processAssessmentUsingArray(chosenAssessmentList, and: visitLevelView.getListOfButtons().filter {$0.state == .on}.map {$0.title})
        //print(results)
        theData.assessment.addToExistingText(results, withSpace: false)
        
        //Reorganize the assessment so the Visit Level is at the bottom of the dx list
        let assessList = theData.assessment.components(separatedBy: "\n")
        var qResults = [String]()
        let visitLevel = assessList.filter {$0.hasPrefix("Lvl")}
        let visitDx = assessList.filter {$0.hasPrefix("-")}
        qResults += assessList.filter { $0.contains("PHQ-9") || $0.contains("ESS questionnaire") || $0.contains("Incontinence questionnaire") || $0.contains("Memory test") || $0.contains("Mood test") || $0.contains("1111F")}
        let restOfList = assessList.filter {!(visitLevel + visitDx + qResults).contains($0)}
        //print("\(visitLevel)\n\(visitDx)\n\(restOfList)")
        let reorganizedList = restOfList + visitDx + visitLevel + qResults
        theData.assessment = reorganizedList.filter {!$0.isEmpty}.joined(separator: "\n")
        
        //Clear table
        visitLevelView.clearControllers()
        assessmentTableView.clearControllers()
        chosenAssessmentList = [String]()
        updateView()
    }
    
    @IBAction func getDataFromSelectedRow(_ sender:Any) {
        let currentRow = assessmentTableView.row(for: sender as! NSView)
        if (sender as! NSButton).state == .on {
            chosenAssessmentList.append(assessmentList[currentRow])
        } else if (sender as! NSButton).state == .off {
            chosenAssessmentList = chosenAssessmentList.filter { $0 != assessmentList[currentRow] }
        }
    }
    
    //Attached to the table's Table Cell View prototype via the classes First Responder
    //updates the data source array with any changes made to the table items.
    @IBAction func updateArrayWithEdit(_ sender:Any) {
        let currentRow = assessmentTableView.row(for: sender as! NSView)
        //print(currentRow)
        
        if let textField = sender as? NSTextField {
            let textValue = textField.stringValue
            assessmentList.remove(at: currentRow)
            assessmentList.insert(textValue, at: currentRow)
        }
        
        
    }
    
    //Removes the selected row from the table and the corresponding
    //item from the data source array
    @IBAction func removeRowFromTable(_ sender: NSButton) {
        let row = assessmentTableView.selectedRow
        if row != -1 {
            assessmentList.remove(at: row)
            let indexSet = IndexSet(integer:row)
            assessmentTableView.removeRows(at:indexSet, withAnimation:NSTableView.AnimationOptions.effectFade)
        }
    }
    
    @IBAction func addMed(_ sender: Any) {
        if !commonMedsPopup.titleOfSelectedItem!.isEmpty {
            let newMed = "~~" + commonMedsPopup.titleOfSelectedItem!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if planView.string.contains("Prescribed this visit:") {
                planView.string = planView.string.replacingOccurrences(of: "Prescribed this visit:", with: "Prescribed this visit:\n\(newMed)")
            } else {
                planView.addToViewsExistingText("Prescribed this visit:\n\(newMed)")
            }
            updateVarForView(planView)
            //            let currentMeds = medicationView.string
            //            medicationView.string = commonMedsPopup.titleOfSelectedItem! + currentMeds
        }
    }
    
    @IBAction func createMessage(_ sender: Any) {
      
        let ptName = ptNameView.stringValue
        let thePasteBoard = NSPasteboard.general
        if var contents = thePasteBoard.pasteboardItems?.first?.string(forType: .string) {
            "\(ptName) - \(contents)".copyToPasteboard()
        }
        NSWorkspace.shared.openFile("/Applications/DocsInk.app")
//        var theValues = [String]()
//        let theLines = problemView.string.components(separatedBy: "/n")
//        for line in theLines {
//            if line.contains("••") || line.contains("~~") {
//                theValues.append(line)
//            }
//        }
        
    }
    
    @IBAction func getFirstFUPart(_ sender: NSButton) {
        theData.followupPt1 = sender.title.lowercased()
        theData.createFollowup()
        if !theData.followupInfo.isEmpty {
            theData.plan.addToExistingText(theData.followupInfo)
            document.updateChangeCount(.changeDone)
        }
    }
    @IBAction func getSecondFUPart(_ sender: NSButton) {
        theData.followupPt2 = sender.title.lowercased()
        theData.createFollowup()
        if !theData.followupInfo.isEmpty {
            theData.plan.addToExistingText(theData.followupInfo)
            document.updateChangeCount(.changeDone)
        }
    }
    @IBAction func getThirdFUPart(_ sender: NSButton) {
        theData.followupPt3 = sender.title.lowercased()
        theData.createFollowup()
        if !theData.followupInfo.isEmpty {
            theData.plan.addToExistingText(theData.followupInfo)
            document.updateChangeCount(.changeDone)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

