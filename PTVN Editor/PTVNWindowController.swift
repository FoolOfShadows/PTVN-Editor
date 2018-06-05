//
//  PTVNWindowController.swift
//  PTVN Editor
//
//  Created by Fool on 6/5/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

final class PTVNWindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.windowFrameAutosaveName = NSWindow.FrameAutosaveName(rawValue: "myWindow")
    }
    
}

