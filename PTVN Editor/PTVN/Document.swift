//
//  Document.swift
//  PTVN Editor
//
//  Created by Fool on 4/6/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    
    var viewController: ViewController? {
        return windowControllers[0].contentViewController as? ViewController
    }
    
    var theData = PTVN(theText: "")
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    //Setting this to false so the document requests approval for saving after
    //any changes are made to it.
    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: "Document Window Controller") as! NSWindowController
        self.addWindowController(windowController)
    }

    //Save the data
    override func data(ofType typeName: String) throws -> Data {
        //Get the plan from the current view controller instance of the PTVN data, scrape it for refills, referrals, etc, then clear the symbols marking those items
        if let baseData = viewController?.theData {
            doScrappingOfData(theData: baseData)
            baseData.plan = theData.plan.replacingOccurrences(of: "~~", with: ""/*"DONE - "*/)
            baseData.plan = theData.plan.replacingOccurrences(of: "`~", with: ""/*"DONE - "*/)
            baseData.plan = theData.plan.replacingOccurrences(of: "``", with: ""/*"UPDATED - "*/)
            baseData.plan = theData.plan.replacingOccurrences(of: "^^", with: ""/*"UPDATED - "*/)
            baseData.plan = theData.plan.replacingOccurrences(of: "••", with: ""/*"DONE - "*/)
            viewController?.updateView()
        }
        //Finish encoding the data for saving, calling the view controllers saveValue method on the now processed data
        if let theData = viewController?.theData.saveValue, let contents = theData.data(using: String.Encoding.utf8) {
                return contents
        }
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func read(from data: Data, ofType typeName: String) throws {
        //Load data from file
        if let contents = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
            if contents.contains("#PTVNFILE#") {
                theData = PTVN(theText: contents)
            } else {
                theData.subjective = "You have tried to open an older style PTVN file or a non-PTVN text file."
            }
        }
        //Not sure how to use this error
        //throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    //Scrape marked tasks out of the PTVN and create new, secondary files in specific places for employees to act on.
    func doScrappingOfData(theData:PTVN) {
        var labelDate:String {
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyMMdd-HH-mm"
            return formatter.string(from: currentDate)
        }
        
        let scrappedScripts = theData.scrapeForScripts()
        if scrappedScripts != "" {
            let fileName = "\(getFileLabellingNameFrom(theData.ptName)) SCRIPT \(labelDate).txt"
            let saveLocation = "Sync/WPCMSharedFiles/zTina Review/01 The Script Corral"
            let finalResults = scrappedScripts
            let ptvnData = finalResults.data(using: String.Encoding.utf8)
            let newFileManager = FileManager.default
            let savePath = NSHomeDirectory()
            newFileManager.createFile(atPath: "\(savePath)/\(saveLocation)/\(fileName)", contents: ptvnData, attributes: nil)
        }
        
        let scrappedRefs = theData.scrapeForRefs()
        if scrappedRefs != "" {
            let fileName = "\(getFileLabellingNameFrom(theData.ptName)) REFSCRP \(labelDate).txt"
            let saveLocation = "Sync/WPCMSharedFiles/Scraped Data/Referrals"
            let finalResults = scrappedRefs
            let ptvnData = finalResults.data(using: String.Encoding.utf8)
            let newFileManager = FileManager.default
            let savePath = NSHomeDirectory()
            newFileManager.createFile(atPath: "\(savePath)/\(saveLocation)/\(fileName)", contents: ptvnData, attributes: nil)
        }
        
        let scrappedPMH = theData.scrapeForPMH()
        if scrappedPMH != "" {
            let fileName = "\(getFileLabellingNameFrom(theData.ptName)) PMHSCRP \(labelDate).txt"
            let saveLocation = "Sync/WPCMSharedFiles/Scraped Data/PMH Updates"
            let finalResults = scrappedPMH
            let ptvnData = finalResults.data(using: String.Encoding.utf8)
            let newFileManager = FileManager.default
            let savePath = NSHomeDirectory()
            newFileManager.createFile(atPath: "\(savePath)/\(saveLocation)/\(fileName)", contents: ptvnData, attributes: nil)
        }
    }
    
}

