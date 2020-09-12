//
//  DetailCoordinator.swift
//  ItiInvest
//
//  Created by Pericles Junor on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class DetailCoordinator: BaseCoordinator {

    var navigationController: UINavigationController

    var childCoordinators: [BaseCoordinator] = [BaseCoordinator]()
    
    private var detailViewModel: DetailViewModel?
    private var detailViewController: DetailViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let fundsController = FundsListViewController()
        
        let coreDataManager = CoreDataManager()
        let stock = try? coreDataManager.create(quantity: 100, buyDate: Date(), name: "Cosan S.A. - CSAN3", price: 50.0)
        
        coreDataManager.performFetch()
        detailViewModel = DetailViewModel(stock: coreDataManager.getStockAt(IndexPath(row: 0, section: 0)))
    
        detailViewController = DetailViewController(viewModel: detailViewModel!)
//        detailViewController.coordinator = self
//
        navigationController.pushViewController(fundsController, animated: true)
        fundsController.present(detailViewController!, animated: true)
    }
    
    func showPurchaseFund() {
        let child = PurchaseFundCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }
}
