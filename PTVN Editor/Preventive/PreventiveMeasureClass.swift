//
//  PreventiveMeasureClass.swift
//  PTVN Editor
//
//  Created by Fool on 12/17/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Cocoa

class PreventiveMeasure {
    var measure: String
    var suggestedDate: String
    var notDue: NSButton.StateValue
    
    init(measure: String, date:String, notDue:NSButton.StateValue) {
        self.measure = measure
        self.suggestedDate = date
        self.notDue = notDue
    }
    
    func processMeasure() -> String {
        var result = String()
        
        if self.suggestedDate != "" {
            result = "\(self.measure): \(self.suggestedDate)."
        } else if self.notDue == .on {
            result = "\(self.measure): not due."
        }
        
        return result
    }
    
//    func clearMeasure() {
//        suggestedDate.stringValue = String()
//        notDue.state = .off
//    }
    
}
