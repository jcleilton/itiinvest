//
//  FundTableViewCell.swift
//  ItiInvest
//
//  Created by Pericles Junor on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class FundCellView: UIView{
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let accessoryDetailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.backgroundColor = UIColor(rgb: 0xff007e)
        return view
    }()
    
    let titleLabel: UIView = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Corretora"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(rgb: 0x3c3c43)
        
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "IPV4-PCNC"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(rgb: 0x3c3c43)
        
        return label
    }()
    
    let currentBalanceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "saldo atual"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(rgb: 0x3c3c43)
        
        return label
    }()
    
    let percentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "% na carteira"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(rgb: 0x3c3c43)
        
        return label
    }()
    
    let currentBalanceValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 1400,00"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(rgb: 0xff007e)
        
        return label
    }()
    
    let percentValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "16,48%"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(rgb: 0xff007e)
        
        return label
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let secondaryStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    let balanceStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let percentStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .trailing
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutIfNeeded() {
        containerView.applyCornerRadius(radius: 4)
    }
    
    override func layoutSubviews() {
        containerView.applyCornerRadius(radius: 4)
    }
    
}

extension FundCellView: CodeView{
    func setupComponents() {
        
        addSubview(containerView)
        containerView.addSubview(accessoryDetailView)
        containerView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(subTitleLabel)
        mainStackView.addArrangedSubview(secondaryStackView)
        
        
        secondaryStackView.addArrangedSubview(balanceStackView)
        secondaryStackView.addArrangedSubview(percentStackView)
        
        balanceStackView.addArrangedSubview(currentBalanceLabel)
        balanceStackView.addArrangedSubview(currentBalanceValueLabel)
        
        percentStackView.addArrangedSubview(percentLabel)
        percentStackView.addArrangedSubview(percentValueLabel)
        
        
    }
    
    func setupConstraints() {
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        accessoryDetailView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        accessoryDetailView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        accessoryDetailView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        accessoryDetailView.widthAnchor.constraint(equalToConstant: 8).isActive = true

        mainStackView.leadingAnchor.constraint(equalTo: accessoryDetailView.trailingAnchor, constant: 20).isActive = true
        mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        
        percentStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor).isActive = true
        
    }
    
    func setupExtraConfigurations() {
        
    }
    
    
}



class FundTableViewCell: UITableViewCell {

//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var amountLabel: UILabel!
//    @IBOutlet weak var percentageLabel: UILabel!
//    @IBOutlet weak var amountTitleLabel: UILabel!
//    @IBOutlet weak var percentageTitleLabel: UILabel!
    
    static let identifier = "fundCell"

    let fundCellView = FundCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fundCellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fundCellView)
        fundCellView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        fundCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        fundCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        fundCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with title: String, amount: Double, userAmount: Double) {
        
        fundCellView.subTitleLabel.text = title.uppercased()
        fundCellView.currentBalanceValueLabel.text = "R$ \(amount)"
        fundCellView.percentValueLabel.text = "\((amount * 100/userAmount).rounded())%"
        
        
        
        
//        titleLabel.text = title.uppercased()
//        amountLabel.text = "R$ \(amount)"
//
//        percentageLabel.text = "\((amount * 100/userAmount).rounded())%"
        setupAccessibility()
    }

}

extension FundTableViewCell {
    func setupAccessibility() {
////        percentageTitleLabel.accessibilityLabel = ITIString.percentageTitle
//<<<<<<< HEAD
////        self.accessibilityElements = [titleLabel,amountTitleLabel, amountLabel, percentageTitleLabel, percentageLabel]
//=======
//        self.accessibilityElements = [titleLabel,amountTitleLabel, amountLabel, percentageTitleLabel, percentageLabel]
//>>>>>>> dev/2.0
    }
}
