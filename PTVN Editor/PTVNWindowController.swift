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

protocol ScrapeScriptsOnCloseProtocol {
    func scrapeScripts(sender: NSViewController)
}

final class PTVNWindowController: NSWindowController, NSWindowDelegate, WindowCloseProtocol, CatchTimerOnCloseProtocol {
//    func scrapeScripts(sender: NSViewController) {
//        print("Hiya.  We should do something here.")
//    }
//
//    func scraping() {
//        print("Here's where we really do the work.")
//    }
    
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
        //vc.scriptScrapingDelegate = self
        
        
    }
    
    func setWindowCloseValue(_ close: Bool) {
        windowOpen = close
    }
    func visitTimerRunning(_ state: Bool) {
        timerRunning = state
    }
    
//    func windowWillClose(_ notification: Notification) {
//        if theData.plan.contains("••") {
//            print("checking for scripts")
//            scraping()
//        }
//    }
    
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

