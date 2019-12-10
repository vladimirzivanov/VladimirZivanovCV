//
//  EducationTableViewCell.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 06/12/2019.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation
import UIKit

final class EducationTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var datesLabel: UILabel!
    @IBOutlet private var schoolNameLabel: UILabel!

    func bind(_ viewModel: EducationItemViewModel) {
        titleLabel.text = viewModel.title
        datesLabel.text = viewModel.dates
        schoolNameLabel.text = viewModel.schoolName
    }
}
