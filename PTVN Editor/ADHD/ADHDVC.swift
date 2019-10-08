//
//  ADHDVC.swift
//  PTVN Editor
//
//  Created by Fool on 4/10/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Cocoa

class ADHDVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var adhdQuestionTableView: NSTableView!
    
    let adhdData = ADHDData()
    var answersArray = [String]()
    var dxScore = 0
    var severityScore = 0
        
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.adhdQuestionTableView.delegate = self
        self.adhdQuestionTableView.dataSource = self
        
        self.adhdQuestionTableView.reloadData()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return adhdData.adhdQuestions.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        
        vw.textField?.stringValue = adhdData.adhdQuestions[row]
        
        return vw
    }
    
    @IBAction func addToScore(_ sender: NSButton) {
        //Get the row of the button to determine what section
        //of the questionnaire it belongs to
        let row = adhdQuestionTableView.row(for: sender)
        //print("Row: \(row)")
        
        func updateScore(_ score: inout Int, state: NSControl.StateValue) {
            if state == .on {
                score += 1
                //print("Score is: \(score)")
            } else if state == .off {
                score -= 1
                //print("Score is: \(score)")
            }
        }
        
        switch row {
        case 3,4,5:
            if sender.tag == 1 {
                updateScore(&dxScore, state: sender.state)
            }
        case 6,7,9,10,12,13,14,16:
            if sender.tag == 1 {
                updateScore(&severityScore, state: sender.state)
            }
        case 0,1,2:
            if sender.tag == 1 || sender.tag == 3 {
                updateScore(&dxScore, state: sender.state)
            }
        case 8,11,15,17:
            if sender.tag == 1 || sender.tag == 3 {
                updateScore(&severityScore, state: sender.state)
            }
        default:
            return
        }
        
    }
    
    @IBAction func processADHD(_ sender: NSButton) {
        let firstVC = presentingViewController as! ViewController
        var severityResult = String()
        var result = String()
        
        switch severityScore {
        case 0...4: severityResult = ADHDData.ADHDResultEnum.mild.rawValue
        case 5...8: severityResult = ADHDData.ADHDResultEnum.moderate.rawValue
        case 9...12: severityResult = ADHDData.ADHDResultEnum.severe.rawValue
        default: return
        }
        //Process the information from the view
        switch dxScore {
        case 0...3: result = ADHDData.ADHDResultEnum.inconsistent.rawValue
        case 4...6: result = ADHDData.ADHDResultEnum.consistent.rawValue + severityResult
        default: return
        }
        print("Result: \(result)")
        //Add the information to the existing subjective data
        if !result.isEmpty {
            theData.objective.addToExistingText("\(result)")
        }
        
        //print(theData.subjective)
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
    }
    
}
