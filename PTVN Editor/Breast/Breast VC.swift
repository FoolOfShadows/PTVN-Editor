//
//  Breast VC.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class Breast_VC: NSViewController, ProcessTabProtocol {
    var selfView = NSView()
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadedViewControllers.append(self)
        selfView = self.view
        clearBreast()
//        let nc = NotificationCenter.default
//        nc.addObserver(self, selector: #selector(selectAllNormsInView), name: NSNotification.Name(rawValue: "SetAllToNorm"), object: nil)
        selectAllNormsInView()
    }
    
    @IBAction func processBreastTab(_ sender: Any) {
        let results = processTab()
        theData.objective.addToExistingText(results)
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
        //print(results)
    }
    
    func processTab() -> String {
        var resultArray = [String]()
        resultArray.append(Breast().processSectionFrom(getActiveButtonInfoIn(view: self.view)))
        return resultArray.filter {$0 != ""}.joined(separator: "\n")
    }
    
    @IBAction func clearTab(_ sender: Any) {
        clearBreast()
    }
    
    func clearBreast() {
        self.view.clearControllers()
        self.view.populateSelectionsInViewUsing(Breast())
    }
    
    @IBAction func switchNormOff(_ sender: NSButton) {
        if sender.state != .off {
            let theButtons = selfView.getButtonsInView()
            switch sender.tag {
            case 1101...1112, 4001...4013:
                theButtons.filter ({$0.tag == 1})[0].state = .off
            case 1001...1013, 4101...4112:
                theButtons.filter ({$0.tag == 4})[0].state = .off
            case 7, 12:
                theButtons.filter ({$0.tag == 3})[0].state = .off
            default: return
            }
        }
    }
    
    @IBAction func comboSwitchNormOff(_ sender: NSComboBox) {
        if !sender.stringValue.isEmpty {
            let theButtons = selfView.getButtonsInView()
            switch sender.tag {
            case 1014, 4014:
                theButtons.filter ({$0.tag == 4})[0].state = .off
            default: return
            }
            
        }
        
    }
    
    @IBAction func selectNorms(_ sender: NSButton) {
        func normalButtonRangesForSection(_ section:String) -> [Int] {
            switch section {
            case "breast":
                return [Int](1...4)
            default:
                return [Int]()
            }
        }
        
        guard let view = sender.superview else { return }
        turnButtons(getButtonsInView(view), InRange: normalButtonRangesForSection("breast"), ToState: sender.state)
    }
    
    @objc func selectAllNormsInView() {
        let normButtons = self.view.getNormalButtonsInView()
        for button in normButtons {
            button.state = .on
            selectNorms(button)
        }
    }
    
}
