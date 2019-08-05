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
        case summary
        case contactInfo = "contact_info"
        case skills
        case workExperience = "work_experience"
        case education
    }
    let name: String
    let title: String
    let summary: String
    let contactInfo: ContactInfo
    let skills: Skills
    let workExperience: [WorkExperience]
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

    struct ContactInfo: Decodable {
        let address: String
        let city: String
        let phone: String
        let email: String
    }

    struct Skills: Decodable {
        private enum CodingKeys: String, CodingKey {
            case areaOfExpertise = "area_of_expertise"
            case toolsAndTechnologies = "tools_and_technologies"
            case other
        }
        let areaOfExpertise: [String]
        let toolsAndTechnologies: [String]
        let other: [String]
    }

    struct WorkExperience: Decodable {
        private enum CodingKeys: String, CodingKey {
            case companyName = "company_name"
            case companyLogo = "company_logo"
            case startDate = "start_date"
            case endDate = "end_date"
            case role
            case accomplishments
        }
        let companyName: String
        let companyLogo: String?
        let startDate: String
        let endDate: String
        let role: String
        let accomplishments: [String]

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            companyName = try container.decode(String.self, forKey: .companyName)
            companyLogo = try container.decodeIfPresent(String.self, forKey: .companyLogo)
            startDate = try container.decode(String.self, forKey: .startDate)
            endDate = try container.decode(String.self, forKey: .endDate)
            role = try container.decode(String.self, forKey: .role)
            accomplishments = (try container.decodeIfPresent([String].self, forKey: .accomplishments)) ?? []
        }
    }
}
