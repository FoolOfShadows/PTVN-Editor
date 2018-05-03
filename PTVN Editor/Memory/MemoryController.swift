//
//  MemoryController.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 8/19/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

class MemoryController: NSViewController {

	@IBOutlet weak var rememberingNever: NSButton!
	@IBOutlet weak var rememberingRarely: NSButton!
	@IBOutlet weak var rememberingSometimes: NSButton!
	@IBOutlet weak var rememberingOften: NSButton!
	@IBOutlet weak var rememberingVeryOften: NSButton!
	@IBOutlet weak var memoryMuchBetter: NSButton!
	@IBOutlet weak var memoryALittleBetter: NSButton!
	@IBOutlet weak var memoryAboutTheSame: NSButton!
	@IBOutlet weak var memoryALittleWorse: NSButton!
	@IBOutlet weak var memoryMuchWorse: NSButton!
	@IBOutlet weak var forgettingNamesYes: NSButton!
	@IBOutlet weak var forgettingNamesNo: NSButton!
	@IBOutlet weak var forgettingNamesDontKnow: NSButton!
	@IBOutlet weak var recentEventsYes: NSButton!
	@IBOutlet weak var recentEventsNo: NSButton!
	@IBOutlet weak var recentEventsDontKnow: NSButton!
	@IBOutlet weak var wordsYes: NSButton!
	@IBOutlet weak var wordsNo: NSButton!
	@IBOutlet weak var wordsDontKnow: NSButton!
	@IBOutlet weak var misplacingYes: NSButton!
	@IBOutlet weak var misplacingNo: NSButton!
	@IBOutlet weak var misplacingDontKnow: NSButton!
	@IBOutlet weak var historyYes: NSButton!
	@IBOutlet weak var historyNo: NSButton!
	@IBOutlet weak var smokeYes: NSButton!
	@IBOutlet weak var smokeNo: NSButton!
	@IBOutlet weak var drinkYes: NSButton!
	@IBOutlet weak var drinkNo: NSButton!
	@IBOutlet weak var coffeeYes: NSButton!
	@IBOutlet weak var coffeeNo: NSButton!
	@IBOutlet weak var chronicDiseaseYes: NSButton!
	@IBOutlet weak var chronicDiseaseNo: NSButton!
	@IBOutlet weak var certainMedsYes: NSButton!
	@IBOutlet weak var certainMedsNo: NSButton!
	
	var troubleRemembering:TroubleRemembering {return TroubleRemembering(never: rememberingNever, rarely: rememberingRarely, sometimes: rememberingSometimes, often: rememberingOften, veryOften: rememberingVeryOften)}
	var memoryBetterWorse:MemoryWorse {return MemoryWorse(muchBetter: memoryMuchBetter, littleBetter: memoryALittleBetter, theSame: memoryAboutTheSame, littleWorse: memoryALittleWorse, muchWorse: memoryMuchWorse)}
	var forgettingNames:YesNoQuestion {return YesNoQuestion(question: .ForgettingNames, yesButton: forgettingNamesYes, noButton: forgettingNamesNo, dontKnowButton: forgettingNamesDontKnow)}
	var recentEvents:YesNoQuestion {return YesNoQuestion(question: .RecentEvents, yesButton: recentEventsYes, noButton: recentEventsNo, dontKnowButton: recentEventsDontKnow)}
	var searchingForWords:YesNoQuestion {return YesNoQuestion(question: .Words, yesButton: wordsYes, noButton: wordsNo, dontKnowButton: wordsDontKnow)}
	var misplacingItems:YesNoQuestion {return YesNoQuestion(question: .Misplacing, yesButton: misplacingYes, noButton: misplacingNo, dontKnowButton: misplacingDontKnow)}
	var familyHistory:YesNoQuestion {return YesNoQuestion(question: .History, yesButton: historyYes, noButton: historyNo, dontKnowButton: nil)}
	var smoking:YesNoQuestion {return YesNoQuestion(question: .Smoker, yesButton: smokeYes, noButton: smokeNo, dontKnowButton: nil)}
	var drinking:YesNoQuestion {return YesNoQuestion(question: .Drinker, yesButton: drinkYes, noButton: drinkNo, dontKnowButton: nil)}
	var coffeDrinking:YesNoQuestion {return YesNoQuestion(question: .Coffee, yesButton: coffeeYes, noButton: coffeeNo, dontKnowButton: nil)}
	var disease:YesNoQuestion {return YesNoQuestion(question: .Disease, yesButton: chronicDiseaseYes, noButton: chronicDiseaseNo, dontKnowButton: nil)}
	var medications:YesNoQuestion {return YesNoQuestion(question: .Medication, yesButton: certainMedsYes, noButton: certainMedsNo, dontKnowButton: nil)}
	var yesNoQuestionArray:[YesNoQuestion] {return [forgettingNames, recentEvents, searchingForWords, misplacingItems, familyHistory, smoking, drinking, coffeDrinking, disease, medications]}
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
	
	@IBAction func takeProcessMemory(_ sender: NSButton) {
		var finalResultsArray = [String]()
		let rememberingResults = troubleRemembering.processTroubleRemembering()
		if !rememberingResults.isEmpty {
			finalResultsArray.append(rememberingResults)
		}
		let betterWorseResults = memoryBetterWorse.processMemoryWorse()
		if !betterWorseResults.isEmpty {
			finalResultsArray.append(betterWorseResults)
		}
		let yesNoArrayResults = processYesNoArray(array: yesNoQuestionArray)
		if !yesNoArrayResults.isEmpty {
			finalResultsArray.append(yesNoArrayResults)
		}
		
		if !finalResultsArray.isEmpty {
			let finalResult = "Memory screen results:\n\(finalResultsArray.joined(separator: "\n"))"
            
            theData.objective.addToExistingText(finalResult)
            
            let firstVC = presenting as! ViewController
            firstVC.theData = theData
            currentPTVNDelegate?.returnPTVNValues(sender: self)
            self.dismiss(self)
		}
	}
    
	@IBAction func takeClearMemory(_ sender: NSButton) {
		troubleRemembering.clearTroubleRemembering()
		memoryBetterWorse.clearMemoryWorse()
		for item in yesNoQuestionArray {
			item.clearYesNoQuestion()
		}
	}
}
