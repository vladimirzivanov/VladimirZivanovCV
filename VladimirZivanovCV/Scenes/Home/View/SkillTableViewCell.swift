//
//  SkillTableViewCell.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 06/12/2019.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation
import UIKit

final class SkillTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var skillsLabel: UILabel!

    func bind(_ viewModel: SkillItemViewModel) {
        titleLabel.text = viewModel.title
        skillsLabel.text = viewModel.skills.map { "• \($0)" }.joined(separator: "\n")
    }
}
