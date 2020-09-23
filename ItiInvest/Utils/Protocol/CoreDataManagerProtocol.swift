//
//  CoreDataManagerProtocol.swift
//  ItiInvest
//
//  Created by Cleilton Feitosa on 19/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func setDelegate(delegate: NSFetchedResultsControllerDelegate?)
    
    func performFetch()
    
    var total: Int { get }
    
    func getStockAt(_ indexPath: IndexPath) -> Stock
    
    func getStocks() -> [Stock]
    
    func create(quantity: Int, buyDate: Date, name: String, price: Double, symbol: String) throws
    
    func save() throws
    
    func delete(data: Stock) throws
}

extension CoreDataManagerProtocol {
    func performFetch() { }
    
    func create(quantity: Int, buyDate: Date, name: String, price: Double, symbol: String) throws { }
    
    func save() throws { }
    
    func delete(data: Stock) throws { }
    
    func setDelegate(delegate: NSFetchedResultsControllerDelegate?) { }
}
