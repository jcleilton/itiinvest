//
//  FundsListView.swift
//  ItiInvest
//
//  Created by Islas Girão Garcia on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class GradientButton: UIButton{
    
    init() {
        super.init(frame: .zero)
        tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        applyGradient(color1: UIColor(rgb: 0xfb5990), color2: UIColor(rgb: 0xe96e1f), locations: [0.0, 1.0])
        applyCornerRadius()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient(color1: UIColor(rgb: 0xfb5990), color2: UIColor(rgb: 0xe96e1f), locations: [0.0, 1.0])
        applyCornerRadius()
    }
    
}

class FundsListView: UIView {
    
    // MARK: - Properties
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    let valueStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    let patrimonyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "meu patrimônio"
        label.font = UIFont(name: "HelveticaNeue-Bold", size:  16.0)
        label.textColor = UIColor(rgb: 0xf6b592)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 0.00"
        label.font = UIFont(name: "HelveticaNeue-Bold", size:  33.0)
        label.textColor = .white
        return label
    }()
    
    let hideValueButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    let bottomButton: UIButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setTitle("novo investimento", for: .normal)
        return button
    }()
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        headerView.applyGradient(color1: UIColor(rgb: 0xe96f1f), color2: UIColor(rgb: 0xf26350), locations: [0.0, 1.0])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        headerView.applyGradient(color1: UIColor(rgb: 0xe96f1f), color2: UIColor(rgb: 0xf26350), locations: [0.0, 1.0])
    }
    
}

extension FundsListView: CodeView{
    func setupComponents() {
        addSubview(headerView)
        addSubview(containerView)
        
        headerView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(patrimonyLabel)
        mainStackView.addArrangedSubview(valueStackView)
        valueStackView.addArrangedSubview(valueLabel)
        valueStackView.addArrangedSubview(hideValueButton)
        
        
        
        
//        headerView.addSubview(patrimonyLabel)
//        headerView.addSubview(valueLabel)
//        headerView.addSubview(hideValueButton)
        
        containerView.addSubview(tableView)
        containerView.addSubview(bottomButton)
    }
    
    func setupConstraints() {

        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        mainStackView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 80).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -40).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
        
        hideValueButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        hideValueButton.widthAnchor.constraint(equalToConstant: 20).isActive = true

        containerView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        bottomButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40).isActive = true
        bottomButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        bottomButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        bottomButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        tableView.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: -20).isActive = true
        
    }
    
    func setupExtraConfigurations() {
        
        
    }
    
}
