//
//  FIRStock.swift
//  ItiInvest
//
//  Created by Cleilton Feitosa on 19/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

struct FIRStock {
    let id: String
    let name: String
    let symbol: String
    
    var description: String { "\(symbol) - \(name)" }
}

extension FIRStock: Comparable {
    static func < (lhs: FIRStock, rhs: FIRStock) -> Bool {
        return lhs.description < rhs.description
    }
}
