//
//  SkinGynGUDRE VC.swift
//  Physical Exam 2
//
//  Created by Fool on 1/10/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class SkinGynGUDRE_VC: NSViewController, NSTextFieldDelegate, ProcessTabProtocol {
	var selfView = NSView()
	
	

	@IBOutlet weak var skinBox: NSBox!
	@IBOutlet weak var guBox: NSBox!
	@IBOutlet weak var gynBox: NSBox!
	@IBOutlet weak var dreBox: NSBox!
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
    override func viewDidLoad() {
        super.viewDidLoad()
		//loadedViewControllers.append(self)
		selfView = self.view
        
        
        clearSkin()
        //let nc = NotificationCenter.default
        //nc.addObserver(self, selector: #selector(selectAllNormsInView), name: NSNotification.Name(rawValue: "SetAllToNorm"), object: nil)
        selectAllNormsInView()
    }
	
	@IBAction func processSkinTab(_ sender: Any) {
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
		
		resultArray.append(Skin().processSectionFrom(getActiveButtonInfoIn(view: skinBox)))
		resultArray.append(Gyn().processSectionFrom(getActiveButtonInfoIn(view: gynBox)))
		resultArray.append(GU().processSectionFrom(getActiveButtonInfoIn(view: guBox)))
		resultArray.append(DRE().processSectionFrom(getActiveButtonInfoIn(view: dreBox)))
		return resultArray.filter {$0 != ""}.joined(separator: "\n")
	}
	
	@IBAction func clearTab(_ sender: Any) {
		clearSkin()
	}
	
	func clearSkin() {
		self.view.clearControllers()
		gynBox.populateSelectionsInViewUsing(Gyn())
	}
	
	@IBAction func selectNorms(_ sender: NSButton) {
		func normalButtonRangesForSection(_ section:String) -> [Int] {
			switch section {
			case "skin", "gyn":
				return [Int](1...5)
            case "gu":
                return [Int](2...5)
			case "dre":
				return [Int](1...4)
			default:
				return [Int]()
			}
		}
		
		guard let view = sender.superview else { return }
		guard let name = (view.superview as? NSBox)?.title else { return }
		turnButtons(getButtonsInView(sender.superview!), InRange: normalButtonRangesForSection(name.lowercased()), ToState: sender.state)
	}
	
	@IBAction func selectOnlyOne(_ sender: NSButton) {
		if let buttons = sender.superview?.subviews as? [NSButton] {
			for button in buttons {
				if button.title != sender.title {
					button.state = .off
				}
			}
		}
        switchNormOff(sender)
	}
    
    @IBAction func switchNormOff(_ sender: NSButton) {
        if sender.state == .on {
            let sendingBox = (sender as NSView).getContainingBox()
            guard let sendingBoxTitle = sendingBox?.title else { return }
            //print(sendingBoxTitle)
            guard let theButtons = sendingBox?.getButtonsInView() else { return }
            
            switch sendingBoxTitle {
            case "Gyn":
                switch sender.tag {
                case 15:
                    let dtrs = theButtons.filter({$0.tag == 3})[0]
                    dtrs.state = .off
                case 12:
                    let dtrs = theButtons.filter({$0.tag == 4})[0]
                    dtrs.state = .off
                case 16:
                    let dtrs = theButtons.filter({$0.tag == 2})[0]
                    dtrs.state = .off
                case 17...19:
                    let dtrs = theButtons.filter({$0.tag == 5})[0]
                    dtrs.state = .off
                default: return
                }
            case "Skin":
                switch sender.tag {
                case 6:
                    let dtrs = theButtons.filter({$0.tag == 5})[0]
                    dtrs.state = .off
                default: return
                }
            case "GU":
                switch sender.tag {
                case 6...8:
                    let dtrs = theButtons.filter({$0.tag == 5})[0]
                    dtrs.state = .off
                case 9, 10:
                    let dtrs = theButtons.filter({$0.tag == 4})[0]
                    dtrs.state = .off
                default: return
                }
            case "DRE":
                switch sender.tag {
                case 5, 6:
                    let dtrs = theButtons.filter({$0.tag == 3})[0]
                    dtrs.state = .off
                case 9:
                    let dtrs = theButtons.filter({$0.tag == 1})[0]
                    dtrs.state = .off
                case 8:
                    let dtrs = theButtons.filter({$0.tag == 4})[0]
                    dtrs.state = .off
                default: return
                }
            default: return
            }
        }
        
    }
    
    //Trying to get the norm buttons to turn off as soon as Dawn
    //starts editing the field.  Not working
//    override func controlTextDidBeginEditing(_ obj: Notification) {
//        if let sender = obj.object as? NSTextField {
//            textSwitchNormOff(sender)
//        }
//    }
    
    @IBAction func textSwitchNormOff(_ sender: NSTextField) {
        if !sender.stringValue.isEmpty {
        let sendingBox = (sender as NSView).getContainingBox()
        guard let sendingBoxTitle = sendingBox?.title else { return }
        //print(sendingBoxTitle)
        guard let theButtons = sendingBox?.getButtonsInView() else { return }
            
            switch sendingBoxTitle {
            case "Skin":
                switch sender.tag {
                case 11:
                    let dtrs = theButtons.filter({$0.tag == 3})[0]
                    dtrs.state = .off
                case 12, 13, 16:
                    let dtrs = theButtons.filter({$0.tag == 4})[0]
                    dtrs.state = .off
                default: return
                }
            case "DRE":
                switch sender.tag {
                case 15:
                    let dtrs = theButtons.filter({$0.tag == 2})[0]
                    dtrs.state = .off
                default: return
                }
            default: return
            }
        }
    }
    
    @objc func selectAllNormsInView() {
        let normButtons = skinBox.getNormalButtonsInView() /*self.view.getNormalButtonsInView()*/
        for button in normButtons {
            button.state = .on
            selectNorms(button)
        }
    }
    
}
