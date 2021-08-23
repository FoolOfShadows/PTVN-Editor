//
//  SpellChecker.swift
//  PTVN Editor
//
//  Created by Fool on 12/27/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Cocoa

struct OurSpellChecker {
    
    let basicCleaningDataFilePath = "\(NSHomeDirectory())/Sync/WPCMSharedFiles/WPCM Software Bits/00 CAUTION - Data Files/PTVN2PFCleaningDataBasic.txt"
    let otherCleaningDataFilePath = "\(NSHomeDirectory())/Resilio/WPCMSharedFiles/WPCM Software Bits/00 CAUTION - Data Files/PTVN2PFCleaningDataBasic.txt"
    
    //Set the cleaning dictionaries with the contents of the text files
    //If the text files can't be found, use the hard coded values
    var misspelledWordDict:[String:String] { return setCleaningDataFrom(basicCleaningDataFilePath) ??  setCleaningDataFrom(otherCleaningDataFilePath) ?? [
        "pvd":"peripheral vascular disease",
        "htn":"hypertension",
        "dm":"diabetes mellitus",
        "dpn":"diabetic peripheral neuropathy",
        "ckd":"chronic kidney disease",
        "afib":"atrial fibrillation",
        "otc":"over the counter",
        "rls":"restless leg syndrome",
        "cts":"carpal tunnel syndrome",
        "gerd":"gastroesophageal reflux disease",
        "copd":"chronic obstructive pulmonary disease",
        "cad":"coronary artery disease",
        "chf":"congestive heart failure",
        "dvt":"deep venous thrombosis",
        "chol":"cholesterol",
        "thy":"thyroid",
        "pt":"patient",
        "pts":"patient's"
        ]
    }
    
    
    
    func setCleaningDataFrom(_ filePath:String) -> [String:String]? {
        var rawData = String()
        var returnData = [String:String]()
        
        do {
            rawData = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
        } catch {
            let theAlert = NSAlert()
            theAlert.messageText = "Could not import the cleaning text from file at \(filePath)."
            theAlert.alertStyle = NSAlert.Style.warning
            theAlert.addButton(withTitle: "OK")
            theAlert.runModal()
            return nil
        }
        
        let dataArray = rawData.components(separatedBy: "\n")
        for item in dataArray {
            var itemArray = item.components(separatedBy: ":")
            if itemArray.count < 2 {
                itemArray.insert("", at: 1)
            }
            returnData.updateValue(itemArray[1], forKey: itemArray[0])
        }
        
        return returnData
        
    }
    
    
    
    func correctMisspelledWordsIn(_ textToClean:String) -> String {
        var correctedText = textToClean
        
        for entry in misspelledWordDict {
            let regex = try! NSRegularExpression(pattern: "\\b" + entry.key + "\\b", options: .caseInsensitive)
            correctedText = regex.stringByReplacingMatches(in: correctedText, options: [], range: NSRange(0..<correctedText.utf16.count), withTemplate: entry.value)
        }
        
//        for entry in characters {
//            let regex = try! NSRegularExpression(pattern: entry.key, options: [])
//            correctedText = regex.stringByReplacingMatches(in: correctedText, options: [], range: NSRange(0..<correctedText.utf16.count), withTemplate: entry.value)
//        }
        
        
        return correctedText
    }
}
