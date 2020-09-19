//
//  PurchaseFundViewModel.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

@objc
class PurchaseFundViewModel: NSObject {
    private var stock: Stock?
    
    init(stock: Stock? = nil) {
        self.stock = stock
    }
    
    private var isEditing: Bool {
        stock != nil
    }
    
    var getTitle: String {
        isEditing ? LocalizableStrings.formTitleEdit.localized() : LocalizableStrings.formTitle.localized()
    }
    
    var stockName: String {
        stock?.name ?? ""
    }
    
    var stockAmount: String {
        "\(stock?.quantity ?? 0)"
    }
    
    var stockPrice: String {
        currencyFormattedFrom(string: "\(stock?.price ?? 0.0)")
    }
    
    var stockDate: String {
        dateString(from: stock?.buyDate ?? Date())
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
    
    func currencyFormattedFrom(string: String, forCurrency: Bool = true) -> String {
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
    
    func save(quantity: String, buyDate: Date, name: String, price: String) throws {
        guard let quantity = getInt(from: quantity), let price = getDoubleFrom(from: price) else {
            throw StockAPIError.invalidSymbol
        }

        guard let stock = stock else {
            do {
                try CoreDataManager().create(
                    quantity: quantity,
                    buyDate: buyDate,
                    name: name,
                    price: price)
            } catch {
                throw error
            }
            return
        }
        do {
            stock.name = name
            stock.price = price
            stock.buyDate = buyDate
            stock.quantity = Int64(quantity)
            try CoreDataManager().save(data: stock)
        } catch {
            throw error
        }
    }
    
    private func getInt(from string: String) -> Int? {
        let value = string
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: " ", with: "")
        return Int(value)
    }
    
    private func getDoubleFrom(from string: String) -> Double? {

        let currencySymbol: String = "R$"
        let numbers = string.replacingOccurrences(of: currencySymbol, with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: ",", with: "")
        if let value = Double(numbers) {
            return value / 100
        }
        return nil
    }

}
