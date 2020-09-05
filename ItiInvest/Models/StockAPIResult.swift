//
//  StockAPIResult.swift
//  ItiInvest
//
//  Created by Islas on 9/5/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

struct StockAPIResult {
    
    private let results: [String: Any?]?
    private let symbol: String
    
    var price: Double?{
        guard let results = results,
            let stock = results[symbol] as? [String: Any?],
              let price = stock["price"] as? Double else{return nil}
        return price
    }
    
    
    init(fromDictionary dict: [String: Any?], andSymbol symbol: String){
        results = dict["results"] as? [String: Any?]
        self.symbol = symbol
    }
    
}
