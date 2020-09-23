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
    var parentCoordinator: BaseCoordinator?

    init() {
        navigationController = UINavigationController()
        setupNavigationController()
        RealTimeManager.shared.fetchSymbols()
    }

    func start() {
        let child = HomeCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        
        add(childCoordinator: child)
        child.start()
    }
    
    private func setupNavigationController() {
        UINavigationBar.appearance().tintColor = .white
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
    }
}
