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
    case baseFolderPath
}

class PreferencesViewController: NSViewController {

    @IBOutlet weak var browserList: NSPopUpButton!
    @IBOutlet weak var baseFolderPathText: NSTextField!
    
    let nc = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        //let browsers = BrowserList.allCases.map { $0.rawValue }
        browserList.clearPopUpButton(menuItems: ["Safari", "Chrome", "Firefox", "Browser"])
    }
    
    override func viewWillAppear() {
        let defaults = UserDefaults.standard
        browserList.selectItem(withTitle: defaults.string(forKey: UserDefaultKeyTitles.browser.rawValue) ?? "Safari")
        baseFolderPathText.stringValue = defaults.string(forKey: UserDefaultKeyTitles.baseFolderPath.rawValue) ?? ""
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let theWindow = self.view.window {
            //This removes the ability to resize the window of a view
            //opened by a segue
            theWindow.styleMask.remove(.resizable)
        }
    }
    
    @IBAction func selectBaseFolderPath(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        let dialog = NSOpenPanel();

        dialog.title                   = "Locate WPCMSharedFiles folder";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.allowsMultipleSelection = false;
        dialog.canChooseDirectories = true;

        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file

            if (result != nil) {
                let path: String = result!.path
                baseFolderPathText.stringValue = path
                defaults.set(path, forKey: UserDefaultKeyTitles.baseFolderPath.rawValue)
                print(path)
            }
            
        } else {
            // User clicked on "Cancel"
            return
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
