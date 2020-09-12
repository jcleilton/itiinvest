//
//  ViewCodeProtocol.swift
//  ItiInvest
//
//  Created by Cleilton Feitosa on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

protocol CodeView {
    func setup()
    func setupComponents()
    func setupConstraints()
    func setupExtraConfigurations()
}

extension CodeView {
    func setup() {
        self.setupComponents()
        self.setupConstraints()
        self.setupExtraConfigurations()
    }
}
