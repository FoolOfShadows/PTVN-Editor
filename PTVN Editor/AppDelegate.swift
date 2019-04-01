//
//  AppDelegate.swift
//  PTVN Editor
//
//  Created by Fool on 4/6/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    //Tells the application not to open a blank document when it first opens
    func applicationShouldOpenUntitledFile(_ sender: NSApplication) -> Bool {
        return false
    }
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Checks if user system is Dark Mode capable and sets
        // the app to Light Mode if it is
        // FIXME: Doing this because I don't have the text fields in the various
        // modules set up to correctly handle dark mode.
        if #available(macOS 10.14, *) {
            NSApp.appearance = NSAppearance(named: .aqua)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

