//
//  FundsListViewController.swift
//  ItiInvest
//
//  Created by Pericles Junor on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class FundsListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var backgroundGradientView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var hideAmountButton: UIButton!
    @IBOutlet weak var patrimonyLabel: UILabel!
    @IBOutlet weak var newInvestmentButton: UIButton!
    
    
    // MARK: - Parameters

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {

        tableView.delegate = self
        tableView.dataSource = self

        let gradient = CAGradientLayer()

        gradient.frame = backgroundGradientView.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]

        view.layer.insertSublayer(gradient, at: 0)
        
        self.newInvestmentButton.applyGradient(color1: ITIColor.orange, color2: ITIColor.purple, locations: [0.0, 1.0])
        self.newInvestmentButton.applyCornerRadius()
        
    }
    
    private func setupAccessibility() {
        hideAmountButton.accessibilityLabel = LocalizableStrings.hideShowButton.localized()
    }

    
}

extension FundsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FundTableViewCell.identifier) as? FundTableViewCell else { return UITableViewCell() }

        cell.setup(with: "ITSA4", amount: 2000, percentage: 16)

        return cell
    }
}
