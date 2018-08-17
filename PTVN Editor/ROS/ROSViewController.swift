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
    @IBOutlet weak var weightView: NSTextField!
    @IBOutlet weak var heightView: NSTextField!
    @IBOutlet weak var tempView: NSTextField!
    @IBOutlet weak var bpSysView: NSTextField!
    @IBOutlet weak var bpDiaView: NSTextField!
    @IBOutlet weak var pulseView: NSTextField!
    @IBOutlet weak var respView: NSTextField!
    @IBOutlet weak var pulseOxView: NSTextField!
    @IBOutlet weak var bpAreaBox: NSView!
    @IBOutlet weak var pulseOxBox: NSView!
    
    
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    var allROSControllers:[NSButton] { return  getListOfButtons(rosView)}

    
    var genList:(sectionName: String, list: [(title:String, state:Int)]) {return ("GEN", returnTitleAndStateFrom(1))}
    var giList:(sectionName: String, list: [(title:String, state:Int)]) {return ("GI", returnTitleAndStateFrom(2))}
    var psychList:(sectionName: String, list: [(title:String, state:Int)]) {return ("PSYCH", returnTitleAndStateFrom(3))}
    var guList:(sectionName: String, list: [(title:String, state:Int)]) {return ("GU", returnTitleAndStateFrom(4))}
    var endoList:(sectionName: String, list: [(title:String, state:Int)]) {return ("ENDO", returnTitleAndStateFrom(5))}
    var heentList:(sectionName: String, list: [(title:String, state:Int)]) {return ("ENT", returnTitleAndStateFrom(6))}
    var eyeList:(sectionName: String, list: [(title:String, state:Int)]) {return ("EYE", returnTitleAndStateFrom(7))}
    var mskList:(sectionName: String, list: [(title:String, state:Int)]) {return ("MSK", returnTitleAndStateFrom(8))}
    var hemoList:(sectionName: String, list: [(title:String, state:Int)]) {return ("HEMO", returnTitleAndStateFrom(9))}
    var respList:(sectionName: String, list: [(title:String, state:Int)]) {return ("RESP", returnTitleAndStateFrom(10))}
    var neuroList:(sectionName: String, list: [(title:String, state:Int)]) {return ("NEURO", returnTitleAndStateFrom(11))}
    var cardioList:(sectionName: String, list: [(title:String, state:Int)]) {return ("CARDIO", returnTitleAndStateFrom(12))}
    var dermList:(sectionName: String, list: [(title:String, state:Int)]) {return ("DERM", returnTitleAndStateFrom(13))}
    

    let nc = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rosView.clearControllers()
    }
    
    @IBAction func processROS(_ sender: NSButton) {
        //This code is supposed to save the document, I was trying to use it as a backup
        //incase of a crash, but it doesn't seem to do what I need
        NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)
        
        let results = processROSForm([genList, psychList, eyeList, heentList, cardioList, respList, giList, guList, endoList, neuroList, mskList, hemoList, dermList])
        let currentVitals = Vitals(weight: weightView.stringValue, height: heightView.stringValue, temp: tempView.stringValue, bpSite: returnActiveButtonTitleFromView(bpAreaBox), systolic: bpSysView.stringValue, diastolic: bpDiaView.stringValue, pulse: pulseView.stringValue, resp: respView.stringValue, pulseOx: pulseOxView.stringValue, poType: returnActiveButtonTitleFromView(pulseOxBox))
        
        theData.ros.addToExistingText(results)
        theData.objective.addToExistingText(currentVitals.getVitalsOutput())
        
        let firstVC = presenting as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        
        
        if sender.title == "Process & Continue" {
        FormButtons.formName = "HPI"
        self.dismiss(self)
        nc.post(name: NSNotification.Name("SwitchForm"), object: nil)
        } else {
            self.dismiss(self)
        }
    }
    
    
    @IBAction func clearROS(_ sender: NSButton) {
        rosView.clearControllers()
    }
    
//    @IBAction func processAndContinueToHPI(_ sender: Any) {
//        processROS(self)
//        //TrackingTabs.newTab = 1
//        nc.post(name: NSNotification.Name("SwitchTabs"), object: nil)
//        processAndContinue()
//    }
    
    @IBAction func selectOnlyOne(_ sender: NSButton) {
        if let buttons = sender.superview?.subviews as? [NSButton] {
            for button in buttons {
                if button.title != sender.title {
                    button.state = .off
                }
            }
        }
    }
    
    func getListOfButtons(_ view:NSView) -> [NSButton] {
        var results = [NSButton]()
        for item in view.subviews {
            if item is NSButton {
                results.append((item as? NSButton)!)
            } else if item is NSStackView {
                results += getListOfButtons(item)
            }
        }
        //print(results)
        return results
    }
    
    func returnTitleAndStateFrom(_ tag:Int) -> [(String, Int)] {
        var results = [(title:String, state:Int)]()
        let buttons = allROSControllers.filter{$0.tag == tag && $0.state != .off}
        //print(buttons)
        for button in buttons {
            results.append((title:button.title.lowercased(), state:button.state.rawValue))
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
    

    
}
