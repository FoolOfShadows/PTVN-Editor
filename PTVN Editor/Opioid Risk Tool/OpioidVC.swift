//
//  OpioidVC.swift
//  PTVN Editor
//
//  Created by Fool on 8/29/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Cocoa

class OpioidVC: NSViewController {

    @IBOutlet weak var genderStack: NSStackView!
    @IBOutlet weak var familyHistoryStack: NSStackView!
    @IBOutlet weak var personalHistoryStack: NSStackView!
    @IBOutlet weak var abuseCheckbox: NSButton!
    @IBOutlet weak var psychDxStack: NSStackView!
    @IBOutlet weak var scoreLabel: NSTextField!
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    var gender = ""
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
         if let age = Int(theData.ptAge) {
                   if 16...45 ~= age {
                       score += 1
                   }
               }
        scoreLabel.stringValue = String(score)
    
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }
    
    @IBAction func getGender(_ sender: NSButton) {
        let buttons = genderStack.getListOfButtons()
        for button in buttons {
            if button.title != sender.title {
                button.state = .off
            }
        }
        gender = sender.title
    }
    
    @IBAction func getFamilyHistory(_ sender: NSButton) {
        var localScore = 0
        switch sender.title {
        case "Alcohol":
            if gender == "Male" {
                localScore = 3
            } else if gender == "Female" {
                localScore = 1
            }
        case "Illegal drugs":
            if gender == "Male" {
                localScore = 3
            } else {
                localScore = 2
            }
        case "Rx drugs":
            localScore = 4
        default:
            return
        }
        adjustScoreFromChoice(sender, withValue: localScore)
    }
    
    @IBAction func getPersonalHistory(_ sender: NSButton) {
        var localScore = 0
        switch sender.title {
        case "Alcohol":
            localScore = 3
        case "Illegal drugs":
            localScore = 4
        case "Rx drugs":
            localScore = 5
        default:
            return
        }
        adjustScoreFromChoice(sender, withValue: localScore)
    }
    
    @IBAction func getAbuse(_ sender: NSButton) {
        var localScore = 0
        if gender == "Male" {
            localScore = 0
        } else if gender == "Female" {
            localScore = 3
        }
        adjustScoreFromChoice(sender, withValue: localScore)
    }
    
    @IBAction func getPsychDx(_ sender: NSButton) {
        var localScore = 0
        switch sender.title {
        case "ADD, OCD, bipolar, schizophrenia":
            localScore = 2
        case "Depression":
            localScore = 1
        default:
            return
        }
        adjustScoreFromChoice(sender, withValue: localScore)
    }
    
    func adjustScoreFromChoice(_ choice:NSButton, withValue value: Int) {
        switch choice.state {
        case .on:
            score += value
        case .off:
            score -= value
        default:
            return
        }
        scoreLabel.stringValue = String(score)
    }
    
    @IBAction func processAssessment(_ sender: Any) {
        var results = ""
        
        switch score {
        case 0...3:
            results = "Patient scored \(score) on Opioid Risk Tool assessment indicating low risk for future opioid abuse."
        case 4...7:
            results = "Patient scored \(score) on Opioid Risk Tool assessment indicating moderate risk for future opioid abuse."
        case 8...26:
            results = "Patient scored \(score) on Opioid Risk Tool assessment indicating high risk for future opioid abuse."
        default:
            results = ""
        }
        
        if !results.isEmpty {
            theData.subjective.addToExistingText(results)
        }
        
        let firstVC = presentingViewController as? ViewController
        firstVC?.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
    }
    
}
