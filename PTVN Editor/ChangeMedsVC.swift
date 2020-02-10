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
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        currentMedView.stringValue = currentMed
    }
    
    @IBAction func copyCurrentToChanged(_ sender: Any) {
        changedMedView.stringValue = currentMedView.stringValue
    }
    
    @IBAction func processChange(_ sender: Any) {
        if !changedMedView.stringValue.isEmpty {
            theData.plan.addToExistingText("``\(changedMedView.stringValue) (changed from \(currentMed))")
            let firstVC = presentingViewController as! MedicineReviewVC
            firstVC.returnResults(self)
            self.dismiss(self)
        }
    }
}
