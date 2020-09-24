//
//  LoginViewController.swift
//  ItiInvest
//
//  Created by Islas Girão Garcia on 23/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

protocol LoginButtonsProtocol: AnyObject{
    func didPressSignInButton()
    func didPressSignUpButton()
    func didPressTermsButton()
}


class LoginViewController: UIViewController {

    lazy var loginView: LoginView = {
        let view = LoginView(delegate: self)
        
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = loginView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

}
extension LoginViewController: LoginButtonsProtocol{
    func didPressSignInButton() {
        print("Login")
    }
    
    func didPressSignUpButton() {
        
    }
    
    func didPressTermsButton() {
        
    }
    
    
}

