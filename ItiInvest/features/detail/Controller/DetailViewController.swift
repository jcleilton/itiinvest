//
//  DetailViewController.swift
//  ItiInvest
//
//  Created by Develop on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

// MARK: - UI Update Delegate
protocol DetailViewControllerUIUpateDelegate: class {
    func shouldUpdateTodaysStock()
}

// MARK: - Detail View Controller
class DetailViewController: UIViewController, HasCustomView {
    typealias CustomView = DetailView
        
    // MARK: - Private Properties
    private var viewModel: DetailViewModel
    
    // MARK: - Public Properties
    weak var coordinator: DetailCoordinator?
    
    // MARK: - VC Life Cycle
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
        viewModel.delegate = self
        setupView()
    }
    
    deinit {
        coordinator?.childDidFinish(nil)
    }
    
    // MARK: - Private Functions
    private func setupView() {
        customView.quantityValueLabel.text = viewModel.quantity
        customView.priceValueLabel.text = viewModel.buyPrice
        customView.buyDateValueLabel.text = viewModel.buyDate
        customView.totalValueValueLabel.text = viewModel.totalPrice
        customView.todaysPriceValueLabel.text = viewModel.todaysPrice
        customView.todaysCotationValueLabel.text = viewModel.todaysCotation
        
        customView.editButton.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        customView.closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    
    private func updateTodaysValue() {
        DispatchQueue.main.async {
            self.customView.todaysCotationValueLabel.text = self.viewModel.todaysCotation
            self.customView.todaysCotationValueLabel.textColor = self.viewModel.hadProfit ? ITIColor.green : ITIColor.red
            self.customView.todaysPriceValueLabel.text = self.viewModel.todaysPrice
            self.customView.todaysPriceValueLabel.textColor = self.viewModel.hadProfit ? ITIColor.green : ITIColor.red
            self.customView.todaysProfitabilityValueLabel.text = self.viewModel.todaysProfit
            self.customView.todaysProfitabilityValueLabel.textColor = self.viewModel.hadProfit ? ITIColor.green : ITIColor.red
        }
    }
    
    @objc private func editAction() {
        dismiss(animated: true, completion: nil)
        
        coordinator?.showPurchaseFund()
    }
    
    @objc private func closeAction() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UI Update Extension
extension DetailViewController: DetailViewControllerUIUpateDelegate {
    func shouldUpdateTodaysStock() {
        updateTodaysValue()
    }
}
