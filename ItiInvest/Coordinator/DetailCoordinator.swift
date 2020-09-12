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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = FundsListViewController()
//        let viewModel = DetailViewModel()

//        controller.viewModel = viewModel
//        controller.coordinator = self
        
        navigationController.pushViewController(controller, animated: true)
        controller.present(DetailViewController(), animated: true)
    }
    
    func showPurchaseFund() {
        let child = PurchaseFundCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }
}
