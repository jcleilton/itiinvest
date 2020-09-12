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

    var childCoordinators: [BaseCoordinator] = [BaseCoordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = FundsListViewController()
        let viewModel = FundsListViewModel()
        
//        controller.viewModel = viewModel
//        controller.coordinator = self

        navigationController.pushViewController(controller, animated: true)
    }

    func showDetails() {
        let child = DetailCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }
}
