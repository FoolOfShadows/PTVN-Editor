//
//  PillCountVC.swift
//  PTVN Editor
//
//  Created by Fool on 8/23/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Cocoa

class PillCountVC: NSViewController, NSTextFieldDelegate, NSControlTextEditingDelegate {
    @IBOutlet weak var lastFillText: NSTextField!
    @IBOutlet weak var lastFillQtyText: NSTextField!
    @IBOutlet weak var pillsPerDoseText: NSTextField!
    @IBOutlet weak var dosesPerDayText: NSTextField!
    @IBOutlet weak var wt1PillText: NSTextField!
    @IBOutlet weak var totalPillWtText: NSTextField!
    @IBOutlet weak var currentCountText: NSTextField!
    @IBOutlet weak var currentDateText: NSTextField!
    @IBOutlet weak var expectedCountText: NSTextField!
    @IBOutlet weak var discrepancyText: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastFillText.delegate = self
        lastFillQtyText.delegate = self
        pillsPerDoseText.delegate = self
        dosesPerDayText.delegate = self
        wt1PillText.delegate = self
        totalPillWtText.delegate = self
        currentCountText.delegate = self
        currentDateText.delegate = self
        expectedCountText.delegate = self
        discrepancyText.delegate = self
        
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yy"
        currentDateText.stringValue = formatter.string(from: today)
    }
    
    func controlTextDidEndEditing(_ obj: Notification) {
        if let onePill = Double(wt1PillText.stringValue), let totalWeight = Double(totalPillWtText.stringValue) {
            currentCountText.stringValue = String(totalWeight/onePill)
        }
        
        if let lastFill = lastFillText.stringValue.convertStringToStandardDate(), let currentDate = currentDateText.stringValue.convertStringToStandardDate(), let fillQty = Int(lastFillQtyText.stringValue), let pillDose = Int(pillsPerDoseText.stringValue), let dayDose = Int(dosesPerDayText.stringValue) {
            let totalPillsPerDay = pillDose * dayDose
            print("Pills/Day: \(totalPillsPerDay)")
            let userCalendar = Calendar.current

            let date1 = userCalendar.startOfDay(for: lastFill)
            let date2 = userCalendar.startOfDay(for: currentDate)
            let components = userCalendar.dateComponents([.day], from: date1, to: date2)
            guard let daysPassed = components.day else { return }
            print("Days Passed: \(daysPassed)")
            let pillsUsed = daysPassed * totalPillsPerDay
            expectedCountText.stringValue = String(fillQty - pillsUsed)
        }
        
        if let currentCount = Int(currentCountText.stringValue), let expectedCount = Int(expectedCountText.stringValue) {
            discrepancyText.stringValue = String(expectedCount - currentCount)
        }
    }
    
    
    @IBAction func processPillCount(_ sender: NSButton) {
    }
}
