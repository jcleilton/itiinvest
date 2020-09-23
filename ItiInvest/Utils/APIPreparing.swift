//
//  APIPreparing.swift
//  ItiInvest
//
//  Created by Cleilton Feitosa on 19/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation
import Firebase

fileprivate let collection = "stocks"

class RealTimeManager {
    private var ref: DatabaseReference
    
    static let shared: RealTimeManager = {
        let api = RealTimeManager(ref: Database.database().reference())
        return api
    }()
    
    fileprivate init(ref: DatabaseReference) {
        self.ref = ref
    }
    
    var symbols: [FIRStock] = []
    
    func loadData(onCompletion: @escaping(([FIRStock]) -> Void)) {
        self.ref.child(collection).observeSingleEvent(of: .value, with: { (snapshot) in
            var stocks = [FIRStock]()
            if let value = snapshot.value as? [String:Any] {
                for dic in value {
                    if let data = dic.value as? [String:String] {
                        let stock = FIRStock(id: dic.key, name: data["name"] ?? "", symbol: data["symbol"] ?? "")
                        stocks.append(stock)
                    }
                }
            }
            onCompletion(stocks)
        })
    }
    
    func fetchSymbols() {
        loadData() { [weak self] result in
            self?.symbols = result
        }
    }
}
