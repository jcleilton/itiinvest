//
//  ProductCollectionViewCell.swift
//  ItiInvest
//
//  Created by Matheus Cardoso Kuhn on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet private(set) weak var backgroundImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
}
