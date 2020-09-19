//
//  DetailView.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    let stockNameLabel = ItiLabel(text: "ITSA4 - ITAUSA", type: .title)
    
    let quantityLabel = ItiLabel(text: LocalizableStrings.stockQuantity.localized(), type: .secondary)
    let quantityValueLabel = ItiLabel(text: "#Valor", type: .primary)
    let quantityStackView = DetailsStackView(axis: .vertical, alignment: .leading)
    
    let priceLabel = ItiLabel(text: LocalizableStrings.stockPrice.localized(), type: .secondary, alignment: .right)
    let priceValueLabel = ItiLabel(text: "#Valor", type: .primary, alignment: .right)
    let priceStackView = DetailsStackView(axis: .vertical, alignment: .trailing)
    let quantityAndPriceStackView = DetailsStackView(axis: .horizontal, alignment: .fill, spacing: 0, contentMode: .scaleToFill, distribution: .fill)
    
    let buyDateLabel = ItiLabel(text: LocalizableStrings.stockBuyDate.localized(), type: .secondary)
    let buyDateValueLabel = ItiLabel(text: "#Valor", type: .primary)
    let buyDateStackView = DetailsStackView(axis: .vertical, alignment: .leading)
    
    let totalValueLabel = ItiLabel(text: LocalizableStrings.stockTotalValue.localized(), type: .secondary, alignment: .right)
    let totalValueValueLabel = ItiLabel(text: "#Valor", type: .primary, alignment: .right)
    let totalValueStackView = DetailsStackView(axis: .vertical, alignment: .trailing)
    let dateAndValueStackView = DetailsStackView(axis: .horizontal, alignment: .fill, spacing: 0, contentMode: .scaleToFill, distribution: .fill)
    
    let separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ITIColor.lightGray
        
        return view
    }()
    
    let todaysPriceLabel = ItiLabel(text: LocalizableStrings.stockTodaysPrice.localized(), type: .secondary)
    let todaysPriceValueLabel = ItiLabel(text: "#Valor", type: .primary)
    let todaysPriceStackView = DetailsStackView(axis: .vertical, alignment: .leading)
    
    let todaysCotationLabel = ItiLabel(text: LocalizableStrings.stockTodaysCotation.localized(), type: .secondary, alignment: .right)
    let todaysCotationValueLabel = ItiLabel(text: "#Valor", type: .primary, alignment: .right)
    let todaysCotationStackView = DetailsStackView(axis: .vertical, alignment: .trailing)
    let todaysStackView = DetailsStackView(axis: .horizontal, alignment: .fill, spacing: 0, contentMode: .scaleToFill, distribution: .fillProportionally)
    
    let todaysProfitabilityLabel = ItiLabel(text: LocalizableStrings.stockProfitability.localized(), type: .secondary, alignment: .center)
    let todaysProfitabilityValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 150, weight: .bold)
        label.text = "#V%"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    let todaysProfitabilityStackView = DetailsStackView(axis: .vertical, alignment: .center, distribution: .fill)
    
    let editButton: UIButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setTitle(LocalizableStrings.stockEditInformations.localized(), for: .normal)
        return button
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "close"), for: UIControl.State.normal)
        return button
    }()
}

extension DetailView: CodeView {
    func setupComponents() {
        backgroundColor = .white
        
        self.addSubview(closeButton)
        quantityStackView.addArrangedSubview(quantityLabel)
        quantityStackView.addArrangedSubview(quantityValueLabel)
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(priceValueLabel)
        buyDateStackView.addArrangedSubview(buyDateLabel)
        buyDateStackView.addArrangedSubview(buyDateValueLabel)
        totalValueStackView.addArrangedSubview(totalValueLabel)
        totalValueStackView.addArrangedSubview(totalValueValueLabel)
        todaysPriceStackView.addArrangedSubview(todaysPriceLabel)
        todaysPriceStackView.addArrangedSubview(todaysPriceValueLabel)
        todaysCotationStackView.addArrangedSubview(todaysCotationLabel)
        todaysCotationStackView.addArrangedSubview(todaysCotationValueLabel)
        todaysProfitabilityStackView.addArrangedSubview(todaysProfitabilityLabel)
        todaysProfitabilityStackView.addArrangedSubview(todaysProfitabilityValueLabel)
        
        quantityAndPriceStackView.addArrangedSubview(quantityStackView)
        quantityAndPriceStackView.addArrangedSubview(priceStackView)
        
        dateAndValueStackView.addArrangedSubview(buyDateStackView)
        dateAndValueStackView.addArrangedSubview(totalValueStackView)
        
        todaysStackView.addArrangedSubview(todaysPriceStackView)
        todaysStackView.addArrangedSubview(todaysCotationStackView)
        
        [stockNameLabel, quantityAndPriceStackView, dateAndValueStackView, separatorView, todaysStackView, todaysProfitabilityStackView, editButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        closeButton.anchor(
            top: (anchor: self.topAnchor, constant: Constant.Margin.verticalNormal),
            right: (anchor: self.rightAnchor, constant: -Constant.Margin.horizontalNormal),
            relativeWidth: (anchor: closeButton.heightAnchor, multiplier: 1, constant: 0),
            height: 30)
        stockNameLabel.topAnchor.constraint(equalTo: closeButton.topAnchor, constant: Constant.Margin.verticalLarge).isActive = true
        stockNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Margin.horizontalLarge).isActive = true
        stockNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Margin.horizontalLarge).isActive = true
        
        quantityAndPriceStackView.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor, constant: Constant.Margin.verticalLarge).isActive = true
        quantityAndPriceStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Margin.horizontalLarge).isActive = true
        quantityAndPriceStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Margin.horizontalLarge).isActive = true
        
        dateAndValueStackView.topAnchor.constraint(equalTo: quantityAndPriceStackView.bottomAnchor, constant: Constant.Margin.verticalNormal).isActive = true
        dateAndValueStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Margin.horizontalLarge).isActive = true
        dateAndValueStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Margin.horizontalLarge).isActive = true
        
        separatorView.topAnchor.constraint(equalTo: dateAndValueStackView.bottomAnchor, constant: Constant.Margin.verticalNormal).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Margin.horizontalLarge).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Margin.horizontalLarge).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        todaysStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Constant.Margin.verticalNormal).isActive = true
        todaysStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Margin.horizontalLarge).isActive = true
        todaysStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Margin.horizontalLarge).isActive = true
        
        todaysProfitabilityStackView.topAnchor.constraint(equalTo: todaysStackView.bottomAnchor, constant: Constant.Margin.verticalNormal).isActive = true
        todaysProfitabilityStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Margin.horizontalLarge).isActive = true
        todaysProfitabilityStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Margin.horizontalLarge).isActive = true
        
        editButton.topAnchor.constraint(greaterThanOrEqualTo: todaysProfitabilityStackView.bottomAnchor, constant: Constant.Margin.verticalNormal).isActive = true
        editButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Margin.horizontalLarge).isActive = true
        editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Margin.horizontalLarge).isActive = true
        editButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constant.Margin.verticalNormal).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupExtraConfigurations() {
        
    }
}
