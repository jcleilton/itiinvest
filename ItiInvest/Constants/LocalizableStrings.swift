//
//  LocalizableStrings.swift
//  ItiInvest
//
//  Created by Pericles Junor on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

enum LocalizableStrings: String {

    // MARK: - Shared
    case error = "error"
    
    // MARK: - Detail View
    case stockQuantity = "stock.quantity"
    case stockPrice = "stock.price"
    case stockBuyDate = "stock.buyDate"
    case stockTotalValue = "stock.totalValue"
    case stockTodaysCotation = "stock.todaysCotation"
    case stockTodaysPrice = "stock.todaysPrice"
    case stockProfitability = "stock.profitability"
    case stockEditInformations = "stock.editInformations"

    //MARK: - Home
    case homeHsButton = "home.hsButton"
    case homePercentTitle = "home.percentTitle"
    case homeProfile = "home.profile"
    case homeBalance = "home.balance"
    case homeAllAbout = "home.all_about"

    // MARK: - Funds List

    case listMy_patrimony = "list.my_patrimony"
    case listCurrent_balance = "list.current_balance"
    case listNew_investment = "list.new_investment"
    case listOn_wallet = "list.on_wallet"

    // MARK: - Purchase Fund

    case formTitle = "form.title"
    case formActive = "form.active"
    case formInvest = "form.invest"
    case formRequired = "form.required"
    case formQuantity = "form.quantity"
    case formPurchasePrice = "form.purchasePrice"
    case formStartingDate = "form.startingDate"
    case formRequiredField = "form.requiredField"
    case formTitleEdit = "form.titleEdit"

    func localized() -> String { rawValue.localized() }
}

extension String {
    func localized() -> String { NSLocalizedString(self, comment: "Localizable") }
}
