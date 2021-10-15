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

protocol CatchTimerOnCloseProtocol {
    func visitTimerRunning(_ state:Bool)
}

//protocol ScrapeScriptsOnCloseProtocol {
//    func scrapeScripts(sender: NSViewController)
//}

final class PTVNWindowController: NSWindowController, NSWindowDelegate, WindowCloseProtocol, CatchTimerOnCloseProtocol {
    
    var windowOpen: Bool = false
    var timerRunning: Bool = false
    var theData = PTVN(theText: "")
    

    override func windowDidLoad() {
        super.windowDidLoad()
        //Need this to allow the program to remember last window location when reopening
        self.windowFrameAutosaveName = "myWindow"
        
        let vc = window!.contentViewController as! ViewController
        vc.windowCloseDelegate = self
        vc.timerRunningDelegate = self
    }
    
    func setWindowCloseValue(_ close: Bool) {
        windowOpen = close
    }
    func visitTimerRunning(_ state: Bool) {
        timerRunning = state
    }
    
    //Examine certain states of the open file when the user is closing it to halt the close process and notify the user they have a process still active which needs to be manually stopped.
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        if timerRunning == true {
            let theAlert = NSAlert()
            theAlert.messageText = "You still have a visit timer running.  Please stop the timer before closing the window."
            theAlert.beginSheetModal(for: self.window!) { (NSModalResponse) -> Void in
                let returnCode = NSModalResponse
                print(returnCode)
            }
            return false
        }
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

