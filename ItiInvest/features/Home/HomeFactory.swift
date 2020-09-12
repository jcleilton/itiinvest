//
//  HomeFactory.swift
//  ItiInvest
//
//  Created by Matheus Cardoso Kuhn on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

enum HomeFactory {
    static func make() -> UIViewController {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
}
