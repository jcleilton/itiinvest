//
//  DetailViewModel.swift
//  ItiInvest
//
//  Created by Develop on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Detail View Model
class DetailViewModel {
    
    // MARK: - Properties
    var stockDescription: String {
        guard let symbol = stock.symbol, let name = stock.name else { return "" }
        return "\(symbol) - \(name)"
    }
    
    var quantity: String { String(stock.quantity) }
    var buyPrice: String { currencyFormattedFrom(string: String(stock.price)) }
    var buyDate: String {
        guard let date = stock.buyDate else { return "xx/xx/xxxx" }
        return dateString(from: date)
    }
    var totalPrice: String { currencyFormattedFrom(string: String(Double(stock.quantity) * stock.price)) }
    
    var todaysCotation: String { currencyFormattedFrom(string: String(todaysCotationValue)) }
    var todaysPrice: String { currencyFormattedFrom(string: String(todaysPriceValue)) }
    var todaysProfit: String { return "\(NSString(format: "%.0f", todaysProfitValue))%" }
    var hadProfit: Bool { return todaysProfitValue >= 0 }
    
    var labelColor: UIColor{
        return todaysProfitValue >= 0 ? UIColor(rgb: 0x52ad06) : .black
    }
    
    weak var delegate: DetailViewControllerUIUpateDelegate?
    
    var purchaseFundViewModel: PurchaseFundViewModel { PurchaseFundViewModel(stock: stock) }
    
    // MARK: - Private Properties
    private var stock: Stock
    
    private var todaysCotationValue: Double = 0
    private var todaysPriceValue: Double = 0
    private var todaysProfitValue: Double = 0 {
        didSet {
            delegate?.shouldUpdateTodaysStock()
        }
    }
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale.init(identifier: "pt-br")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter
    }()
    
    // MARK: - Life Cycle
    init(stock: Stock) {
        self.stock = stock
        
        requestTodaysPrices()
    }
    
    // MARK: - Private Functions
    private func dateString(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    private func currencyFormattedFrom(string: String) -> String {
        let numbers = string
        .components(separatedBy:CharacterSet.decimalDigits.inverted)
        .joined()
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        let doubleValue = (Double(numbers) ?? 0) / 100
        
        return formatter.string(from: NSNumber(value: doubleValue)) ?? ""
    }
        
    private func requestTodaysPrices() {
        Service().getStockPrice(symbol: "SBSP3") { [weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .success(let price):
                self.todaysPriceValue = price
                self.todaysCotationValue = price * Double(self.stock.quantity)
                self.todaysProfitValue = 100 * self.todaysPriceValue / self.stock.price - 100
            case .failure(let error):
                self.delegate?.showAlert(errorMessage: error.localizedDescription)
            }
        }
    }
    
}
