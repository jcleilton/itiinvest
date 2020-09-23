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
    var parentCoordinator: BaseCoordinator?
    
    private var purchaseFundViewModel: PurchaseFundViewModel
    
    init(navigationController: UINavigationController, purchaseFundViewModel: PurchaseFundViewModel = PurchaseFundViewModel()) {
        self.navigationController = navigationController
        self.purchaseFundViewModel = purchaseFundViewModel
    }

    func start() {
        let purchaseFundViewController = PurchaseFundViewController(viewModel: purchaseFundViewModel)
        purchaseFundViewController.coordinator = self

        navigationController.present(purchaseFundViewController, animated: true)
    }

}
