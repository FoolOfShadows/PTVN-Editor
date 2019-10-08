//
//  MoodVC.swift
//  PTVN Editor
//
//  Created by Fool on 6/21/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

class MoodVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var sectionOneQuestionTableView: NSTableView!
//    @IBOutlet weak var mainScrollView: NSScrollView!
//    @IBOutlet weak var contentView: NSView!
    
    let myMood = MoodData()
    var finalAnswersArray = [String]()
    var sectionOneAnswersArray = [String]()
    var sectionThreeAnswersArray = [String]()
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Initial question count: \(myMood.sectionOneQuestions.count)")
        self.sectionOneQuestionTableView.delegate = self
        self.sectionOneQuestionTableView.dataSource = self
        
        self.sectionOneQuestionTableView.reloadData()
        
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
        print(myMood.sectionOneQuestions.count)
        return myMood.sectionOneQuestions.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        
        vw.textField?.stringValue = myMood.sectionOneQuestions[row]
        
        return vw
    }
    
    @IBAction func processMood(_ sender: NSButton) {
        let firstVC = presentingViewController as! ViewController
        if !sectionOneAnswersArray.isEmpty {
            finalAnswersArray.insert("Has there ever been a period of time when you were not your usual self and . . .\n\(sectionOneAnswersArray.joined(separator: "\n"))", at: 0)
        }
        if !sectionThreeAnswersArray.isEmpty {
            finalAnswersArray.append(sectionThreeAnswersArray.joined(separator: "\n"))
        }
        if !finalAnswersArray.isEmpty {
            theData.objective.addToExistingText("Mood Questionnaire:\n\(finalAnswersArray.joined(separator: "\n"))")
            theData.assessment.addToExistingText("Mood test")
        }
        
        print(theData.subjective)
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
    }
    
    @IBAction func takeSectionTwoAnswer(_ sender: NSButton) {
        if sender.state == .on {
            finalAnswersArray.append("Have you experienced several of these during the same period of time - \(sender.title.uppercased())")
        } else if sender.state == .off {
            finalAnswersArray = finalAnswersArray.filter { $0 != "Have you experienced several of these during the same periof of time - \(sender.title.uppercased())" }
        }
    }
    
    
    
    @IBAction func takeSectionOneAnswers(_ sender: NSButton) {
        let currentRow = sectionOneQuestionTableView.row(for: sender as NSView)
        
        if sender.state == .on {
            sectionOneAnswersArray.append("\(myMood.sectionOneQuestions[currentRow]) - \(sender.title.uppercased())")
        } else if sender.state == .off {
            sectionOneAnswersArray = sectionOneAnswersArray.filter { $0 != "\(myMood.sectionOneQuestions[currentRow]) - \(sender.title.uppercased())" }
        }
    }
    
    @IBAction func takeSectionThreeAAnswer(_ sender: NSButton) {
        if sender.state == .on {
            sectionThreeAnswersArray.append("How much of a problem did any of these situations cause you - \(sender.title.uppercased())")
        } else if sender.state == .off {
            sectionThreeAnswersArray = sectionThreeAnswersArray.filter { $0 != "How much of a problem did any of these situations cause you - \(sender.title.uppercased())" }
        }
    }
    
    @IBAction func takeSectionThreeBAnswer(_ sender: NSButton) {
        if sender.state == .on {
            sectionThreeAnswersArray.append("During the past month, have you often been bothered by feeling down, depressed, or hopeless - \(sender.title.uppercased())")
        } else if sender.state == .off {
            sectionThreeAnswersArray = sectionThreeAnswersArray.filter { $0 != "During the past month, have you often been bothered by feeling down, depressed, or hopeless - \(sender.title.uppercased())" }
        }
    }
    
    @IBAction func takeSectionThreeCAnswer(_ sender: NSButton) {
        if sender.state == .on {
            sectionThreeAnswersArray.append("During the past month, have you often been bothered by little interest or pleasure in doing things? - \(sender.title.uppercased())")
        } else if sender.state == .off {
            sectionThreeAnswersArray = sectionThreeAnswersArray.filter { $0 != "During the past month, have you often been bothered by little interest or pleasure in doing things? - \(sender.title.uppercased())" }
        }
    }
    
}
