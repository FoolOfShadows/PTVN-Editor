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
    @IBOutlet weak var handCountText: NSTextField!
    
    var handCountDiscrepency = ""
    
    weak var pillCountDelegate: PillCountDelegate?
    
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
        var totalPillsPerDay = Int()
        if let onePill = Double(wt1PillText.stringValue), let totalWeight = Double(totalPillWtText.stringValue) {
            currentCountText.stringValue = String(totalWeight/onePill)
        }
        
        if let lastFill = lastFillText.stringValue.convertStringToStandardDate(), let currentDate = currentDateText.stringValue.convertStringToStandardDate(), let fillQty = Int(lastFillQtyText.stringValue), let pillDose = Int(pillsPerDoseText.stringValue), let dayDose = Int(dosesPerDayText.stringValue) {
            totalPillsPerDay = pillDose * dayDose
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
        
        if let currentCount = Int(currentCountText.stringValue), let expectedCount = Int(expectedCountText.stringValue), let onePill = Double(wt1PillText.stringValue), let totalWeight = Double(totalPillWtText.stringValue) {
            let discrepancyValue = expectedCount - currentCount
            let varianceCount = (1.5 * Double(totalPillsPerDay)) + ((0.02 * totalWeight)/onePill)
            print("Total allowed variance: \(varianceCount)")
            discrepancyText.stringValue = String(discrepancyValue)
            if (Double(expectedCount)-varianceCount)...(Double(expectedCount)+varianceCount) ~= Double(currentCount) {
                discrepancyText.textColor = NSColor.green
            } else {
                discrepancyText.textColor = NSColor.red
            }
        }
    }
    
    
    @IBAction func processPillCount(_ sender: NSButton) {
        if discrepancyText.textColor == NSColor.green {
            pillCountDelegate?.pillCountData = "Pill count done. Results satisfactory."
        } else if discrepancyText.textColor == NSColor.red {
            if let current = Int(currentCountText.stringValue), let expected = Int(expectedCountText.stringValue) {
                if current > expected {
                    pillCountDelegate?.pillCountData = "Pill count done. More pills than expected."
                } else if current < expected {
                    pillCountDelegate?.pillCountData = "Pill count done. Fewer pills than expected."
                }
            }
            self.dismiss(self)
        }
    }
    
    @IBAction func printPillCount(_ sender: NSButton) {
        guard let name = pillCountDelegate?.ptName else { return }
        if let theHandCount = Int(handCountText.stringValue), let expectedCount = Int(expectedCountText.stringValue) {
            handCountDiscrepency = String(theHandCount - expectedCount)
        }
        print(name)
        let theText = """
        \(name)     \(currentDateText.stringValue)
        Last Filled: \(lastFillText.stringValue)     Fill Qty: \(lastFillQtyText.stringValue)
        Pills/Dose: \(pillsPerDoseText.stringValue)     Doses/Day: \(dosesPerDayText.stringValue)
        Wt 1 Pill: \(wt1PillText.stringValue)     Total Wt: \(totalPillWtText.stringValue)     Count by weight: \(currentCountText.stringValue)
        Expected Count: \(expectedCountText.stringValue)     Discrepency by weight: \(discrepancyText.stringValue)
        Hand Count: \(handCountText.stringValue)     Discrepency by hand: \(handCountDiscrepency)
"""
        print(theText)
        var fileName = createFileLabelFrom(PatientName: getFileLabellingNameFrom(name), FileType: "PILLCOUNT", date: String(Date().shortDate()))
        fileName = "\(fileName).txt"
        print(fileName)
        let pillCountFile = theText.data(using: String.Encoding.utf8)
        if (pillCountFile != nil) {
            print("There's a file")
        } else {
            print("There doesn't seem to be a file")
        }
        let newFileManager = FileManager.default
        let savePath = NSHomeDirectory()
        newFileManager.createFile(atPath: "\(savePath)/WPCMSharedFiles/zruss Review/11 Pill Count Data/\(fileName)", contents: pillCountFile, attributes: nil)
    }
}
