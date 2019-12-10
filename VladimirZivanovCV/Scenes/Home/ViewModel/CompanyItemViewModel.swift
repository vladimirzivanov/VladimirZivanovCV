//
//  CompanyItemViewModel.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 06/12/2019.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation

class CompanyItemViewModel {
    let company: String
    let years: String
    let logo: String?
    let role: String
    let accomplishments: [String]

    init(company: CVModel.WorkExperience) {
        self.company = company.companyName
        self.years = company.startDate + " - " + company.endDate
        self.logo = company.companyLogo
        self.role = company.role
        self.accomplishments = company.accomplishments
    }
}
