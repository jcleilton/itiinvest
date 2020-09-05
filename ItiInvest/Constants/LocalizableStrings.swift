//
//  LocalizableStrings.swift
//  ItiInvest
//
//  Created by Pericles Junor on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

enum LocalizableStrings: String {
    case hideShowButton = "hsButton"
    case percentageTitle = "percentTitle"

    func localized() -> String { rawValue.localized() }
}

extension String {
    func localized() -> String { NSLocalizedString(self, comment: "Localizable") }
}
