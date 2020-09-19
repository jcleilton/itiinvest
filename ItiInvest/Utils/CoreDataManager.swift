//
//  CoreData.swift
//  ItiInvest
//
//  Created by Matheus Cardoso Kuhn on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    weak var delegate: NSFetchedResultsControllerDelegate?
    
    lazy var fetchedResultsController: NSFetchedResultsController<Stock> = {
        let fetchRequest: NSFetchRequest<Stock> = Stock.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = delegate
        
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
    
    func create(quantity: Int, buyDate: Date, name: String, price: Double) throws {
        let data = Stock(context: context)
        data.quantity = Int64(quantity)
        data.name = name
        data.buyDate = buyDate
        data.price = price
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
}
