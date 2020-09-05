//
//  DetailViewController.swift
//  ItiInvest
//
//  Created by Develop on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var saleDateLabel: UILabel!
    @IBOutlet weak var totalVallueLabel: UILabel!
    @IBOutlet weak var todayCote: UILabel!
    @IBOutlet weak var todayValue: UILabel!
    @IBOutlet weak var percentualValue: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var stock: Stock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func editAction(_ sender: Any) {
    }
    
    @IBAction func closeAction(_ sender: Any) {
    }
    
    func setupView() {
        closeButton.setImage(UIImage(named: "close"), for: .normal)
    }
    
    func setupAccessibility() {
        //TODO: mudar valores da acessibilidade
        quantityLabel.accessibilityLabel = "Quantidade comprada: \(100) unidades"
        quantityLabel.accessibilityHint = ""
        salePriceLabel.accessibilityLabel = "Preço de compra \(45.86) reais"
        salePriceLabel.accessibilityHint = ""
        saleDateLabel.accessibilityLabel = "Data da compra: \("13/05/2020")"
        saleDateLabel.accessibilityHint = ""
        totalVallueLabel.accessibilityLabel = "Valor total \(4586.00) reais"
        totalVallueLabel.accessibilityHint = ""
        let todayCoteValue = "" == "-" ? "" : "\(58.95)"
        todayCote.accessibilityLabel = todayCoteValue
        todayCote.accessibilityHint = ""
        let todayValueString = "" == "-" ? "" : "\(5895.00)"
        todayValue.accessibilityLabel = todayValueString
        todayValue.accessibilityHint = ""
    }
}
