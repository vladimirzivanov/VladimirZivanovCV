//
//  HomeTableViewCells.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/1/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation
import UIKit

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
