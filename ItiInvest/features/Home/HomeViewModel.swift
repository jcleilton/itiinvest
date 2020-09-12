//
//  HomeViewModel.swift
//  ItiInvest
//
//  Created by Matheus Cardoso Kuhn on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

enum Product: CaseIterable {
    case investiment
    case card
    case cashback
}

protocol HomeViewModeling {
    var productCount: Int { get }
    func productTitle(at indexPath: IndexPath) -> String
    func productDescription(at indexPath: IndexPath) -> String
    func productBackgroundImage(at indexPath: IndexPath) -> UIImage?
}

final class HomeViewModel {
    // MARK: - Variables
    private var products: [Product] = Product.allCases
    var productCount: Int { products.count }
}

// MARK: - HomeViewModeling
extension HomeViewModel: HomeViewModeling {
    func productTitle(at indexPath: IndexPath) -> String {
        let type = products[indexPath.row]
        switch type {
        case .investiment:
            return "investir"
        case .card:
            return "cadastrar"
        case .cashback:
            return "cashback"
        }
    }
    
    func productDescription(at indexPath: IndexPath) -> String {
        let type = products[indexPath.row]
        switch type {
        case .investiment:
            return "investir seu dinheiro"
        case .card:
            return "cartão"
        case .cashback:
            return "dinheiro de volta"
        }
    }
    
    func productBackgroundImage(at indexPath: IndexPath) -> UIImage? {
        let type = products[indexPath.row]
        switch type {
        case .investiment:
            return #imageLiteral(resourceName: "investiment")
        case .card:
            return #imageLiteral(resourceName: "card")
        case .cashback:
            return #imageLiteral(resourceName: "cashback")
        }
    }
}
