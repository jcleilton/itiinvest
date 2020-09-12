//
//  ItiButton.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class ItiButton: UIButton {
    
    init(titleText: String) {
        super.init(frame: .zero)
        
        setupLayout(titleText: titleText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(titleText: String) {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        setTitle(titleText, for: .normal)
        setTitleColor(.white, for: .normal)
        
        applyGradient(color1: ITIColor.orange, color2: ITIColor.purple, locations: [0.0, 1.0])
        applyCornerRadius()
    }
    
}


