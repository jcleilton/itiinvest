//
//  Service.swift
//  ItiInvest
//
//  Created by Islas on 9/5/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

class Service{
    
    //https://api.hgbrasil.com/finance/stock_price?key=96d655a9&symbol=btow3
    
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
    
    
    
    
    /*
     fileprivate func fetchCoursesJSON(completion: @escaping (Result<[Course], Error>) -> ()) {
             
             let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
             guard let url = URL(string: urlString) else { return }
             
             URLSession.shared.dataTask(with: url) { (data, resp, err) in
                 
                 if let err = err {
                     completion(.failure(err))
                     return
                 }
                 
                 // successful
                 do {
                     let courses = try JSONDecoder().decode([Course].self, from: data!)
                     completion(.success(courses))
     //                completion(courses, nil)
                     
                 } catch let jsonError {
                     completion(.failure(jsonError))
     //                completion(nil, jsonError)
                 }
                 
                 
             }.resume()
         }
     
     */
    
}

