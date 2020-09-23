//
//  LoginView.swift
//  ItiInvest
//
//  Created by Islas Girão Garcia on 23/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class LoginView: UIView {

    let emailTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Login"
        
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Senha"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let signInButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("entrar", for: .normal)
        return button
    }()
    
    let signUpButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("cadastrar", for: .normal)
        return button
    }()
    
    let termsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("termos e condições", for: .normal)
        return button
    }()
    
    weak var delegate: LoginButtonsProtocol?
    
    init(delegate: LoginButtonsProtocol){
        super.init(frame: .zero)
        self.delegate = delegate
        backgroundColor = .white
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}

extension LoginView: CodeView {
    
    
    func setupComponents() {
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(signInButton)
//        addSubview(signUpButton)
//        addSubview(termsButton)
    }
    
    func setupConstraints() {
        
        emailTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        emailTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        
        emailTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30).isActive = true

        passwordTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true


        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50).isActive = true

        signInButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true

        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func setupExtraConfigurations(){
        signInButton.addTarget(self, action: #selector(didPressSignInButton), for: .touchUpInside)
    }
    
}

extension LoginView{
    @objc func didPressSignInButton(){
        delegate?.didPressSignInButton()
    }
}
