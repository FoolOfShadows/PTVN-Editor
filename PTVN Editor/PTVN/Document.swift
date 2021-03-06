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
        return false
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: "Document Window Controller") as! NSWindowController
        self.addWindowController(windowController)
    }

    override func data(ofType typeName: String) throws -> Data {
        //Write data to a file
        if let theData = viewController?.theData.saveValue, let contents = theData.data(using: String.Encoding.utf8) {
                return contents
        }
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func read(from data: Data, ofType typeName: String) throws {
        //Load data from file
        if let contents = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
            theData = PTVN(theText: contents)
        }
        //throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }


}

