//
//  DetailView.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class DetailView {
    
    let stockNameLabel = ItiLabel(text: "", type: .title)

    let quantityLabel = ItiLabel(text: LocalizableStrings.stockQuantity.localized(), type: .secondary)
    let quantityValueLabel = ItiLabel(text: "#Valor", type: .primary)
    let quantityStackView = DetailsStackView(axis: .vertical, alignment: .leading)
    
    let priceLabel = ItiLabel(text: LocalizableStrings.stockPrice.localized(), type: .secondary)
    let priceValueLabel = ItiLabel(text: "#Valor", type: .primary)
    let priceStackView = DetailsStackView(axis: .vertical, alignment: .leading)
    
    let buyDateLabel = ItiLabel(text: LocalizableStrings.stockBuyDate.localized(), type: .secondary)
    let buyDateValueLabel = ItiLabel(text: "#Valor", type: .primary)
    let buyDateStackView = DetailsStackView(axis: .vertical, alignment: .leading)
    
    let totalValueLabel = ItiLabel(text: LocalizableStrings.stockTotalValue.localized(), type: .secondary)
    let totalValueValueLabel = ItiLabel(text: "#Valor", type: .primary)
    let totalValueStackView = DetailsStackView(axis: .vertical, alignment: .leading)
    
    let separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ITIColor.gray
        
        return view
    }()
    
    let todaysPriceLabel = ItiLabel(text: LocalizableStrings.stockTodaysPrice.localized(), type: .secondary)
    let todaysPriceValueLabel = ItiLabel(text: "#Valor", type: .primary)
    let todaysPriceStackView = DetailsStackView(axis: .vertical, alignment: .leading)
    
    let todaysCotationLabel = ItiLabel(text: LocalizableStrings.stockTodaysCotation.localized(), type: .secondary)
    let todaysCotationValueLabel = ItiLabel(text: "#Valor", type: .primary)
    let todaysCotationStackView = DetailsStackView(axis: .vertical, alignment: .leading)
    
    let todaysProfitabilityLabel = ItiLabel(text: LocalizableStrings.stockProfitability.localized(), type: .secondary)
    let todaysProfitabilityValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 150, weight: .bold)
        label.text = "#V%"
        
        return label
    }()
    let todaysProfitabilityStackView = DetailsStackView(axis: .vertical, alignment: .leading)
    
    let button = ItiButton(titleText: LocalizableStrings.stockEditInformations.localized())
    
    
    
}
