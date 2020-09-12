//
//  UIView+Constrants.swift
//  ItiInvest
//
//  Created by Cleilton Feitosa on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

extension UIView {
    func anchorFillSuperview() {
        guard let superview = self.superview else { fatalError("Esqueceu de add na superview, cara!!! ;)") }
        self.anchor(
            top: (anchor: superview.topAnchor, constant: 0),
            bottom: (anchor: superview.bottomAnchor, constant: 0),
            left: (anchor: superview.leftAnchor, constant: 0),
            right: (anchor: superview.rightAnchor, constant: 0))
    }
    
    func anchor(
        centerX: (anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat)? = nil,
        centerY: (anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat)? = nil,
        top: (anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat)? = nil,
        bottom: (anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat)? = nil,
        left: (anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat)? = nil,
        right: (anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat)? = nil,
        relativeHeight: (anchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat)? = nil,
        relativeWidth: (anchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat)? = nil,
        height: CGFloat? = nil,
        width: CGFloat? = nil
    ) {
        if let anchor = centerX {
            self.centerXAnchor.constraint(equalTo: anchor.anchor, constant: anchor.constant).isActive = true
        }
        if let anchor = centerY {
            self.centerYAnchor.constraint(equalTo: anchor.anchor, constant: anchor.constant).isActive = true
        }
        if let anchor = top {
            self.topAnchor.constraint(equalTo: anchor.anchor, constant: anchor.constant).isActive = true
        }
        if let anchor = bottom {
            self.bottomAnchor.constraint(equalTo: anchor.anchor, constant: anchor.constant).isActive = true
        }
        if let anchor = left {
            self.leftAnchor.constraint(equalTo: anchor.anchor, constant: anchor.constant).isActive = true
        }
        if let anchor = right {
            self.rightAnchor.constraint(equalTo: anchor.anchor, constant: anchor.constant).isActive = true
        }
        if let anchor = relativeHeight {
            self.heightAnchor.constraint(equalTo: anchor.anchor, multiplier: anchor.multiplier, constant: anchor.constant).isActive = true
        }
        if let anchor = relativeWidth {
            self.heightAnchor.constraint(equalTo: anchor.anchor, multiplier: anchor.multiplier, constant: anchor.constant).isActive = true
        }
        if let anchor = height {
            self.heightAnchor.constraint(equalToConstant: anchor).isActive = true
        }
        if let anchor = width {
            self.heightAnchor.constraint(equalToConstant: anchor).isActive = true
        }
    }
}

