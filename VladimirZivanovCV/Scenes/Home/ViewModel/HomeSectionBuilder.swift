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

        let summarySection = HomeSectionModel(items: [.summary(model.summary)])
        sections.append(summarySection)
        sections.append(makeSkillsSection())
        sections.append(makeExperienceSection())
        sections.append(makeEducationSection())
        return sections
    }

    private func makeSkillsSection() -> HomeSectionModel {
        var items: [HomeCellModelType] = []
        items.append(.skill(SkillItemViewModel(title: Strings.areaOfExpertise, skills: model.skills.areaOfExpertise)))
        items.append(.skill(SkillItemViewModel(title: Strings.toolsAndTechnologies, skills: model.skills.toolsAndTechnologies)))
        items.append(.skill(SkillItemViewModel(title: Strings.other, skills: model.skills.other)))
        return HomeSectionModel(items: items, headerTitle: Strings.skillSectionTitle)
    }

    private func makeExperienceSection() -> HomeSectionModel {
        let items = model.workExperience.map { HomeCellModelType.company(CompanyItemViewModel(company: $0)) }
        return HomeSectionModel(items: items, headerTitle: Strings.workExperienceSectionTitle)
    }

    private func makeEducationSection() -> HomeSectionModel {
        let items = model.education.map { HomeCellModelType.education(EducationItemViewModel(education: $0)) }
        return HomeSectionModel(items: items, headerTitle: Strings.educationSectionTitle)
    }
}
