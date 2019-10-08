//
//  ESSController.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 11/1/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

class ESSController: NSViewController {

	@IBOutlet weak var essView: NSView!

	@IBOutlet weak var sittingStack: NSStackView!
	@IBOutlet weak var tvStack: NSStackView!
	@IBOutlet weak var publicStack: NSStackView!
	@IBOutlet weak var passengerStack: NSStackView!
	@IBOutlet weak var lyingStack: NSStackView!
	@IBOutlet weak var talkingStack: NSStackView!
	@IBOutlet weak var afterLunchStack: NSStackView!
	@IBOutlet weak var carStack: NSStackView!

	
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }
	
	@IBAction func sittingNeverAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.never.rawValue)}
	@IBAction func sittingSlightAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.slight.rawValue)}
	@IBAction func sittingModerateAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.moderate.rawValue)}
	@IBAction func sittingHighAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.high.rawValue)}
	
	@IBAction func tvNeverAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.never.rawValue)}
	@IBAction func tvSlightAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.slight.rawValue)}
	@IBAction func tvModerateAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.moderate.rawValue)}
	@IBAction func tvHighAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.high.rawValue)}
	
	@IBAction func publicNeverAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.never.rawValue)}
	@IBAction func publicSlightAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.slight.rawValue)}
	@IBAction func publicModerateAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.moderate.rawValue)}
	@IBAction func publicHighAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.high.rawValue)}
	
	@IBAction func passengerNeverAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.never.rawValue)}
	@IBAction func passengerSlightAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.slight.rawValue)}
	@IBAction func passengerModerateAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.moderate.rawValue)}
	@IBAction func passengerHighAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.high.rawValue)}
	
	@IBAction func lyingNeverAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.never.rawValue)}
	@IBAction func lyingSlightAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.slight.rawValue)}
	@IBAction func lyingModerateAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.moderate.rawValue)}
	@IBAction func lyingHighAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.high.rawValue)}
	
	@IBAction func talkingNeverAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.never.rawValue)}
	@IBAction func talkingSlightAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.slight.rawValue)}
	@IBAction func talkingModerateAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.moderate.rawValue)}
	@IBAction func talkingHighAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.high.rawValue)}
	
	@IBAction func afterLunchNeverAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.never.rawValue)}
	@IBAction func afterLunchSlightAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.slight.rawValue)}
	@IBAction func afterLunchModerateAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.moderate.rawValue)}
	@IBAction func afterLunchHighAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.high.rawValue)}
	
	@IBAction func carNeverAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.never.rawValue)}
	@IBAction func carSlightAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.slight.rawValue)}
	@IBAction func carModerateAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.moderate.rawValue)}
	@IBAction func carHighAction(_ sender: NSButton) {tallyCheckbox(state: sender.state.rawValue, value: AnswerValues.high.rawValue)}
	
	
	@IBOutlet weak var scoreLabel: NSTextField!
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
	private var displayedTotal:Int {
		get {
			return Int(scoreLabel.stringValue)!
		}
		set {
			scoreLabel.stringValue = String(newValue)
		}
	}
	
	func tallyCheckbox(state:Int, value:Int) {
		var currentValue = displayedTotal
		switch state {
		case 0: currentValue = currentValue - value
		case 1: currentValue = currentValue + value
		default: break
		}
		displayedTotal = currentValue
	}
	
	func getCheckboxValueFromStackView(stackView:NSStackView) -> Int? {
		//var positiveTag:Int
		for item in stackView.subviews {
			if item is NSButton {
				let checkbox = item as? NSButton
				if checkbox?.state == .on {
					return checkbox!.tag
				}
			}
		}
		return nil
	}
	
	@IBAction func takeClear(_ sender: Any) {
		essView.clearControllers()
		scoreLabel.stringValue = "0"
	}
	
	@IBAction func takeProcess(_ sender: Any) {
		var results = String()
		let stackArray:[(NSStackView, String)] = [(sittingStack, QuestionValues.sitting.rawValue), (tvStack, QuestionValues.tv.rawValue), (publicStack, QuestionValues.inPublic.rawValue), (passengerStack, QuestionValues.passenger.rawValue), (lyingStack, QuestionValues.lying.rawValue), (talkingStack, QuestionValues.talking.rawValue), (afterLunchStack, QuestionValues.afterLunch.rawValue), (carStack, QuestionValues.car.rawValue)]
		let stackResults = getResultFromStackStringTuple(stacks: stackArray)
		
		
		if !stackResults.isEmpty {
			results = "Epworth Sleepiness Scale result is \(scoreLabel.stringValue).\n\(stackResults)"
            theData.objective.addToExistingText(results)
            theData.assessment.addToExistingText("ESS questionnaire")
		}
        
        
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
	}
	
	func getResultFromStackStringTuple(stacks:[(NSStackView, String)]) -> String {
		var result = String()
		var resultArray:[String] = []
		for stack in stacks {
			if let stackResult = getCheckboxValueFromStackView(stackView: stack.0) {
				if let answerResult = AnswerValues(rawValue: stackResult)?.essAnswerString {
					resultArray.append("\(stack.1)  \(answerResult)")
				}
			}
		}
		if !resultArray.isEmpty {
			result = resultArray.joined(separator: "\n")
		}
		return result
	}
}
