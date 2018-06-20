//
//  IncontinenceController.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 8/9/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

class IncontinenceController: NSViewController {

	@IBOutlet weak var dayFrequency1to7: NSButton!
	@IBOutlet weak var dayFrequency8to12: NSButton!
	@IBOutlet weak var dayFrequency13OrMore: NSButton!
	@IBOutlet weak var dayBother0: NSButton!
	@IBOutlet weak var dayBother1: NSButton!
	@IBOutlet weak var dayBother2: NSButton!
	@IBOutlet weak var dayBother3: NSButton!
	@IBOutlet weak var dayBother4: NSButton!
	@IBOutlet weak var nightFrequency0to1: NSButton!
	@IBOutlet weak var nightFrequency2to3: NSButton!
	@IBOutlet weak var nightFrequency4OrMore: NSButton!
	@IBOutlet weak var nightBother0: NSButton!
	@IBOutlet weak var nightBother1: NSButton!
	@IBOutlet weak var nightBother2: NSButton!
	@IBOutlet weak var nightBother3: NSButton!
	@IBOutlet weak var nightBother4: NSButton!
	@IBOutlet weak var rushNever: NSButton!
	@IBOutlet weak var rushOccasionally: NSButton!
	@IBOutlet weak var rushSometimes: NSButton!
	@IBOutlet weak var rushMostly: NSButton!
	@IBOutlet weak var rushAlways: NSButton!
	@IBOutlet weak var rushBother0: NSButton!
	@IBOutlet weak var rushBother1: NSButton!
	@IBOutlet weak var rushBother2: NSButton!
	@IBOutlet weak var rushBother3: NSButton!
	@IBOutlet weak var rushBother4: NSButton!
	@IBOutlet weak var leakNever: NSButton!
	@IBOutlet weak var leakOccasionally: NSButton!
	@IBOutlet weak var leakSometimes: NSButton!
	@IBOutlet weak var leakMostly: NSButton!
	@IBOutlet weak var leakAlways: NSButton!
	@IBOutlet weak var leakBother0: NSButton!
	@IBOutlet weak var leakBother1: NSButton!
	@IBOutlet weak var leakBother2: NSButton!
	@IBOutlet weak var leakBother3: NSButton!
	@IBOutlet weak var leakBother4: NSButton!
	
	var dayFreqeuncyArray: [NSButton] {return [dayFrequency1to7, dayFrequency8to12, dayFrequency13OrMore]}
	var dayBotherArray: [NSButton] {return [dayBother0, dayBother1, dayBother2, dayBother3, dayBother4]}
	var nightFrequencyArray: [NSButton] {return [nightFrequency0to1, nightFrequency2to3, nightFrequency4OrMore]}
	var nightBotherArray: [NSButton] {return [nightBother0, nightBother1, nightBother2, nightBother3, nightBother4]}
	var rushArray: [NSButton] {return [rushNever, rushOccasionally, rushSometimes, rushMostly, rushAlways]}
	var rushBotherArray: [NSButton] {return [rushBother0, rushBother1, rushBother2, rushBother3, rushBother4]}
	var leakArray: [NSButton] {return [leakNever, leakOccasionally, leakSometimes, leakMostly, leakAlways]}
	var leakBotherArray: [NSButton] {return [leakBother0, leakBother1, leakBother2, leakBother3, leakBother4]}
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
	@IBAction func takeClear(_ sender: NSButton) {
        self.view.clearControllers()
	}
	
	@IBAction func takeProcess(_ sender: NSButton) {
		var results = String()
		var resultsArray = [String]()
		resultsArray.append(processQuestion(question: .DayFrequency, answers: dayFreqeuncyArray, bothered: dayBotherArray))
		resultsArray.append(processQuestion(question: .NightFrequency, answers: nightFrequencyArray, bothered: nightBotherArray))
		resultsArray.append(processQuestion(question: .Rush, answers: rushArray, bothered: rushBotherArray))
		resultsArray.append(processQuestion(question: .Leak, answers: leakArray, bothered: leakBotherArray))
		
		if !resultsArray.isEmpty && resultsArray != ["","","",""] {
            //print(resultsArray)
            results = "Urinary incontinence screening.  Patient reports:\n" + resultsArray.filter {$0 != ""}.joined(separator: "\n")
		}
		
        theData.objective.addToExistingText(results)
        
        let firstVC = presenting as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
		
	}
	
}
