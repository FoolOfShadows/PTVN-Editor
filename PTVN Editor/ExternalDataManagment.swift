//
//  ExternalDataManagment.swift
//  BrowserText
//
//  Created by FoolOfShadows on 6/12/24.
//  Copyright © 2024 Fool. All rights reserved.
//

import Cocoa

struct MWVPatientDateList {
    let mwvTextDataFilePath = "\(NSHomeDirectory())/\(FilePath.baseFolder.rawValue)/\(FilePath.mwvPatientDateFile.rawValue)"
    
    var mwvPatientDateDict:[String:String] { return ["":""]}
    
    func setMWVPatientDateDataFrom(_ filePath:String) -> [String:String]? {
        var rawData = String()
        var returnData = [String:String]()
        
        do {
            rawData = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
        } catch {
            let theAlert = NSAlert()
            theAlert.messageText = "Could not import the MWV Patient Date text from file at \(filePath)."
            theAlert.alertStyle = NSAlert.Style.warning
            theAlert.addButton(withTitle: "OK")
            theAlert.runModal()
            return nil
        }
        
        let dataArray = rawData.components(separatedBy: "\n")
        for item in dataArray {
            var itemArray = item.components(separatedBy: ":")
            returnData.updateValue(itemArray[1], forKey: itemArray[0])
        }
        return returnData
    }
}
