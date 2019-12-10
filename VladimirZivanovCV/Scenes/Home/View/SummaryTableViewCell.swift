//
//  SummaryTableViewCell.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 06/12/2019.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation
import UIKit

final class SummaryTableViewCell: UITableViewCell {
    @IBOutlet private var summaryLabel: UILabel!

    func bind(_ summary: String) {
        summaryLabel.text = summary
    }
}
