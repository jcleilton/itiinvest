//
//  UIButton+Gradient.swift
//  ItiInvest
//
//  Created by Develop on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

extension UIButton {
//    func applyGradient(color1: UIColor, color2: UIColor, locations: [NSNumber]?) {
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.frame = self.bounds
//        gradient.colors = [color1.cgColor, color2.cgColor]
//        gradient.startPoint = CGPoint(x: 0, y: 0.5)
//        gradient.endPoint = CGPoint(x: 1, y: 0.5)
//        self.layer.insertSublayer(gradient, at: 0)
//    }
}

extension UIView {
    func applyGradient(color1: UIColor, color2: UIColor, locations: [NSNumber]?) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
    }

    
    func applyCornerRadius(radius: CGFloat = 20) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
}
