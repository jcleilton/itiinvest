//
//  DetailsStackView.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class DetailsStackView: UIStackView {
    init(axis: NSLayoutConstraint.Axis = .vertical, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 0, contentMode: UIView.ContentMode = .scaleToFill, distribution: UIStackView.Distribution = .fillProportionally) {
        super.init(frame: .zero)
        
        setup(axis: axis, alignment: alignment)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(axis: NSLayoutConstraint.Axis = .vertical, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 0, contentMode: UIView.ContentMode = .scaleToFill, distribution: UIStackView.Distribution = .fillProportionally) {
        translatesAutoresizingMaskIntoConstraints = false
        
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.contentMode = contentMode
        self.distribution = distribution
    }
}
