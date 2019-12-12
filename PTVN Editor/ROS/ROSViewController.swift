//
//  ROSViewController.swift
//  LIROS
//
//  Created by Fool on 4/5/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class ROSViewController: NSViewController {
    
    @IBOutlet weak var rosView: NSView!
    @IBOutlet weak var genBox: NSBox!
    @IBOutlet weak var guBox: NSBox!
    @IBOutlet weak var endoBox: NSBox!
    @IBOutlet weak var psychBox: NSBox!
    @IBOutlet weak var giBox: NSBox!
    @IBOutlet weak var eyeBox: NSBox!
    @IBOutlet weak var entBox: NSBox!
    @IBOutlet weak var mskBox: NSBox!
    @IBOutlet weak var hemoBox: NSBox!
    @IBOutlet weak var respBox: NSBox!
    @IBOutlet weak var neuroBox: NSBox!
    @IBOutlet weak var cardioBox: NSBox!
    @IBOutlet weak var dermBox: NSBox!
    
    
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    var allROSControllers:[NSButton] { return  rosView.getListOfButtons()}

    
//    var genList:(sectionName: String, list: [(title:String, state:Int)]) {return ("GEN", returnTitleAndStateFromView(rosView, withTag: 1))}
//    var giList:(sectionName: String, list: [(title:String, state:Int)]) {return ("GI", returnTitleAndStateFromView(rosView, withTag: 2))}
//    var psychList:(sectionName: String, list: [(title:String, state:Int)]) {return ("PSYCH", returnTitleAndStateFromView(rosView, withTag: 3))}
//    var guList:(sectionName: String, list: [(title:String, state:Int)]) {return ("GU", returnTitleAndStateFromView(rosView, withTag: 4))}
//    var endoList:(sectionName: String, list: [(title:String, state:Int)]) {return ("ENDO", returnTitleAndStateFromView(rosView, withTag: 5))}
//    var heentList:(sectionName: String, list: [(title:String, state:Int)]) {return ("ENT", returnTitleAndStateFromView(rosView, withTag: 6))}
//    var eyeList:(sectionName: String, list: [(title:String, state:Int)]) {return ("EYE", returnTitleAndStateFromView(rosView, withTag: 7))}
//    var mskList:(sectionName: String, list: [(title:String, state:Int)]) {return ("MSK", returnTitleAndStateFromView(rosView, withTag: 8))}
//    var hemoList:(sectionName: String, list: [(title:String, state:Int)]) {return ("HEMO", returnTitleAndStateFromView(rosView, withTag: 9))}
//    var respList:(sectionName: String, list: [(title:String, state:Int)]) {return ("RESP", returnTitleAndStateFromView(rosView, withTag: 10))}
//    var neuroList:(sectionName: String, list: [(title:String, state:Int)]) {return ("NEURO", returnTitleAndStateFromView(rosView, withTag: 11))}
//    var cardioList:(sectionName: String, list: [(title:String, state:Int)]) {return ("CARDIO", returnTitleAndStateFromView(rosView, withTag: 11))}
//    var dermList:(sectionName: String, list: [(title:String, state:Int)]) {return ("DERM", returnTitleAndStateFromView(rosView, withTag: 11))}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rosView.clearControllers()
        
        //Check if there is existing ROS data
        if !theData.ros.isEmpty {
            //If there is, parse it out
            guard let existingROS = parseExistingROSData(theData.ros) else { return }
            for entry in existingROS {
                for button in allROSControllers {
                    //Mark buttons previously selected
                    if button.tag == entry.tag && button.title.lowercased().replacingOccurrences(of: "\n", with: "") == entry.title.lowercased() {
                        button.state = NSControl.StateValue(rawValue: entry.state)
                    }
                }
            }
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
    
    @IBAction func processROS(_ sender: NSButton) {
        //This code is supposed to save the document, I was trying to use it as a backup
        //incase of a crash, but it doesn't seem to do what I need
        //NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)
        
        let genSection = rosSection(sectionName: genBox.title, sectionData: returnTitleAndStateFromView(genBox, withTag: 1))
        let guSection = rosSection(sectionName: guBox.title, sectionData: returnTitleAndStateFromView(guBox, withTag: 4))
        let endoSection = rosSection(sectionName: endoBox.title, sectionData: returnTitleAndStateFromView(endoBox, withTag: 5))
        let psychSection = rosSection(sectionName: psychBox.title, sectionData: returnTitleAndStateFromView(psychBox, withTag: 3))
        let giSection = rosSection(sectionName: giBox.title, sectionData: returnTitleAndStateFromView(giBox, withTag: 2))
        let eyeSection = rosSection(sectionName: eyeBox.title, sectionData: returnTitleAndStateFromView(eyeBox, withTag: 7))
        let entSection = rosSection(sectionName: entBox.title, sectionData: returnTitleAndStateFromView(entBox, withTag: 6))
        let mskSection = rosSection(sectionName: mskBox.title, sectionData: returnTitleAndStateFromView(mskBox, withTag: 8))
        let hemoSection = rosSection(sectionName: hemoBox.title, sectionData: returnTitleAndStateFromView(hemoBox, withTag: 9))
        let respSection = rosSection(sectionName: respBox.title, sectionData: returnTitleAndStateFromView(respBox, withTag: 10))
        let neuroSection = rosSection(sectionName: neuroBox.title, sectionData: returnTitleAndStateFromView(neuroBox, withTag: 11))
        let cardioSection = rosSection(sectionName: cardioBox.title, sectionData: returnTitleAndStateFromView(cardioBox, withTag: 12))
        let dermSection = rosSection(sectionName: dermBox.title, sectionData: returnTitleAndStateFromView(dermBox, withTag: 13))
        
        //let results = processROSForm([genList, psychList, eyeList, heentList, cardioList, respList, giList, guList, endoList, neuroList, mskList, hemoList, dermList])
        let results = processROSForm([genSection, psychSection, eyeSection, entSection, cardioSection, respSection, giSection, guSection, endoSection, neuroSection, mskSection, hemoSection, dermSection])
        
        //Replacing the data instead of adding to it after implementing
        //the ability to read data back into the form
        theData.ros = results
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        
        
        if sender.title == "Process & Continue" {
        self.dismiss(self)
            currentPTVNDelegate?.switchToModule(module: FormButton.pain)
        } else {
            self.dismiss(self)
        }
    }
    
    
    @IBAction func clearROS(_ sender: NSButton) {
        rosView.clearControllers()
    }

    
//    private func getListOfButtons(_ view:NSView) -> [NSButton] {
//        var results = [NSButton]()
//        for item in view.subviews {
//            if item is NSButton {
//                results.append((item as? NSButton)!)
//            } else if item is NSStackView {
//                results += getListOfButtons(item)
//            }
//        }
//        //print(results)
//        return results
//    }
    
    func returnTitleAndStateFromView(_ view:NSView, withTag tag:Int) -> [(String, Int)] {
        var results = [(title:String, state:Int)]()
        let buttons = view.getListOfButtons().filter {$0.tag == tag && $0.state != .off}
        //let buttons = allROSControllers.filter{$0.tag == tag && $0.state != .off}
        //print("Returned buttons are: \(buttons)")
        for button in buttons {
            results.append((title:button.title/*.lowercased()*/, state:button.state.rawValue))
        }
        return results
    }
    
    func returnActiveButtonTitleFromView(_ view:NSView) -> String {
        let buttons = view.getButtonsInView()
        for button in buttons {
            if button.state == .on {
            return button.title
            }
        }
        return ""
    }
    
    @IBAction func flipAllButtons(_ sender: NSButton) {
        for button in allROSControllers {
            button.setNextState()
        }
    }
    
}
