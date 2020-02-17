//
//  ChangeMedsVC.swift
//  PTVN Editor
//
//  Created by Fool on 2/6/20.
//  Copyright © 2020 Fool. All rights reserved.
//

import Cocoa

class ChangeMedsVC: NSViewController {
    @IBOutlet weak var currentMedView: NSTextField!
    @IBOutlet weak var changedMedView: NSTextField!
    
    var currentMed = String()
    var theData = PTVN(theText: "")
    
    weak var currentChangeMedDelegate: ChangeMedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let theWindow = self.view.window {
            theWindow.title = "Medicine Changes"
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
            //This makes the window float at the front of the other windows
//            theWindow.level = .floating
//            theWindow.setFrameUsingName("builderWindow")
//            theWindow.windowController!.windowFrameAutosaveName = "builderWindow"
        }
    }
    
    override func viewDidAppear() {
        currentMedView.stringValue = currentMed
    }
    
    @IBAction func copyCurrentToChanged(_ sender: Any) {
        changedMedView.stringValue = currentMedView.stringValue
    }
    
    @IBAction func addToMedList(_ sender: NSButton) {
        if !changedMedView.stringValue.isEmpty {
            switch sender.title {
            case "Add To ML":
                theData.plan.addToExistingText("``\(changedMedView.stringValue) (changed from \(currentMed))")
            case "Rx & Add":
                theData.plan.addToExistingText("`~\(changedMedView.stringValue) (changed from \(currentMed))")
            default:
                return
            }
            let firstVC = presentingViewController as! MedicineReviewVC
            firstVC.returnChangedMeds()
            self.dismiss(self)
        }
    }
}
