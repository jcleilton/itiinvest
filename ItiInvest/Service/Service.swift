//
//  Service.swift
//  ItiInvest
//
//  Created by Islas on 9/5/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

class Service{
    
    private let baseURL = "https://api.hgbrasil.com/finance/stock_price"
    private let key = "96d655a9"
    
    
    func getStockPrice(symbol: String, completion: @escaping (Result<Double, StockAPIError>) -> Void){
        guard let url = URL(string: "\(baseURL)?key=\(key)&symbol=\(symbol)") else {return}
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            if let _ = error{
                completion(.failure(.unkown))
                return
            }
            guard let data = data, let _ = response else {
                completion(.failure(.unkown))
                return
            }
            if let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                let stockResult = StockAPIResult(fromDictionary: dict, andSymbol: symbol)
                completion(.success(stockResult.price ?? 0))
            }
        })
        task.resume()
    }
}

