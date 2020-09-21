//
//  CoreDataManagerMocked.swift
//  ItiInvestTests
//
//  Created by Cleilton Feitosa on 19/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation
@testable import ItiInvest
import CoreData

class CoreDataManagerMocked: CoreDataManagerProtocol {
    func getStocks() -> [Stock] {
        stocks
    }
    
    var total: Int {
        stocks.count
    }
    
    func getStockAt(_ indexPath: IndexPath) -> Stock {
        stocks[indexPath.row]
    }
    
    private var stocks: [Stock] {
        var stocks = [Stock]()
        for index in [1...5] {
            let stock = Stock(context: context)
            stock.name = "Test\(index.hashValue)"
            stock.buyDate = Date()
            stock.price = (14.7 * Double(index.hashValue))
            stock.quantity = Int64(index.hashValue)
            stocks.append(stock)
        }
        return stocks
    }    
}
