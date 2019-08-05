//
//  CellViewModels.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/2/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation

class EducationCellViewModel {
    let title: String
    let dates: String
    let schoolName: String

    init(education: CVModel.Education) {
        self.title = education.specialty
        self.dates = String(education.startYear) + " - " + String(education.endYear)
        self.schoolName = education.schoolName + ", " + education.city
    }
}

class CompanyCellViewModel {
    let company: String
    let years: String
    let logo: String?
    let role: String

    init(company: CVModel.WorkExperience) {
        self.company = company.companyName
        self.years = company.startDate + " - " + company.endDate
        self.logo = company.companyLogo
        self.role = company.role
    }
}

class SkillCellViewModel {
    let title: String
    let skills: [String]

    init(title: String, skills: [String]) {
        self.title = title
        self.skills = skills
    }
}
