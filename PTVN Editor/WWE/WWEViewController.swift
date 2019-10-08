//
//  WWEViewController.swift
//  LIROS
//
//  Created by Fool on 12/13/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class WWEViewController: NSViewController {

	@IBOutlet var wweTabView: NSView!
	@IBOutlet weak var firstBox: NSBox!
	@IBOutlet weak var fxBox: NSBox!
	@IBOutlet weak var thirdBox: NSBox!
	
	@IBOutlet weak var otherCancerView: NSTextField!
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
	let nc = NotificationCenter.default
	
	override func viewDidLoad() {
        super.viewDidLoad()
        setUpMenuItemsForButtonsIn(wweTabView)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }
    
	@IBAction func clearWWETab(_ sender: Any) {
		wweTabView.clearControllers()
		setUpMenuItemsForButtonsIn(wweTabView)
		WellWomanExam.fxOther = String()
	}
	
	
	@IBAction func processWWETab(_ sender: Any) {
		if !otherCancerView.stringValue.isEmpty {
			WellWomanExam.fxOther = " (\(otherCancerView.stringValue))"
		}
		
		var finalResults = [String]()
		finalResults.append(WellWomanExam().processWWEQuestionsFrom(getButtonsIn(view: firstBox)))
		finalResults.append(WellWomanExam().processFxMatricesData(getMatrixInfoFrom(fxBox)))
		finalResults.append(WellWomanExam().processWWEQuestionsFrom(getButtonsIn(view: thirdBox)))
		
        theData.subjective.addToExistingText(finalResults.joined(separator: "\n"))
        
        let firstVC = presentingViewController as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
	}
	
	func getMatrixInfoFrom(_ view: NSView) -> [(matrix:Int, selections:[Int])] {
		var results = [(matrix:Int, selections:[Int])]()
		let matrices = getMatricesIn(view: view)
		for matrix in matrices {
			let selected = getActiveCellsFromMatrix(matrix)
			if !selected.isEmpty {
				results.append((matrix:matrix.tag, selections:selected))
			}
		}
		//print("getMatrixInfoFrom: \(results)")
		return results.sorted(by: {$0.matrix < $1.matrix})
	}
	
	func setUpMenuItemsForButtonsIn(_ view: NSView) {
		for item in view.subviews {
			if item is NSPopUpButton {
				(item as! NSPopUpButton).clearPopUpButton(menuItems: WellWomanExam().getListItemsForID(item.tag))
			} else if item is NSComboBox {
				(item as! NSComboBox).clearComboBox(menuItems: WellWomanExam().getListItemsForID(item.tag))
			} else {
				setUpMenuItemsForButtonsIn(item)
			}
		}
	}
	
	@IBAction func ifYesThenNoBoxOff(_ sender: NSButton) {
		let buttons = wweTabView.getListOfButtons()
		if sender.title == "Yes" && sender.state == .on {
			let noButton = buttons.filter {$0.tag == sender.tag + 1}
			noButton[0].state = .off
		} else if sender.title == "No" && sender.state == .on {
			let yesButton = buttons.filter {$0.tag == sender.tag - 1}
			yesButton[0].state = .off
		}
	}
	
}
