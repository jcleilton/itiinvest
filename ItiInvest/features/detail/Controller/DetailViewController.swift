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
        
    private var viewModel: DetailViewModel
    
    weak var coordinator: DetailCoordinator?
    
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
        setupView()
    }
    
    func setupView() {
        customView.quantityValueLabel.text = viewModel.quantity
        customView.priceValueLabel.text = viewModel.buyPrice
        customView.buyDateValueLabel.text = viewModel.buyDate
        customView.totalValueValueLabel.text = viewModel.totalPrice
        customView.todaysPriceValueLabel.text = viewModel.todaysPrice
        customView.todaysCotationValueLabel.text = viewModel.todaysCotation
        
        customView.editButton.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        customView.closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    
    func updateTodaysValue() {
        DispatchQueue.main.async {
            self.customView.todaysCotationValueLabel.text = self.viewModel.todaysCotation
            self.customView.todaysPriceValueLabel.text = self.viewModel.todaysPrice
            self.customView.todaysProfitabilityValueLabel.text = self.viewModel.todaysProfit
        }
    }
    
    @objc func editAction() {
        dismiss(animated: true, completion: nil)
        
        coordinator?.showPurchaseFund()
    }
    
    @objc func closeAction() {
        viewModel.todaysStockUpdated = nil
        
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("deinit detail VC")
        coordinator?.childDidFinish(nil)
    }
}
