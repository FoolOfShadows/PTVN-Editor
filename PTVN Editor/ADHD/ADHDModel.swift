//
//  ADHDModel.swift
//  PTVN Editor
//
//  Created by Fool on 4/10/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Foundation
struct ADHDData {
    enum ADHDQuestionEnum:String, CaseIterable {
        case project = "1. How often do you have trouble wrapping up the final details of a project once the challenging parts have been done?"
        case order = "2. How often do you have difficulty getting things in order when you have to do a task that requires organization?"
        case remembering = "3. How often do you have problems remembering appointments or obligations?"
        case delay = "4. When you have a task that requires a lot of thought, how often do you avoid or delay getting started?"
        case fidget = "5. How often do you fidget or squirm with your hands or feet when you have to sit down for a long time?"
        case compelled = "6. How often do you feel overly active and compelled to do things, like you were driven by a motor?"
        case careless = "7. How often do you make careless mistakes when you have to work on a boring or difficult project?"
        case attention = "8. How often do you have difficulty keeping your attention when you are doing boring or repetitive work?"
        case concentrating = "9. How often do you have difficulty concentrating on what people say to you, even when they are speaking to you directly?"
        case misplace = "10. How often do you misplace or have difficulty finding things at home or at work?"
        case distracted = "11. How often are you distracted by activity or noise around you?"
        case leave = "12. How often do you leave your seat in meetings or other situations in which you are expected to remain seated?"
        case restless = "13. How often do you feel restless or fidgety?"
        case unwinding = "14. How often do you have difficulty unwinding and relaxing when you ahve time to yourself?"
        case talking = "15. How often do you find yourself talking too much when you are in social situations?"
        case conversation = "16. When you're in a conversation, how often do you find yourself finishing the sentences of the people you are talking to, before they can finish them themselves?"
        case waiting = "17. How often do you have difficulty waiting your turn in situations when turn taking is required?"
        case interrupt = "18. How often do you interrupt others when they are busy?"
    }
    
    enum ADHDResultEnum:String {
        case consistent = "Adult ADHD Self-report Scale (ASRS) result shows symptoms highly consistent with ADHD."
        case inconsistent = "Adult ADHD Self-report Scale (ASRS) result shows symptoms are not significant enough to be highly consistent with ADHD."
        case mild = "  This result suggests mild impairment in function."
        case moderate = "  This result suggests moderate impairment in function."
        case severe = "  This result suggests severe impairment in function."
    }
    
    var adhdQuestions:[String] {
        var tempCases = [String]()
        ADHDQuestionEnum.allCases.forEach {tempCases.append($0.rawValue)}
        return tempCases
    }
}
