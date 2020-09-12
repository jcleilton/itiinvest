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
    
    private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let customView = DetailView()
        customView.setup()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.todaysStockUpdated = updateTodaysValue
    }
    
    func setupView() {
        customView.quantityValueLabel.text = viewModel.quantity
        customView.priceValueLabel.text = viewModel.buyPrice
        customView.buyDateValueLabel.text = viewModel.buyDate
        customView.totalValueValueLabel.text = viewModel.totalPrice
        customView.todaysPriceValueLabel.text = viewModel.todaysPrice
        customView.todaysCotationValueLabel.text = viewModel.todaysCotation
        
    }
    
    func updateTodaysValue() {
        print("atualiza as parada \(viewModel.todaysProfit)")
        
    }
    
    @IBAction func editAction(_ sender: Any) {
    }
    
    @IBAction func closeAction(_ sender: Any) {
    }
}
