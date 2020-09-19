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
    var parentCoordinator: BaseCoordinator? { get set }
    
    func add(childCoordinator coordinator: BaseCoordinator)
    func remove(childCoordinator coordinator: BaseCoordinator)
    func childDidFinish(_ child: BaseCoordinator?)
    
    func start()
    
}

extension BaseCoordinator {
    
    func add(childCoordinator coordinator: BaseCoordinator) {
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
    }
    
    func remove(childCoordinator coordinator: BaseCoordinator) {
        childCoordinators = childCoordinators.filter{$0 !== coordinator}
    }
    
    func childDidFinish(_ child: BaseCoordinator?) {
        guard let child = child else { return }
        remove(childCoordinator: child)
    }
    
}
