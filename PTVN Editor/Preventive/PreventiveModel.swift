//
//  PreventiveModel.swift
//  Medicare Wellness Exam
//
//  Created by Fool on 8/17/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

struct TrackedMeasures {
    var source:String
    var preventiveArray:[String] { return source.components(separatedBy: "\n") }
    
    var tmFLU:String {return findPrevDataFor("flu")}
    var tmPNV:String {return findPrevDataFor("pnv")}
    var tmMGM:String {return findPrevDataFor("mgm")}
    var tmPAP:String {return findPrevDataFor("pap")}
    var tmCOLO:String {return findPrevDataFor("colo")}
    var tmCOLOG:String {return findPrevDataFor("cologuard")}
    var tmDRE:String {return findPrevDataFor("dre")}
    var tmGUA:String {return findPrevDataFor("gua")}
    var tmEYE:String {return findPrevDataFor("eye")}
    var tmHIV:String {return findPrevDataFor("hiv")}
    var tmBMD:String {return findPrevDataFor("bmd")}
    
    private func findPrevDataFor(_ code:String) -> String {
        for item in preventiveArray {
            if item.lowercased().starts(with: "\(code) ") {
                let heading = "\(code.uppercased()) - "
                let dates = item.allRegexMatchesFor("(\\d*/\\d*/\\d*|\\d+/\\d+)")
                if let sortedDates = getDateFromString(dates)?.sorted() {
                    if let last = sortedDates.last {
                        //format the date
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yyyy"
                        return "Last \(heading) \(dateFormatter.string(from: last))"
                        //print("\(heading) \(dateFormatter.string(from: last))")
                    } else {
                        return "\(heading) no last date found"
                        //print("\(heading) no last date found")
                    }
                    
                }
            }
        }
        return "No last date found"
    }
}

func getPrevDataFrom(_ source:String) -> String {
    var preventiveResultsArray = [String]()
    let preventiveArray = source.components(separatedBy: "\n")
    //For the form, it may work better to identify the words/abreviations being used to separate the measures and pull out only the the measures the form is reporting on
    let prevCodes = ["flu", "pnv", "mgm", "pap", "colo", "cologuard", "dre", "gua", "eye", "hiv", "bmd"]
    

    for measure in preventiveArray {
        var dates = ["NO DATE FOUND"]
        var heading = "NO HEADING"
        //let heading = measure.simpleRegExMatch("^\\w* -|^\\w*-|^\\w* \\w* -|^\\w* \\w*-|^-.*?-")
        for code in prevCodes {
            if measure.lowercased().starts(with: "\(code) ") {
                heading = "\(code.uppercased()) - "
                dates = measure.allRegexMatchesFor("(\\d*/\\d*/\\d*|\\d+/\\d+)")
                //print(heading)
            }
        }
        
        
        print(heading)
        print(dates)
        
        if let sortedDates = getDateFromString(dates)?.sorted() {
            if let last = sortedDates.last {
                //format the date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                preventiveResultsArray.append("\(heading) \(dateFormatter.string(from: last))")
                //print("\(heading) \(dateFormatter.string(from: last))")
            } else {
                preventiveResultsArray.append("\(heading) no last date found")
                //print("\(heading) no last date found")
            }
            
        }
    }
    return preventiveResultsArray.joined(separator: "\n")
    
}
