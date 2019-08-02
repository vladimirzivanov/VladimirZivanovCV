//
//  CVModel.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/2/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation

struct CVModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case title
//        case summary
//        case contactInfo = "contact_info"
//        case skills
//        case workExperience = "work_experience"
        case education
    }
    let name: String
    let title: String
    let education: [Education]
}

extension CVModel {
    struct Education: Decodable {
        private enum CodingKeys: String, CodingKey {
            case specialty
            case startYear = "start_year"
            case endYear = "end_year"
            case schoolName = "school_name"
            case city
        }
        let specialty: String
        let startYear: Int
        let endYear: Int
        let schoolName: String
        let city: String
    }
}
