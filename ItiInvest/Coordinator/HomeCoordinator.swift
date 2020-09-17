//
//  HomeCoordinator.swift
//  ItiInvest
//
//  Created by Pericles Junor on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class HomeCoordinator: BaseCoordinator {

    var navigationController: UINavigationController

    var childCoordinators: [BaseCoordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = HomeFactory.make()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showFundsList() {
        let child = FundsListCoordinator(navigationController: navigationController)
        add(childCoordinator: child)
        child.start()
    }
}
