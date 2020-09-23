//
//  PurchaseFundViewModel.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

class PurchaseFundViewModel: NSObject {
    
    private var stock: Stock?
    private var stockDescriptions: [FIRStock] { RealTimeManager.shared.symbols.sorted() }

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
        guard let symbol = stock?.symbol, let name = stock?.name else { return "" }
        return "\(symbol) - \(name)"
    }
    
    var stockAmount: String {
        "\(stock?.quantity ?? 0)"
    }
    
    var stockPrice: String {
        Formatter.currencyFormattedFrom(string: "\(stock?.price ?? 0.0)")
    }
    
    func currencyFormattedFrom(string: String) -> String {
        Formatter.currencyFormattedFrom(string: string)
    }
    
    var stockDate: String {
        dateString(from: stock?.buyDate ?? Date())
    }
    
    var stockDescriptionsCount: Int { stockDescriptions.count }
    
    var stockIndex: Int {
        guard let stock = stock else { return 0 }
        
        return stockDescriptions.firstIndex(where: { $0.symbol == stock.symbol }) ?? 0
    }
    
    func stockDescription(for row: Int) -> String {
        guard row < stockDescriptionsCount else { return "" }
        
        return stockDescriptions[row].description
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
    
    func save(quantity: String, buyDate: Date, selected stockIndex: Int, price: String) throws {
        guard let quantity = getInt(from: quantity), let price = getDoubleFrom(from: price), stockIndex < stockDescriptions.count else {
            throw StockAPIError.invalidSymbol
        }
        let name = stockDescriptions[stockIndex].name
        let symbol = stockDescriptions[stockIndex].symbol
        
        guard let stock = stock else {
            do {
                try CoreDataManager().create(
                    quantity: quantity,
                    buyDate: buyDate,
                    name: name,
                    price: price,
                    symbol: symbol)
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
            stock.symbol = symbol
            try CoreDataManager().save()
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
