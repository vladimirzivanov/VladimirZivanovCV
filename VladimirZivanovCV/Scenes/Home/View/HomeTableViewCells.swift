//
//  HomeTableViewCells.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/1/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

final class EducationTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var datesLabel: UILabel!
    @IBOutlet private var schoolNameLabel: UILabel!

    func bind(_ viewModel: EducationCellViewModel) {
        titleLabel.text = viewModel.title
        datesLabel.text = viewModel.dates
        schoolNameLabel.text = viewModel.schoolName
    }
}

final class CompanyTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var yearsLabel: UILabel!
    @IBOutlet private var logoImageView: UIImageView!
    @IBOutlet private var roleLabel: UILabel!
//    @IBOutlet private var accomplishmentsLabel: UILabel!

    func bind(_ viewModel: CompanyCellViewModel) {
        titleLabel.text = viewModel.company
        yearsLabel.text = viewModel.years
        logoImageView.af_cancelImageRequest()
        if let logoURL = (viewModel.logo.flatMap { URL(string: $0) }) {
            logoImageView.af_setImage(withURL: logoURL)
            logoImageView.isHidden = false
        } else {
            logoImageView.image = nil
            logoImageView.isHidden = true
        }
        roleLabel.text = viewModel.role
//        accomplishmentsLabel.text = viewModel.accomplishments.map { "• \($0)"}.joined(separator: "\n")
    }
}

final class SkillTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var skillsLabel: UILabel!

    func bind(_ viewModel: SkillCellViewModel) {
        titleLabel.text = viewModel.title
        skillsLabel.text = viewModel.skills.map { "• \($0)" }.joined(separator: "\n")
    }
}

final class SummaryTableViewCell: UITableViewCell {
    @IBOutlet private var summaryLabel: UILabel!

    func bind(_ summary: String) {
        summaryLabel.text = summary
    }
}
