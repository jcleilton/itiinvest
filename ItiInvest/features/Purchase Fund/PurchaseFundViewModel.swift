//
//  PurchaseFundViewModel.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

class PurchaseFundViewModel {
    
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
