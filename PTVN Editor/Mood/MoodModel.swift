//
//  MoodModel.swift
//  PTVN Editor
//
//  Created by Fool on 6/26/18.
//  Copyright © 2018 Fool. All rights reserved.
//

import Foundation

struct MoodData {
    enum sectionOneQuestionsEnum:String {
        case hyper = "... you felt so good or so hyper that other people though you were not your normal self, or you were so hyper that you got into trouble?"
        case irritable = "... you were so irritable that you shouted at people or started fights or arguments?"
        case confident = "... you felt much more self-confident than usual?"
        case sleep = "... you got much less sleep than usual and found you didn't really miss it?"
        case talkative = "... you were much more talkative and/or spoke much faster than usual?"
        case raced = "... thoughts raced through your head and/or you couldn't slow your mind down?"
        case distracted = "... you were so easily distracted by things around you that you had trouble concentrating or staying on track?"
        case energy = "... you had much more energy than usual?"
        case active = "... you were much more active and/or did many more things than usual?"
        case social = "... you were much more social or outgoing than usual -- for example, you telephoned friends in the middle of the night?"
        case sex = "... you were much more interested in sex than usual?"
        case unusual = "... you did things that were unusual for you or that other people might have thought were excessive, foolish or risky?"
        case money = "... spending money got you or your family in trouble?"
    }
    
    let sectionOneQuestions = [
        sectionOneQuestionsEnum.hyper.rawValue,
        sectionOneQuestionsEnum.irritable.rawValue,
        sectionOneQuestionsEnum.confident.rawValue,
        sectionOneQuestionsEnum.sleep.rawValue,
        sectionOneQuestionsEnum.talkative.rawValue,
        sectionOneQuestionsEnum.raced.rawValue,
        sectionOneQuestionsEnum.distracted.rawValue,
        sectionOneQuestionsEnum.energy.rawValue,
        sectionOneQuestionsEnum.active.rawValue,
        sectionOneQuestionsEnum.social.rawValue,
        sectionOneQuestionsEnum.sex.rawValue,
        sectionOneQuestionsEnum.unusual.rawValue,
        sectionOneQuestionsEnum.money.rawValue]
}
