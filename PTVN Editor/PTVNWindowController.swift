//
//  PTVNWindowController.swift
//  PTVN Editor
//
//  Created by Fool on 6/5/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

protocol WindowCloseProtocol {
    func setWindowCloseValue(_ close:Bool)
}

final class PTVNWindowController: NSWindowController, NSWindowDelegate, WindowCloseProtocol {
    
    var windowOpen: Bool = false
    
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
        //Need this to allow the program to remember last window location when reopening
        self.windowFrameAutosaveName = "myWindow"
        
        let vc = window!.contentViewController as! ViewController
        vc.windowCloseDelegate = self
        
        
    }
    
    func setWindowCloseValue(_ close: Bool) {
        windowOpen = close
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        if windowOpen == true {
            let theAlert = NSAlert()
            theAlert.messageText = "You still have a Note window open.  Please make sure to transfer any information in that window into the main window of the program and close the Note window before closing this file."
            theAlert.beginSheetModal(for: self.window!) { (NSModalResponse) -> Void in
                let returnCode = NSModalResponse
                print(returnCode)
            }
            return false
        }
        return true
    }
    
}

