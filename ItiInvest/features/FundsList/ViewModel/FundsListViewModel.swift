//
//  FundsListViewModel.swift
//  ItiInvest
//
//  Created by Pericles Junor on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit
import CoreData

protocol FundsListViewModelDelegate: class {
    func didFinishFetching()
}

class FundsListViewModel: NSObject {
    private let manager: CoreDataManagerProtocol
    weak var delegate: FundsListViewModelDelegate?
    
    var total: Int {
        manager.total
    }
    
    var userTotal: String {
        Formatter.currencyStringFromDouble(amountValue())
    }
    
    init(manager: CoreDataManagerProtocol) {
        self.manager = manager
        super.init()
        performFetch()
    }
    
    func performFetch() {
        manager.performFetch()
    }
        
    func getListCellViewModel(from indexPath: IndexPath) -> FundsListCellViewModel {
        let stock = manager.getStockAt(indexPath)
        let amountTotal = amountValue()
        let percentual = ((stock.price * Double(stock.quantity)) * 100.0) / amountTotal
        let viewModel = FundsListCellViewModel(
            name: "\(stock.symbol ?? "") - \(stock.name ?? "")",
            amount: Formatter.currencyStringFromDouble(stock.price),
            percentual: Formatter.decimalStringFromDouble(percentual) + "%")
        return viewModel
    }
    
    private func amountValue() -> Double {
        let stockValue = manager.getStocks().reduce(0.0, { (result, stock) -> Double in
            (stock.price * Double(Int(stock.quantity))) + result
        })
        return stockValue
    }
    
    func deleteStock(at indexPath: IndexPath) throws {
        let stock = self.manager.getStockAt(indexPath)
        do {
            try self.manager.delete(data: stock)
        } catch {
            throw error
        }
    }
    
    func getEditionViewModel(from indexPath: IndexPath) -> PurchaseFundViewModel {
        let viewModel = PurchaseFundViewModel(stock: self.manager.getStockAt(indexPath))
        return viewModel
    }
    
    func getCreationViewModel() -> PurchaseFundViewModel {
        let viewModel = PurchaseFundViewModel()
        return viewModel
    }
    
    func getDetailViewModel(from indexPath: IndexPath) -> DetailViewModel {
        DetailViewModel(stock: manager.getStockAt(indexPath))
    }
}

extension FundsListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.didFinishFetching()
    }
}
