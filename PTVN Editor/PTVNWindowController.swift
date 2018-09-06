//
//  PTVNWindowController.swift
//  PTVN Editor
//
//  Created by Fool on 6/5/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

final class PTVNWindowController: NSWindowController/*, NSWindowDelegate*/ {
    let nc = NotificationCenter.default
    override func windowDidLoad() {
        super.windowDidLoad()
        //Need this to allow the program to remember last window location when reopening
        self.windowFrameAutosaveName = "myWindow"
    }
    
//    func windowWillMiniaturize(_ notification: Notification) {
//        //NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)
//        nc.post(name: NSNotification.Name("updateVars"), object: nil)
//    }
//    func windowDidDeminiaturize(_ notification: Notification) {
//        print("Posting maximize message")
//        nc.post(name: NSNotification.Name("updateView"), object: nil)
//    }
    
}

