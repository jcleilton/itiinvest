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
    private let manager: CoreDataManager
    weak var delegate: FundsListViewModelDelegate?
    
    var total: Int {
        manager.total
    }
    
    var userTotal: String {
        Formatter.currencyStringFromDouble(amountValue())
    }
    
    init(manager: CoreDataManager) {
        self.manager = manager
        super.init()
    }
    
    func performFetch() {
        manager.performFetch()
    }
    
    func getListCellViewModel(from indexPath: IndexPath) -> FundsListCellViewModel {
        let stock = manager.getStockAt(indexPath)
        let amountTotal = amountValue()
        let percentual = (stock.price * 100.0) / amountTotal
        let viewModel = FundsListCellViewModel(
            name: stock.name ?? "",
            amount: Formatter.currencyStringFromDouble(stock.price),
            percentual: Formatter.decimalStringFromDouble(percentual) + "%")
        return viewModel
    }
    
    private func amountValue() -> Double {
        let stockValue = manager.fetchedResultsController.fetchedObjects?.reduce(0.0, { (result, stock) -> Double in
            (stock.price * Double(Int(stock.quantity))) + result
        })
        return stockValue ?? 0.0
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
