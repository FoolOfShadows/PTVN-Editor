//
//  PreferencesViewController.swift
//  PTVN Editor
//
//  Created by Fool on 1/22/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Cocoa

enum UserDefaultKeyTitles: String {
    case browser
}

class PreferencesViewController: NSViewController {

    @IBOutlet weak var browserList: NSPopUpButton!
    
    let nc = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        //let browsers = BrowserList.allCases.map { $0.rawValue }
        browserList.clearPopUpButton(menuItems: ["Safari", "Chrome", "Firefox"])
    }
    
    override func viewWillAppear() {
        let defaults = UserDefaults.standard
        browserList.selectItem(withTitle: defaults.string(forKey: UserDefaultKeyTitles.browser.rawValue) ?? "Safari")
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }
    
    @IBAction func setBrowser(_ sender: NSPopUpButton) {
        let defaults = UserDefaults.standard
        defaults.set(browserList.titleOfSelectedItem!, forKey: UserDefaultKeyTitles.browser.rawValue)
        //print(browserList.titleOfSelectedItem!)
        //print(defaults.string(forKey: UserDefaultKeyTitles.browser.rawValue)!)
        nc.post(name: NSNotification.Name("SetBrowser"), object: nil)
    }
    
}
