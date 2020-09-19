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
    var parentCoordinator: BaseCoordinator?
    var childCoordinators: [BaseCoordinator] = [BaseCoordinator]()
    
    private var detailViewModel: DetailViewModel
    
    init(navigationController: UINavigationController, viewModel: DetailViewModel) {
        self.navigationController = navigationController
        self.detailViewModel = viewModel
    }

    func start() {
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        detailViewController.coordinator = self

        navigationController.present(detailViewController, animated: true)
    }
    
    func showPurchaseFund() {
        let child = PurchaseFundCoordinator(navigationController: navigationController, purchaseFundViewModel: detailViewModel.purchaseFundViewModel)
        add(childCoordinator: child)
        
        child.start()
    }
    
    func childDidFinish(_ child: BaseCoordinator?) {
        guard let child = child else { return }
        parentCoordinator?.childDidFinish(self)
        remove(childCoordinator: child)
    }
    
}
