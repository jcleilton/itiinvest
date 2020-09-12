//
//  BaseCoordinator.swift
//  ItiInvest
//
//  Created by Pericles Junor on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation
import UIKit

protocol BaseCoordinator: AnyObject {

    var navigationController: UINavigationController { get set }
    var childCoordinators: [BaseCoordinator] { get set }

    func start()
    func add(child coordinator: BaseCoordinator)
    func remove(child coordinator: BaseCoordinator)
}

extension BaseCoordinator {
    func add(child coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    func remove(child coordinator: BaseCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator}
    }
}
