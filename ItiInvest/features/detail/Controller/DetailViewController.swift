//
//  DetailViewController.swift
//  ItiInvest
//
//  Created by Develop on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, HasCustomView {
    typealias CustomView = DetailView
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var saleDateLabel: UILabel!
    @IBOutlet weak var totalVallueLabel: UILabel!
    @IBOutlet weak var todayCote: UILabel!
    @IBOutlet weak var todayValue: UILabel!
    @IBOutlet weak var percentualValue: UILabel!
    @IBOutlet weak var closeButton: UIButton!

    override func loadView() {
        let customView = DetailView()
        customView.setup()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchStockPrice()
    }
    
    fileprivate func fetchStockPrice() {
        //TODO: Colocar isso na viewModel
        Service().getStockPrice(symbol: "") { [weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .success(let price):
                DispatchQueue.main.async {
                    self.customView.todaysCotationValueLabel.text = "\(price)"
                    //TODO: Atualizar o todayVaue com o price * quantidade
                }
                
            case .failure(_):
                let alert = UIAlertController(title: "Erro!", message: "Ocorreu um erro na requisição", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (_) in
                    alert.dismiss(animated: true)
                }))
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
    }
    
    @IBAction func closeAction(_ sender: Any) {
    }
    
    func setupView() {
        
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
