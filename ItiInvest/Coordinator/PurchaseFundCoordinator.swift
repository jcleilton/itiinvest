//
//  PurchaseFundCoordinator.swift
//  ItiInvest
//
//  Created by Pericles Junor on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class PurchaseFundCoordinator: BaseCoordinator {
    var navigationController: UINavigationController

    var childCoordinators: [BaseCoordinator] = [BaseCoordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = PurchaseFundViewModel()
        let controller = PurchaseFundViewController(viewModel: viewModel)

//        controller.viewModel = viewModel
//        controller.coordinator = self

        navigationController.pushViewController(controller, animated: true)
    }

    func showPurchaseFund() {
        //
    }
}
