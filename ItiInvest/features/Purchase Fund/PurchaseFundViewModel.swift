//
//  PurchaseFundViewModel.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

struct StockDescription: Codable {
    let symbol: String
    let name: String
    
    var description: String { "\(symbol) - \(name)" }
}

@objc
class PurchaseFundViewModel: NSObject {
    private var stock: Stock?
    private var stockDescriptions: [StockDescription] = [StockDescription(symbol: "AZUL4", name: "Azul S.A."),
                            StockDescription(symbol: "ABEV3", name: "Ambev S.A."),
                            StockDescription(symbol: "BBDC4", name: "Banco Bradesco S.A."),
                            StockDescription(symbol: "BBAS3", name: "Banco do Brasil S.A."),
                            StockDescription(symbol: "BIDI4", name: "Banco Inter S.A."),
                            StockDescription(symbol: "SANB11", name: "Banco Santander (Brasil) S.A."),
                            StockDescription(symbol: "ITSA4", name: "Itaúsa - Investimentos Itaú S.A.")]
    
    init(stock: Stock? = nil) {
        self.stock = stock
        
        super.init()
        requestTodaysPrices()
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
        Formatter.currencyFormattedFrom(string: "\(stock?.price ?? 0.0)")
    }
    
    func currencyFormattedFrom(string: String) -> String {
        Formatter.currencyFormattedFrom(string: string)
    }
    
    var stockDate: String {
        dateString(from: stock?.buyDate ?? Date())
    }
    
    var stockDescriptionsCount: Int { stockDescriptions.count }
    
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
    
    private func requestTodaysPrices() {
        Service().getSymbols() { [weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .success(let stockDescriptions):
                self.stockDescriptions = stockDescriptions
            case .failure(let error):
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
