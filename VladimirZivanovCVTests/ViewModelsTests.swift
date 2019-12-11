//
//  EducationItemViewModelTests.swift
//  VladimirZivanovCVTests
//
//  Created by Vladimir Zivanov on 07/12/2019.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import XCTest
import RxSwift
import Quick
import Nimble
@testable import VladimirZivanovCV

class ViewModelsTests: QuickSpec {
    var vm: EducationItemViewModel!
    
    override func spec() {
        describe("view model") {
            context("") {
                let service = ServiceMock()
                let viewModel = HomeViewModel(service: service)

                it("should retrieve data") {
                    let disposeBag = DisposeBag()

                    viewModel.getCV()

                    waitUntil { done in
                        viewModel.sections.drive(onNext: { sections in
                            done()
                            self.assertSectionModels(sections)
                        }).disposed(by: disposeBag)
                    }
                }
            }
        }
    }

    private func assertSectionModels(_ sections: [HomeSectionModel]) {
        guard sections.count == 4 else {
            fail("Incorrect number of sections")
            return
        }

        func assertSummarySection(_ section: HomeSectionModel) {
            expect(section.headerTitle).to(beNil())
            guard let item = section.items.first else {
                fail("Incorrect number of items in summary section")
                return
            }
            expect(section.items.count) == 1
            switch item {
            case .summary(let summary):
                expect(summary) == "Test summary!"
            default:
                fail("incorrect item type in summary section")
            }
        }

        func assertSkillSection(_ section: HomeSectionModel) {
            expect(section.headerTitle).toNot(beNil())
            guard let item = section.items.first else {
                fail("Incorrect number of items in skills section")
                return
            }
            expect(section.items.count) == 3
            switch item {
            case .skill(let viewModel):
                expect(viewModel.title) == Strings.areaOfExpertise
                guard let skill = viewModel.skills.first else {
                    fail("Incorrect number of skills in area_of_expertise")
                    return
                }
                expect(skill) == "iOS Development"
            default:
                fail("incorrect item type in summary section")
            }
        }

        func assertCompanySection(_ section: HomeSectionModel) {
            expect(section.headerTitle).toNot(beNil())
            guard let item = section.items.first else {
                fail("Incorrect number of items in companies section")
                return
            }
            expect(section.items.count) == 1
            switch item {
            case .company(let viewModel):
                expect(viewModel.company) == "Vega IT Sourcing"
                expect(viewModel.role) == "iOS Developer"
                expect(viewModel.years) == "Aug 2017 - Present"
            default:
                fail("incorrect item type in summary section")
            }
        }

        func assertEducationSection(_ section: HomeSectionModel) {
            expect(section.headerTitle).toNot(beNil())
            guard let item = section.items.first else {
                fail("Incorrect number of items in educations section")
                return
            }
            expect(section.items.count) == 1
            switch item {
            case .education(let viewModel):
                expect(viewModel.schoolName) == "University of Novi Sad, Faculty of Technical Sciences, Novi Sad"
                expect(viewModel.title) == "Bachelor in Electrical and Computer Engineering"
                expect(viewModel.dates) == "2007 - 2012"
            default:
                fail("incorrect item type in summary section")
            }
        }

        assertSummarySection(sections[0])
        assertSkillSection(sections[1])
        assertCompanySection(sections[2])
        assertEducationSection(sections[3])
    }

}

private class ServiceMock: CVServiceProtocol {
    func getCV() -> Observable<DecodableResponse<CVModel>> {
        guard let data = dataFromJSON(withName: "correct_cv"),
            let model = try? JSONDecoder().decode(CVModel.self, from: data) else {
                fatalError()
        }
        return Observable.just(DecodableResponse(data: data, model: model))
    }
}
