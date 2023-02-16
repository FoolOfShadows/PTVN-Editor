//
//  ADAMVC.swift
//  PTVN Editor
//
//  Created by Fool on 10/17/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Cocoa

class ADAMVC: NSViewController {

    @IBOutlet weak var yesNoStack: NSStackView!
    @IBOutlet weak var resultsLabel: NSTextField!
    
    var score:Int = 0
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    

    
    @IBAction func tallyCheckboxBy1(_ sender: NSButton) {
        switch sender.state {
        case .on:
            score = score + 1
        case .off:
            score = score - 1
        default: break
        }
        if score > 2 {
            resultsLabel.stringValue = "possible low testosterone"
        } else {
            resultsLabel.stringValue = "normal testosterone"
        }
    }
    
    @IBAction func tallyCheckboxBy7(_ sender: NSButton) {
        switch sender.state {
        case .on:
            score = score + 3
        case .off:
            score = score - 3
        default: break
        }
        if score > 2 {
            resultsLabel.stringValue = "possible low testosterone"
        } else {
            resultsLabel.stringValue = "normal testosterone"
        }
    }
    
    @IBAction func processAdam(_ sender: Any) {
        let finalResult = "Adrogen Deficiency in the Aging Male questionnaire results indicate \(resultsLabel.stringValue)."
        
        theData.objective.addToExistingText(finalResult)
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
    }
    
    @IBAction func clearADAM(_ sender: Any) {
    }
}
