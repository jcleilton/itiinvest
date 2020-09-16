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
    
    var detailViewModel: DetailViewModel?
    private var detailViewController: DetailViewController?
    
    init(navigationController: UINavigationController, viewModel: DetailViewModel) {
        self.navigationController = navigationController
        self.detailViewModel = viewModel
    }

    func start() {
        detailViewController = DetailViewController(viewModel: detailViewModel!)
        detailViewController?.coordinator = self

        navigationController.present(detailViewController!, animated: true)
    }
    
    func showPurchaseFund() {
        let child = PurchaseFundCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }
}
