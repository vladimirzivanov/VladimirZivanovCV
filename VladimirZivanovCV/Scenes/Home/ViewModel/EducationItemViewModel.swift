//
//  EducationItemViewModel.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 06/12/2019.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation

class EducationItemViewModel {
    let title: String
    let dates: String
    let schoolName: String

    init(education: CVModel.Education) {
        self.title = education.specialty
        self.dates = String(education.startYear) + " - " + String(education.endYear)
        self.schoolName = education.schoolName + ", " + education.city
    }
}
