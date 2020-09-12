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
    
    // MARK: - Detail View
    case stockQuantity = "stock.quantity"
    case stockPrice = "stock.price"
    case stockBuyDate = "stock.buyDate"
    case stockTotalValue = "stock.totalValue"
    case stockTodaysCotation = "stock.todaysCotation"
    case stockTodaysPrice = "stock.todaysPrice"
    case stockProfitability = "stock.profitability"
    case stockEditInformations = "stock.editInformations"
    
    func localized() -> String { rawValue.localized() }
}

extension String {
    func localized() -> String { NSLocalizedString(self, comment: "Localizable") }
}
