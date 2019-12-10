//
//  CompanyTableViewCell.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 06/12/2019.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

final class CompanyTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var yearsLabel: UILabel!
    @IBOutlet private var logoImageView: UIImageView!
    @IBOutlet private var roleLabel: UILabel!
    @IBOutlet private var accomplishmentsLabel: UILabel!

    func bind(_ viewModel: CompanyItemViewModel) {
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
        accomplishmentsLabel.text = viewModel.accomplishments.map { "• \($0)"}.joined(separator: "\n")
    }
}
