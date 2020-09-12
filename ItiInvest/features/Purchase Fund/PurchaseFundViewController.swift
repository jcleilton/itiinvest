//
//  PurchaseFundViewController.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

final class PurchaseFundViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Preencha as informações sobre a sua nova compra de ações"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stockLabel: UILabel = {
        let label = UILabel()
        label.text = "Ativo"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Quantidade"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Preço de Compra"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Data de Início"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let stockTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let investButton = UIButton()
    let accessoryView = UIView()
    
    // MARK: - Private Attributes
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(updateDate), for: .valueChanged)
        return datePicker
    }()
    
    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: .zero)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let previousButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: nil, action: #selector(previousTextField))
        let nextButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: nil, action: #selector(nextTextField))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEditing))
        let items = [previousButton, nextButton, flexibleSpace, doneButton]
        toolbar.setItems(items, animated: false)
        toolbar.sizeToFit()
        return toolbar
    }()
    
    private var viewModel: PurchaseFundViewModel
    
    // MARK: - Init
    
    init(viewModel: PurchaseFundViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = PurchaseFundViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - IBActions
    
    @IBAction private func closeTouched(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didChangePrice(_ sender: UITextField) {
        sender.text = viewModel.currencyFormattedFrom(string: sender.text ?? "")
    }
    
    // MARK: - Private Functions
    
    @objc private func previousTextField() {
        
    }
    
    @objc private func nextTextField() {
        
    }
    
    @objc private func doneEditing() {
        becomeFirstResponder()
    }
    
    @objc private func updateDate() {
        dateTextField.text = viewModel.dateString(from: datePicker.date)
    }
}

extension PurchaseFundViewController: CodeView {
    func setupComponents() {
        view.addSubview(titleLabel)
        view.addSubview(stockLabel)
        view.addSubview(amountLabel)
        view.addSubview(priceLabel)
        view.addSubview(dateLabel)
        view.addSubview(stockTextField)
        view.addSubview(amountTextField)
        view.addSubview(priceTextField)
        view.addSubview(dateTextField)
        view.addSubview(investButton)
        view.addSubview(accessoryView)
    }
    
    func setupConstraints() {
        titleLabel.anchor(
            top: (anchor: view.safeAreaLayoutGuide.topAnchor, constant: Constant.Margin.verticalNormal),
            left: (anchor: view.leftAnchor, constant: Constant.Margin.horizontalNormal),
            right: (anchor: view.rightAnchor, constant: -Constant.Margin.horizontalNormal))
        
        stockLabel.anchor(
            top: (anchor: titleLabel.bottomAnchor, constant: Constant.Margin.verticalLarge),
            left: (anchor: titleLabel.leftAnchor, constant: 0),
            right: (anchor: titleLabel.rightAnchor, constant: 0),
            height: 30)
        
        stockTextField.anchor(
            centerX: (anchor: stockLabel.centerXAnchor, constant: 0),
            top: (anchor: stockLabel.bottomAnchor, constant: Constant.Margin.verticalSmall),
            relativeWidth: (anchor: stockLabel.widthAnchor, multiplier: 1, constant: 0),
            height: 40)
        
        amountLabel.anchor(
            top: (anchor: stockTextField.bottomAnchor, constant: Constant.Margin.verticalNormal),
            left: (anchor: stockTextField.leftAnchor, constant: 0),
            right: (anchor: stockTextField.rightAnchor, constant: 0),
            relativeHeight: (anchor: stockLabel.heightAnchor, multiplier: 1, constant: 0))
        
        amountTextField.anchor(
            centerX: (anchor: amountLabel.centerXAnchor, constant: 0),
            top: (anchor: amountLabel.bottomAnchor, constant: Constant.Margin.verticalSmall),
            relativeHeight: (anchor: stockTextField.heightAnchor, multiplier: 1, constant: 0),
            relativeWidth: (anchor: amountLabel.widthAnchor, multiplier: 1, constant: 0))
        
        priceLabel.anchor(
            top: (anchor: amountTextField.bottomAnchor, constant: Constant.Margin.verticalNormal),
            left: (anchor: amountTextField.leftAnchor, constant: 0),
            right: (anchor: amountTextField.rightAnchor, constant: 0),
            relativeHeight: (anchor: stockLabel.heightAnchor, multiplier: 1, constant: 0))
        
        priceTextField.anchor(
            centerX: (anchor: priceLabel.centerXAnchor, constant: 0),
            top: (anchor: priceLabel.bottomAnchor, constant: Constant.Margin.verticalSmall),
            relativeHeight: (anchor: stockTextField.heightAnchor, multiplier: 1, constant: 0),
            relativeWidth: (anchor: priceLabel.widthAnchor, multiplier: 1, constant: 0))
        
        dateLabel.anchor(
            top: (anchor: priceTextField.bottomAnchor, constant: Constant.Margin.verticalNormal),
            left: (anchor: priceTextField.leftAnchor, constant: 0),
            right: (anchor: priceTextField.rightAnchor, constant: 0),
            relativeHeight: (anchor: stockLabel.heightAnchor, multiplier: 1, constant: 0))
        
        dateTextField.anchor(
            centerX: (anchor: dateLabel.centerXAnchor, constant: 0),
            top: (anchor: dateLabel.bottomAnchor, constant: Constant.Margin.verticalSmall),
            relativeHeight: (anchor: stockTextField.heightAnchor, multiplier: 1, constant: 0),
            relativeWidth: (anchor: dateLabel.widthAnchor, multiplier: 1, constant: 0))
        
        
        
        
        //        priceLabel
        //        priceTextField
        //        dateLabel
        //        dateTextField
        //        investButton
        //        accessoryView
    }
    
    func setupExtraConfigurations() {
        view.backgroundColor = .white
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        stockTextField.delegate = self
        amountTextField.delegate = self
        priceTextField.delegate = self
        dateTextField.delegate = self
        
        stockTextField.tag = 0
        amountTextField.tag = 1
        priceTextField.tag = 2
        dateTextField.tag = 3
        
        amountTextField.keyboardType = .numberPad
        priceTextField.keyboardType = .numberPad
        
        dateTextField.inputView = datePicker
        
        toolbar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        
        stockTextField.inputAccessoryView = toolbar
        amountTextField.inputAccessoryView = toolbar
        priceTextField.inputAccessoryView = toolbar
        dateTextField.inputAccessoryView = toolbar
    }
    
    
}

extension PurchaseFundViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField.tag {
        case 0, 3:
            return true
        case 1, 2:
            return NSCharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        default:
            return false
        }
    }
}
