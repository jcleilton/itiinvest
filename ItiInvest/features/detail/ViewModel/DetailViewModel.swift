//
//  DetailViewModel.swift
//  ItiInvest
//
//  Created by Develop on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    var quantity: String { String(stock.quantity) }
    var buyPrice: String { currencyFormattedFrom(string: String(stock.price)) }
    var buyDate: String {
        guard let date = stock.buyDate else { return "Sem data" }
        return dateString(from: date)
    }
    var totalPrice: String { currencyFormattedFrom(string: String(Double(stock.quantity) * stock.price)) }
    
    var todaysCotation: String { currencyFormattedFrom(string: String(todaysCotationValue)) }
    var todaysPrice: String { currencyFormattedFrom(string: String(todaysPriceValue)) }
    var todaysProfit: String { return "\(NSString(format: "%.0f", todaysProfitValue))%" }
    
    var todaysStockUpdated: (() -> Void)?
    
    private var stock: Stock
    
    private var todaysCotationValue: Double = 0
    private var todaysPriceValue: Double = 0
    private var todaysProfitValue: Double = 0 {
        didSet {
            todaysStockUpdated?()
        }
    }
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale.init(identifier: "pt-br")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter
    }()
    
    func dateString(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func currencyFormattedFrom(string: String) -> String {
        let numbers = string
        .components(separatedBy:CharacterSet.decimalDigits.inverted)
        .joined()
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        let doubleValue = (Double(numbers) ?? 0) / 100
        
        return formatter.string(from: NSNumber(value: doubleValue)) ?? ""
    }
        
    init(stock: Stock) {
        self.stock = stock
        
        requestTodaysPrices()
    }
    
    
    private func requestTodaysPrices() {
        Service().getStockPrice(symbol: "SBSP3") { [weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .success(let price):
                self.todaysPriceValue = price
                self.todaysCotationValue = price * Double(self.stock.quantity)
                self.todaysProfitValue = 100 * self.todaysCotationValue / self.stock.price - 100
            case .failure(_):
                break
//                let alert = UIAlertController(title: "Erro!", message: "Ocorreu um erro na requisição", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (_) in
//                    alert.dismiss(animated: true)
//                }))
//                self.present(alert, animated: true)
            }
        }
    }
    
}
