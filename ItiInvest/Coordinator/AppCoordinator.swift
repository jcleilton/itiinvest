//
//  AppCoordinator.swift
//  ItiInvest
//
//  Created by Pericles Junor on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {

    var navigationController: UINavigationController
    var childCoordinators: [BaseCoordinator] = [BaseCoordinator]()

    init() {
        navigationController = UINavigationController()
    }

    func start() {
        var child = HomeCoordinator(navigationController: navigationController)
        add(child: child)
        child.start()
    }
    

}
