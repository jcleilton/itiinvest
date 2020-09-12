//
//  BaseCoordinator.swift
//  ItiInvest
//
//  Created by Pericles Junor on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation
import UIKit

@objc
protocol BaseCoordinator: AnyObject {

    var navigationController: UINavigationController { get set }
    var childCoordinators: [BaseCoordinator] { get set }

    @objc func start()
    @objc func add(child coordinator: BaseCoordinator)
    @objc func remove(child coordinator: BaseCoordinator)

    @objc optional func showFundsList()
    @objc optional func showDetails()
    @objc optional func showPurchaseFund()
}

extension BaseCoordinator {
    func add(child coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    func remove(child coordinator: BaseCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator}
    }
}
