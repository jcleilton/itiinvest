//
//  UIView+LayoutGuide.swift
//  ItiInvest
//
//  Created by Matheus Cardoso Kuhn on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

extension UIView {
    var compatibleLayoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide
        } else {
            return self.layoutMarginsGuide
        }
    }
}
