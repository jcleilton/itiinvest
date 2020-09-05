//
//  CoreData.swift
//  ItiInvest
//
//  Created by Matheus Cardoso Kuhn on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit
import CoreData

enum CoreDataKey: String {
    case stocks
    
    var description: String {
        switch self {
        case .stocks:
            return "Stock"
        }
    }
}

enum CoreDataError: Error {
    case appDelegateNotFound
    case notFound
    case couldNotSave
}

protocol Storer {
    func fetch<T: NSManagedObject>() throws -> T
    func save<T>(object: T, key: CoreDataKey) throws
}

final class CoreDataApi: Storer {
    func fetch<T: NSManagedObject>() throws -> T {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw CoreDataError.appDelegateNotFound
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = T.fetchRequest()
        do {
            let value = try managedContext.fetch(fetchRequest)
            guard let result = value.first as? T else {
                throw CoreDataError.notFound
            }
            return result
        } catch {
            throw CoreDataError.notFound
        }
    }
    
    func save<T>(object: T, key: CoreDataKey) throws {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw CoreDataError.appDelegateNotFound
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: key.description, in: managedContext) else {
            throw CoreDataError.couldNotSave
        }
        let stocks = NSManagedObject(entity: entity, insertInto: managedContext)
        stocks.setValue(object, forKey: key.rawValue)
        do {
            try managedContext.save()
        } catch {
            throw CoreDataError.couldNotSave
        }
    }
}
