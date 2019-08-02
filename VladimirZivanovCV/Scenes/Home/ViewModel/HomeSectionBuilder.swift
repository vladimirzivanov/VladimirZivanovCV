//
//  HomeSectionBuilder.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/2/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation

struct HomeSectionBuilder {
    let model: CVModel

    func makeSections() -> [HomeSectionModel] {
        var sections: [HomeSectionModel] = []

//        let summarySection = CVSectionModel(items: [.summary(model.summary)])
//        sections.append(summarySection)
//        sections.append(makeSkillsSection())
//        sections.append(makeExperienceSection())
        sections.append(makeEducationSection())
        return sections
    }

    private func makeEducationSection() -> HomeSectionModel {
        let items = model.education.map { HomeCellModelType.education(EducationCellViewModel(education: $0)) }
        return HomeSectionModel(items: items, headerTitle: Strings.educationSectionTitle)
    }
}
