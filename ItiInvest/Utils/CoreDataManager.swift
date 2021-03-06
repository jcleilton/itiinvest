//
//  CoreData.swift
//  ItiInvest
//
//  Created by Matheus Cardoso Kuhn on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: CoreDataManagerProtocol {
    weak private var delegate: NSFetchedResultsControllerDelegate?
    
    lazy var fetchedResultsController: NSFetchedResultsController<Stock> = {
        let fetchRequest: NSFetchRequest<Stock> = Stock.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }()
    
    func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    var total: Int {
        fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func getStockAt(_ indexPath: IndexPath) -> Stock {
        fetchedResultsController.object(at: indexPath)
    }
    
    func getStocks() -> [Stock] {
        fetchedResultsController.fetchedObjects ?? []
    }
    
    func create(quantity: Int, buyDate: Date, name: String, price: Double, symbol: String) throws {
        let data = Stock(context: context)
        data.quantity = Int64(quantity)
        data.name = name
        data.buyDate = buyDate
        data.price = price
        data.symbol = symbol
        do {
            try self.save()
        } catch {
            throw error
        }
        
    }
    
    func save() throws {
        do {
            try context.save()
        } catch {
            throw error
        }
    }
    
    func delete(data: Stock) throws {
        context.delete(data)
        try save()
    }
    
    func setDelegate(delegate: NSFetchedResultsControllerDelegate?) {
        self.delegate = delegate
        fetchedResultsController.delegate = self.delegate
    }
}
