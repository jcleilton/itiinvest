//
//  PurchaseFundViewModel.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

class PurchaseFundViewModel {
    
    var isEditing: Bool
    var stock: Stock
    var dateString: String {
        return dateString(from: stock.buyDate)
    }
    
    init(stock: Stock? = nil) {
        guard let stock = stock else {
            self.stock = Stock(name: "",
                               amount: 0,
                               price: 0.0,
                               buyDate: Date())
            isEditing = false
            return
        }
        
        isEditing = true
        self.stock = stock
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
    
}
