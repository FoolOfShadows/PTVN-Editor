//
//  ViewController.swift
//  PTVN Editor
//
//  Created by Fool on 4/6/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate, NSTextFieldDelegate {

    @IBOutlet weak var ccView: NSTextField!
    @IBOutlet var rosView: NSTextView!
    @IBOutlet var subjectiveView: NSTextView!
    @IBOutlet var preventiveView: NSTextView!
    @IBOutlet var pmhView: NSTextView!
    @IBOutlet var nutritionView: NSTextView!
    @IBOutlet var socialView: NSTextView!
    @IBOutlet var familyView: NSTextView!
    @IBOutlet var allergyView: NSTextView!
    @IBOutlet var medsView: NSTextView!
    @IBOutlet var vitalsView: NSTextView!
    @IBOutlet var objectiveView: NSTextView!
    @IBOutlet var pshView: NSTextView!
    @IBOutlet var diagnosesView: NSTextView!
    @IBOutlet var planView: NSTextView!
    
    
    var theData = PTVN(theText: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let theUserFont:NSFont = NSFont.systemFont(ofSize: 18)
        let fontAttributes = NSDictionary(object: theUserFont, forKey: kCTFontAttributeName as! NSCopying)
        allergyView.typingAttributes = fontAttributes as! [NSAttributedStringKey : Any]
        
        ccView.delegate = self
        medsView.delegate = self
        rosView.delegate = self
        subjectiveView.delegate = self
        preventiveView.delegate = self
        pmhView.delegate = self
        nutritionView.delegate = self
        socialView.delegate = self
        familyView.delegate = self
        allergyView.delegate = self
        medsView.delegate = self
        vitalsView.delegate = self
        objectiveView.delegate = self
        pshView.delegate = self
        diagnosesView.delegate = self
        planView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear() {
        let document = self.view.window?.windowController?.document as! Document
        theData = document.theData
        print("Prev: \(theData.preventive)")
        medsView.string = theData.medicines
        allergyView.string = theData.allergies
        //ccView..string = theData.
        rosView.string = theData.ros
        //subjectiveView.string = theData.
        print(theData.preventive)
        preventiveView.string = theData.preventive
        pmhView.string = theData.pmh
        nutritionView.string = theData.nutrition
        socialView.string = theData.social
        familyView.string = theData.family
        //vitalsView.string = theData.
        //objectiveView.string = theData.
        pshView.string = theData.psh
        //diagnosesView..string = theData.
        //planView..string = theData.
    }

    func textDidChange(_ notification: Notification) {
        guard let theView = notification.object as? NSTextView else { return }
        updateVarForView(theView)
    }
    
    func updateVarForView(_ view:NSTextView) {
        switch view {
        case medsView:
            theData.medicines = medsView.string
            print(theData.medicines)
        case rosView:
            theData.ros = rosView.string
//        case subjectiveView:
//            theData.ros = rosView.string
        case preventiveView:
            theData.preventive = preventiveView.string
        case pmhView:
            theData.pmh = pmhView.string
        case nutritionView:
            theData.nutrition = nutritionView.string
        case socialView:
            theData.social = socialView.string
        case familyView:
            theData.family = familyView.string
        case allergyView:
            theData.allergies = allergyView.string
//        case vitalsView:
//            theData.ros = rosView.string
//        case objectiveView:
//            theData.ros = rosView.string
        case pshView:
            theData.psh = pshView.string
//        case diagnosesView:
//            theData.ros = rosView.string
//        case planView:
//            theData.ros = rosView.string
        default: return
        }
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

