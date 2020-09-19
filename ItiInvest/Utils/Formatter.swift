//
//  Formatter.swift
//  ItiInvest
//
//  Created by Cleilton Feitosa on 19/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

struct Formatter {
    static func currencyFormattedFrom(string: String, forCurrency: Bool = true) -> String {
        let currencySymbol: String = "R$"
        let numbers = string
            .replacingOccurrences(of: currencySymbol, with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: ",", with: "")
        
        let doubleValue: Double = (Double(Int(numbers) ?? 0)).rounded(FloatingPointRoundingRule.down) / 100
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        let value = forCurrency ? (formatter.string(from: NSNumber(value: doubleValue)) ?? "")
            : (formatter.string(from: NSNumber(value: doubleValue)) ?? "")
                .replacingOccurrences(of: currencySymbol, with: "")
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: ",", with: "")
        return value
    }
    
    static func currencyStringFromDouble(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        let valueStr = (formatter.string(from: NSNumber(value: value)))
        return valueStr ?? "–"
    }
    
    static func decimalStringFromDouble(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "pt_BR")
        let valueStr = (formatter.string(from: NSNumber(value: value)))
        return valueStr ?? "–"
    }
}
