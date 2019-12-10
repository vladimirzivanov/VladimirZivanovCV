//
//  SkillItemViewModel.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 06/12/2019.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation

class SkillItemViewModel {
    let title: String
    let skills: [String]

    init(title: String, skills: [String]) {
        self.title = title
        self.skills = skills
    }
}
