//
//  HomeViewController.swift
//  ItiInvest
//
//  Created by Matheus Cardoso Kuhn on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

enum Product: CaseIterable {
    case investiment
    case card
    case cashback
    
    var title: String {
        switch self {
        case .investiment:
            return "investir"
        case .card:
            return "cadastrar"
        case .cashback:
            return "cashback"
        }
    }
    
    var description: String {
        switch self {
        case .investiment:
            return "investir seu dinheiro"
        case .card:
            return "cartão"
        case .cashback:
            return "dinheiro de volta"
        }
    }
    
    var backgroundImage: UIImage? {
        switch self {
        case .investiment:
            return UIImage(named: "investiment")
        case .card:
            return UIImage(named: "card")
        case .cashback:
            return UIImage(named: "cashback")
        }
    }
}

final class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var balanceValueLabel: UILabel!
    @IBOutlet private weak var balanceVisibilityButton: UIButton!
    @IBOutlet private weak var productCollectionView: UICollectionView! {
        didSet {
            let layout = UICollectionViewFlowLayout()
            let margin: CGFloat = 15
            let availableSize = productCollectionView.bounds.inset(by: productCollectionView.layoutMargins)
            let cellWidth = (availableSize.width / CGFloat(2.10)).rounded(.down)
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: cellWidth, height: availableSize.height)
            layout.minimumLineSpacing = margin
            layout.minimumInteritemSpacing = margin
            layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
            productCollectionView.collectionViewLayout = layout
        }
    }
    
    // MARK: - Variables
    private let products: [Product] = Product.allCases
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    @IBAction func touchOnVisibility(_ sender: UIButton) {
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let product = products[indexPath.row]
        cell.backgroundImageView.image = product.backgroundImage
        cell.titleLabel.text = product.title
        cell.descriptionLabel.text = product.description
        cell.contentView.layer.cornerRadius = 6
        cell.contentView.layer.masksToBounds = true
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Chamar segue
    }
}
