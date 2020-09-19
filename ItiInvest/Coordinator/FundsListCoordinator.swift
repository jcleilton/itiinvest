//
//  FundsListCoordinator.swift
//  ItiInvest
//
//  Created by Pericles Junor on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class FundsListCoordinator: BaseCoordinator {

    var navigationController: UINavigationController
    var parentCoordinator: BaseCoordinator?
    var childCoordinators: [BaseCoordinator] = [BaseCoordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = FundsListViewController()
        let viewModel = FundsListViewModel()
        
        controller.coordinator = self

        navigationController.pushViewController(controller, animated: true)
    }

    func showDetails(stock: Stock) {
        let child = DetailCoordinator(navigationController: navigationController, viewModel: DetailViewModel(stock: stock))
        
        add(childCoordinator: child)
        child.start()
    }
    
    func showPurchaseFund(viewModel: PurchaseFundViewModel) {
        let child = PurchaseFundCoordinator(navigationController: navigationController, purchaseFundViewModel: viewModel)
        
        add(childCoordinator: child)
        child.start()
    }

}
