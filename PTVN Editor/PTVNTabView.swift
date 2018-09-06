//
//  PTVNTabView.swift
//  PTVN Editor
//
//  Created by Fool on 6/5/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

class PTVNTabView: NSTabView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    @IBAction func switchToTab(_ sender: NSMenuItem) {
        switch sender.title {
        case "Subjective":
            self.selectTabViewItem(at: 0)
        case "PMH":
            self.selectTabViewItem(at: 1)
        case "Objective":
            self.selectTabViewItem(at: 2)
        case "Assess/Plan":
            self.selectTabViewItem(at: 3)
        case "Meds":
            self.selectTabViewItem(at: 4)
        default:
            return
        }
    }
}
