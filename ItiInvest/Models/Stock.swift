//
//  Stock.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

class Stock {
 
    var name: String
    var amount: Int
    var price: Double
    var buyDate: Date
    
    init(name: String, amount: Int, price: Double, buyDate: Date) {
        self.name = name
        self.amount = amount
        self.price = price
        self.buyDate = buyDate
    }
    
}
