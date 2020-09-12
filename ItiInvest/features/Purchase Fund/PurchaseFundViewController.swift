//
//  PurchaseFundViewController.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

fileprivate enum LabelType {
    case title, description
}

fileprivate func getLabel(text: String, type: LabelType) -> UILabel {
    let label = UILabel()
    label.text = text
    switch type {
    case .title:
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.semibold)
        label.textColor = UIColor.black
        break
    case .description:
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        label.textColor = UIColor.darkGray
        break
    }
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    return label
}

fileprivate func getTextField(placeholder: String? = nil, keyboardType: UIKeyboardType) -> UITextField {
    let textField = UITextField()
    textField.placeholder = placeholder
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
    textField.textColor = UIColor.black
    textField.backgroundColor = .systemGroupedBackground
    textField.keyboardType = keyboardType
    textField.borderStyle = .roundedRect
    return textField
}

final class PurchaseFundViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    let titleLabel: UILabel = {
        let label = getLabel(text: "", type: .title)
        return label
    }()
    
    let stockLabel: UILabel = {
        let label = getLabel(text: "Ativo", type: .description)
        return label
    }()
    let amountLabel: UILabel = {
        let label = getLabel(text: "Quantidade", type: .description)
        return label
    }()
    let priceLabel: UILabel = {
        let label = getLabel(text: "Preço de Compra", type: .description)
        return label
    }()
    let dateLabel: UILabel = {
        let label = getLabel(text: "Data de Início", type: .description)
        return label
    }()
    let stockTextField: UITextField = {
        let textField = getTextField(placeholder: nil, keyboardType: UIKeyboardType.default)
        return textField
    }()
    let amountTextField: UITextField = {
        let textField = getTextField(placeholder: nil, keyboardType: UIKeyboardType.numberPad)
        textField.tag = 1
        return textField
    }()
    let priceTextField: UITextField = {
        let textField = getTextField(placeholder: nil, keyboardType: UIKeyboardType.numberPad)
        textField.tag = 2
        return textField

    }()
    let dateTextField: UITextField = {
        let textField = getTextField(placeholder: nil, keyboardType: UIKeyboardType.default)
        return textField

    }()
    
    let investButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.applyCornerRadius()
        button.setTitle("Investir", for: .normal)
        button.backgroundColor = ITIColor.orange
        return button
    }()
    
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
    
    private var bottomConstraint: NSLayoutConstraint?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - IBActions
    
    @objc private func closeTouched(_ sender: UIButton) {
        guard let quantity = amountTextField.text, let name = stockTextField.text, let price = priceTextField.text else {
            return
        }
        do {
            try viewModel.save(quantity: quantity, buyDate: datePicker.date, name: name, price: price)
            self.dismiss(animated: true, completion: nil)
        } catch {
            
        }
        
    }
    
    @objc func didChangePrice(_ sender: UITextField, value: String, forCurrency: Bool = true) {
        sender.text = viewModel.currencyFormattedFrom(string: value, forCurrency: forCurrency)
    }
    
    // MARK: - Private Functions
    
    @objc private func previousTextField() {
        if stockTextField.isEditing {
            dateTextField.becomeFirstResponder()
        } else if amountTextField.isEditing {
            stockTextField.becomeFirstResponder()
        } else if priceTextField.isEditing {
            amountTextField.becomeFirstResponder()
        } else if dateTextField.isEditing {
            priceTextField.becomeFirstResponder()
        }
    }
    
    @objc private func nextTextField() {
        if stockTextField.isEditing {
            amountTextField.becomeFirstResponder()
        } else if amountTextField.isEditing {
            priceTextField.becomeFirstResponder()
        } else if priceTextField.isEditing {
            dateTextField.becomeFirstResponder()
        } else if dateTextField.isEditing {
            stockTextField.becomeFirstResponder()
        }
    }
    
    @objc private func doneEditing() {
        view.endEditing(true)
    }
    
    @objc private func updateDate() {
        dateTextField.text = viewModel.dateString(from: datePicker.date)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}

        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let animation = UIView.AnimationOptions(rawValue: userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: animation, animations: { [weak self] in
            self?.bottomConstraint?.constant = (Constant.Margin.verticalNormal + keyboardFrame.height) * -1
            self?.navigationController?.navigationBar.isHidden = true
            self?.view.layoutIfNeeded()
        }) { (success) in
            print("Teclado terminou de aparecer")
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.bottomConstraint?.constant = -Constant.Margin.verticalNormal
        self.navigationController?.navigationBar.isHidden = false
        self.view.layoutIfNeeded()
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
            left: (anchor: view.leftAnchor, constant: Constant.Margin.horizontalNormal),
            right: (anchor: view.rightAnchor, constant: -Constant.Margin.horizontalNormal))
        let topConstraint = titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.Margin.verticalNormal)
        topConstraint.priority = .defaultLow
        topConstraint.isActive = true
        
        stockLabel.anchor(
            top: (anchor: titleLabel.bottomAnchor, constant: Constant.Margin.verticalLarge),
            left: (anchor: titleLabel.leftAnchor, constant: 0),
            right: (anchor: titleLabel.rightAnchor, constant: 0),
            height: 18)
        
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
        
        let bottomContraint = dateTextField.bottomAnchor.constraint(lessThanOrEqualTo: investButton.topAnchor, constant: -Constant.Margin.verticalSmall)
        bottomContraint.isActive = true

        investButton.anchor(
            centerX: (anchor: view.centerXAnchor, constant: 0),
            relativeWidth: (anchor: dateTextField.widthAnchor, multiplier: 1, constant: 0),
            height: 40)

        self.bottomConstraint = investButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.Margin.verticalNormal)
        self.bottomConstraint?.isActive = true
        
    }
    
    func setupExtraConfigurations() {
        view.backgroundColor = .white
        
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
        
        self.titleLabel.text = viewModel.getTitle
        self.stockTextField.text = viewModel.stockName
        self.amountTextField.text = viewModel.stockAmount
        self.dateTextField.text = viewModel.stockDate
        self.priceTextField.text = viewModel.stockPrice
    }
    
    
}

extension PurchaseFundViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case 0, 3:
            return true
        case 1, 2:
            if let text = textField.text,
               let textRange = Range(range, in: text) {
               let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                self.didChangePrice(textField, value: updatedText, forCurrency: textField.tag == 2)
            }
            
            return false
        default:
            return false
        }
    }
}
