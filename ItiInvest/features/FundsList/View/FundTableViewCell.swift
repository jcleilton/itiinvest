//
//  FundTableViewCell.swift
//  ItiInvest
//
//  Created by Pericles Junor on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class FundTableViewCell: UITableViewCell {

//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var amountLabel: UILabel!
//    @IBOutlet weak var percentageLabel: UILabel!
//    @IBOutlet weak var amountTitleLabel: UILabel!
//    @IBOutlet weak var percentageTitleLabel: UILabel!
    
    static let identifier = "fundCell"

    func setup(with title: String, amount: Double, userAmount: Double) {
//        titleLabel.text = title.uppercased()
//        amountLabel.text = "R$ \(amount)"
//
//        percentageLabel.text = "\((amount * 100/userAmount).rounded())%"
        setupAccessibility()
    }

}

extension FundTableViewCell {
    func setupAccessibility() {
//        percentageTitleLabel.accessibilityLabel = ITIString.percentageTitle
//        self.accessibilityElements = [titleLabel,amountTitleLabel, amountLabel, percentageTitleLabel, percentageLabel]
    }
}
