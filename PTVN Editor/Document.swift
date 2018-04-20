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

    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController
        self.addWindowController(windowController)
    }

    override func data(ofType typeName: String) throws -> Data {
        //Write data to a file
        if let theData = viewController?.theData.saveValue, let contents = theData.data(using: String.Encoding.utf8) {
                return contents
        }
        
        //let rangeLength = theData.count
        //let textRange = NSRange(location: 0, length: rangeLength)
       
        
        
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func read(from data: Data, ofType typeName: String) throws {
        //Load data from file
        if let contents = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
            theData = PTVN(theText: contents) //Call function to create and populate a main class instance
        }
        //throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }


}

