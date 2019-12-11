//
//  CVModelDecodingTests.swift
//  VladimirZivanovCVTests
//
//  Created by Vladimir Zivanov on 12/11/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import XCTest
import Nimble
import Quick
@testable import VladimirZivanovCV

class CVModelDecodingTests: QuickSpec {

    override func spec() {
        describe("CVModel") {
            let jsonDecoder = JSONDecoder()

            context("when decoded from correct JSON") {
                let jsonData = dataFromJSON(withName: "correct_cv")!
                it("should be decoded correctly") {
                    do {
                        let model = try jsonDecoder.decode(CVModel.self, from: jsonData)
                        self.assertCVModelFields(model)
                    } catch {
                        fail("Could not decode: \(error)")
                    }
                }
            }
            context("when decoded from incorrect JSON") {
                let jsonData = dataFromJSON(withName: "incorrect_cv")!
                it("should throw error") {
                    expect { try jsonDecoder.decode(CVModel.self, from: jsonData) }.to(throwError())
                }
            }
        }
    }

    private func assertCVModelFields(_ model: CVModel) {
        expect(model.name) == "Vladimir Živanov"
        expect(model.title) == "iOS Developer"
        expect(model.summary) == "Test summary!"

        // contact info
        expect(model.contactInfo.address) == "Branka Radičevića 1"
        expect(model.contactInfo.city) == "Begeč"
        expect(model.contactInfo.phone) == "+381645368517"
        expect(model.contactInfo.email) == "vrza88@gmail.com"

        // skills
        expect(model.skills.areaOfExpertise) == ["iOS Development"]
        expect(model.skills.toolsAndTechnologies) == ["Swift"]
        expect(model.skills.other) == ["MVC/MVVM/MVP"]

        // work experience
        guard model.workExperience.count == 1 else {
            fail("incorrect number of items in companies section")
            return
        }

        expect(model.workExperience[0].companyName) == "Vega IT Sourcing"
        expect(model.workExperience[0].companyLogo) == "https://www.vegaitsourcing.rs/media/3045/vega-logo.png"
        expect(model.workExperience[0].startDate) == "Aug 2017"
        expect(model.workExperience[0].endDate) == "Present"
        expect(model.workExperience[0].role) == "iOS Developer"
        expect(model.workExperience[0].accomplishments) == []

        // education
        guard model.education.count == 1 else {
            fail("incorrect number of items in education section")
            return
        }

        expect(model.education[0].schoolName) == "University of Novi Sad, Faculty of Technical Sciences"
        expect(model.education[0].city) == "Novi Sad"
        expect(model.education[0].specialty) == "Bachelor in Electrical and Computer Engineering"
        expect(model.education[0].startYear) == 2007
        expect(model.education[0].endYear) == 2012
    }

}
