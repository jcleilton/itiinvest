//
//  StockAPIError.swift
//  ItiInvest
//
//  Created by Islas on 9/5/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

enum StockAPIError: Error{
    
    case invalidSymbol
    case networkConnection
    case unkown
    
}
