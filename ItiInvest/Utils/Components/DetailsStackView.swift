//
//  DetailsStackView.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class DetailsStackView: UIStackView {
    init(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment) {
        super.init(frame: .zero)
        
        setup(axis: axis, alignment: alignment)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment) {
        translatesAutoresizingMaskIntoConstraints = false
        
        self.axis = axis
        self.alignment = alignment
        spacing = 8
        contentMode = .left
        distribution = .fillProportionally
    }
}
