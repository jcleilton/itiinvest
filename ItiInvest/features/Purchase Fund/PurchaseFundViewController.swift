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
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var stockTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var investButton: UIButton!
    
    @IBOutlet var accessoryView: UIView!
    
    
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
    
    var viewModel: PurchaseFundViewModel = PurchaseFundViewModel()
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        
        investButton.applyGradient(color1: ITIColor.orange, color2: ITIColor.purple, locations: [0.0, 1.0])
        investButton.applyCornerRadius()
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
        
        stockTextField.text = viewModel.stock.name
        amountTextField.text = String(viewModel.stock.amount)
        priceTextField.text = String(viewModel.stock.price)
        dateTextField.text = viewModel.dateString
        
    }
    
    @objc private func previousTextField() {
        // TODO: - Adicionar funcionalidade
    }
    
    @objc private func nextTextField() {
        // TODO: - Adicionar funcionalidade
    }
    
    @objc private func doneEditing() {
        stockTextField.resignFirstResponder()
        amountTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
    }
    
    @objc private func updateDate() {
        dateTextField.text = viewModel.dateString(from: datePicker.date)
    }
    
    @IBAction func didPressInvest(_ sender: UIButton) {
        viewModel.stock.name = stockTextField.text ?? ""
        viewModel.stock.amount = Int(amountTextField.text ?? "") ?? 0
        viewModel.stock.price = Double(priceTextField.text ?? "") ?? 0.0
        viewModel.stock.buyDate = Date()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        detailViewController.stock = viewModel.stock
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
