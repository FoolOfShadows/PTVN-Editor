//
//  NoteWindowVC.swift
//  PTVN Editor
//
//  Created by Fool on 12/6/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Cocoa

class NoteWindowVC: NSViewController {
    @IBOutlet weak var noteScrollView: NSScrollView!
    
    var notes: NSTextView {
        get {
            return noteScrollView.contentView.documentView as! NSTextView
        }
    }
    
    weak var currentNoteDelegate: notesDelegate?
    var noteText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Set up the font settings for the text views
        let theUserFont:NSFont = NSFont.systemFont(ofSize: 18)
        let fontAttributes = NSDictionary(object: theUserFont, forKey: kCTFontAttributeName as! NSCopying)
        notes.typingAttributes = fontAttributes as! [NSAttributedString.Key : Any]
        currentNoteDelegate?.noteWindowOpen = true
        
    }
    
    override func viewDidAppear() {
        //Have to wait for the view to appear to be able to pass the window back to the delegate
        currentNoteDelegate?.noteWindow = self.view.window
    }
    
    @IBAction func addToAssessment(_ sender: Any) {
        print(notes.string)
//        theData.objective.addToExistingText(notes.string)
        
        if !notes.string.isEmpty {
            self.currentNoteDelegate?.updateSubjectiveWithNotes(notes.string)
            //currentNoteDelegate?.noteText = notes.string
        }
        self.view.window?.close()
    }
    
    override func viewWillDisappear() {
        currentNoteDelegate?.noteWindowOpen = false
    }
    
}
