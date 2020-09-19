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
        let manager = CoreDataManager()
        let viewModel = FundsListViewModel(manager: manager)
        controller.viewModel = viewModel
        viewModel.delegate = controller
        manager.delegate = viewModel
        controller.coordinator = self

        navigationController.pushViewController(controller, animated: true)
    }

    func showDetails(viewModel: DetailViewModel) {
        let child = DetailCoordinator(navigationController: navigationController, viewModel: viewModel)
        
        add(childCoordinator: child)
        child.start()
    }
    
    func showPurchaseFund(viewModel: PurchaseFundViewModel) {
        let child = PurchaseFundCoordinator(navigationController: navigationController, purchaseFundViewModel: viewModel)
        
        add(childCoordinator: child)
        child.start()
    }

}
