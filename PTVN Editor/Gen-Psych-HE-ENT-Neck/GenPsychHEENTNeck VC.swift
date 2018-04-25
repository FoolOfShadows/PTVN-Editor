//
//  GenPsychHEENTNeck VC.swift
//  Physical Exam 2
//
//  Created by Fool on 1/5/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class GenPsychHEENTNeck_VC: NSViewController, ProcessTabProtocol {
	

	@IBOutlet weak var genBox: NSBox!
	@IBOutlet weak var psychBox: NSBox!
	@IBOutlet weak var headEyeBox: NSBox!
	@IBOutlet weak var entBox: NSBox!
	@IBOutlet weak var neckBox: NSBox!
	
	var selfView = NSView()
    
    weak var currentPTVNDelegate: ptvnDelegate?
    var theData = PTVN(theText: "")
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		//loadedViewControllers.append(self)
		selfView = self.view
        //let nc = NotificationCenter.default
        //nc.addObserver(self, selector: #selector(selectAllNormsInView), name: NSNotification.Name(rawValue: "SetAllToNorm"), object: nil)
    }
	
	@IBAction func processGenTab(_ sender: Any) {
		let results = processTab()
		//print(results)
        theData.subjective.addToExistingText(results)
        
        let firstVC = presenting as! ViewController
        firstVC.theData = theData
        currentPTVNDelegate?.returnPTVNValues(sender: self)
        self.dismiss(self)
	}
	
	func processTab() -> String {
		var resultArray = [String]()
		
		resultArray.append(General().processSectionFrom(getActiveButtonInfoIn(view: genBox)))
		resultArray.append(Psychological().processSectionFrom(getActiveButtonInfoIn(view: psychBox)))
		resultArray.append(HeadEye().processSectionFrom(getActiveButtonInfoIn(view: headEyeBox)))
		resultArray.append(ENT().processSectionFrom(getActiveButtonInfoIn(view: entBox)))
		resultArray.append(Neck().processSectionFrom(getActiveButtonInfoIn(view: neckBox)))
		
		return resultArray.filter {$0 != ""}.joined(separator: "\n")
		
	}
	
	
	@IBAction func clearTab(_ sender: Any) {
		clearGen()
	}
	
	func clearGen() {
		self.view.clearControllers()
	}
	
	@IBAction func selectNorms(_ sender: NSButton) {
		func normalButtonRangesForSection(_ section:String) -> [Int] {
			switch section {
			case "gen", "psy":
				return [Int](1...4)
			case "head/eye":
				return [Int](1...5)
			case "neck":
				return [Int](1...6)
			case "ent":
				return [1,2,40,41,20]
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
        if sender.state != .off {
            
            let sendingBox = (sender as NSView).getContainingBox()
            guard let sendingBoxTitle = sendingBox?.title else { return }
            print(sendingBoxTitle)
            guard let theButtons = sendingBox?.getButtonsInView() else { return }
            
            switch sendingBoxTitle {
            case "Gen":
                switch sender.tag {
                case 5:
                    theButtons.filter({$0.tag == 1})[0].state = .off
                case 10...12:
                    theButtons.filter({$0.tag == 2})[0].state = .off
                case 8, 9:
                    theButtons.filter({$0.tag == 4})[0].state = .off
                default: return
                }
            case "Psy":
                switch sender.tag {
                case 5...8:
                    theButtons.filter({$0.tag == 1})[0].state = .off
                case 9...11:
                    theButtons.filter({$0.tag == 2})[0].state = .off
                case 17...20:
                    theButtons.filter({$0.tag == 3})[0].state = .off
                    theButtons.filter({$0.tag == 4})[0].state = .off
                default: return
                }
            case "Head/Eye":
                switch sender.tag {
                case 6, 7, 11, 12:
                    theButtons.filter({$0.tag == 5})[0].state = .off
                case 8, 13:
                    theButtons.filter({$0.tag == 4})[0].state = .off
                default: return
                }
            case "ENT":
                switch sender.tag {
                case 3:
                    theButtons.filter({$0.tag == 1})[0].state = .off
                case 10...15:
                    theButtons.filter({$0.tag == 2})[0].state = .off
                case 16, 17:
                    theButtons.filter({$0.tag == 1})[0].state = .off
                case 26...35:
                    theButtons.filter({$0.tag == 20})[0].state = .off
                case 50...53:
                    theButtons.filter({$0.tag == 40})[0].state = .off
                case 42...45:
                    theButtons.filter({$0.tag == 41})[0].state = .off
                default: return
                }
            case "Neck":
                switch sender.tag {
                case 7...10:
                    theButtons.filter({$0.tag == 2})[0].state = .off
                case 11:
                    theButtons.filter({$0.tag == 4})[0].state = .off
                case 12:
                    theButtons.filter({$0.tag == 6})[0].state = .off
                case 13, 14:
                    theButtons.filter({$0.tag == 3})[0].state = .off
                default: return
                }
            default: return
            }
        }
        
    }
    
    @objc func selectAllNormsInView() {
        let normButtons = self.view.getNormalButtonsInView()
        for button in normButtons {
            button.state = .on
            selectNorms(button)
        }
    }

}


