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
    
    let titleLabel = UILabel()
    
    let stockLabel = UILabel()
    let amountLabel = UILabel()
    let priceLabel = UILabel()
    let dateLabel = UILabel()
    let stockTextField = UITextField()
    let amountTextField = UITextField()
    let priceTextFiel = UITextField()
    let dateTextField = UITextField()
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
        
        configureTextFields()
    }
    
    // MARK: - IBActions
    
    @IBAction private func closeTouched(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didChangePrice(_ sender: UITextField) {
        sender.text = viewModel.currencyFormattedFrom(string: sender.text ?? "")
    }

    // MARK: - Private Functions
    
    private func configureTextFields() {
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
