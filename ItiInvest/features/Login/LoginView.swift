//
//  LoginView.swift
//  ItiInvest
//
//  Created by Islas Girão Garcia on 23/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        applyGradient(color1: ITIColor.orange, color2: ITIColor.purple, locations: [0.0, 1.0])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient(color1: ITIColor.orange, color2: ITIColor.purple, locations: [0.0, 1.0])
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    

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
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("termos e condições", for: .normal)
        button.tintColor = ITIColor.orange
        
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
        addSubview(containerView)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(signInButton)
        addSubview(signUpButton)
        addSubview(termsButton)
    }
    
    func setupConstraints() {
        
        containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2).isActive = true
        
        containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        
        containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        
        emailTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32).isActive = true
        
        emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32).isActive = true
        
        emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32).isActive = true
        
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30).isActive = true

        passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32).isActive = true


        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50).isActive = true

        signInButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32).isActive = true

        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 32).isActive = true

        signUpButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32).isActive = true

        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        termsButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 32).isActive = true

        termsButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32).isActive = true
        termsButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32).isActive = true

        termsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
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
