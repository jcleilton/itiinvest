//
//  ItiLabel.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

enum ItiLabelType {
    case title, primary, secondary
}

class ItiLabel: UILabel {
    
    
    init(text: String, type: ItiLabelType) {
        super.init(frame: .zero)
        
        setup(text, type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setup(_ text: String, _ type: ItiLabelType) {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = ITIColor.mainText
        
        switch type {
        case .title:
            font = UIFont.systemFont(ofSize: 22, weight: .medium)
        case .primary:
            font = UIFont.systemFont(ofSize: 22, weight: .regular)
        case .secondary:
            font = UIFont.systemFont(ofSize: 15, weight: .thin)
            textColor = ITIColor.secondaryText
        }
    }
}
