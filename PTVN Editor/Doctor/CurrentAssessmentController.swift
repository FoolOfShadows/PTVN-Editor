//
//  CurrentAssessmentController.swift
//  LIROS
//
//  Created by Fool on 1/2/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class CurrentAssessmentController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
	
	@IBOutlet weak var currentAssessmentTableView: NSTableView!
	
	var assessmentString = String()
	var assessmentArray = [String]()
	var chosenAssessments = [String]()
	
	weak var assessmentReloadDelegate: assessmentTableDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.currentAssessmentTableView.delegate = self
		self.currentAssessmentTableView.dataSource = self
		//assessmentString = cleanArray()
		assessmentArray = getArrayFrom(assessmentString)
		self.currentAssessmentTableView.reloadData()
	}
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		return assessmentArray.count
	}
	
	func getArrayFrom(_ assessmentString:String) -> [String] {
		var returnArray = assessmentString.components(separatedBy: "\n").filter { $0 != "" && $0 != "  "}
		returnArray = returnArray.map { $0.replacingOccurrences(of: "- ", with: "") }
		returnArray = returnArray.map {$0.removeWhiteSpace()}
		
		return returnArray
	}
	
	//Set up the tableview with the data from the assmentArray array
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		var result:NSTableCellView
		result = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as! NSTableCellView
		result.textField?.stringValue = assessmentArray[row]
		
		return result
	}
	
	@IBAction func getDataFromSelectedRow(_ sender:Any) {
		let currentRow = currentAssessmentTableView.row(for: sender as! NSView)
		if (sender as! NSButton).state == .on {
			chosenAssessments.append(assessmentArray[currentRow])
		} else if (sender as! NSButton).state == .off {
			chosenAssessments = chosenAssessments.filter { $0 != assessmentArray[currentRow] }
		}
	}
	
	func cleanArray() -> String {
		var results = assessmentString
//		for item in unwantedBits {
//			results = results.replacingOccurrences(of: item, with: "")
//		}
		return results
	}
	
	
	@IBAction func returnResults(_ sender:Any) {
		let firstVC = presentingViewController as! DoctorViewController
		firstVC.assessmentList += chosenAssessments
		assessmentReloadDelegate?.currentAssessmentWillBeDismissed(sender: self)
		self.dismiss(self)
	}
	
	
}
