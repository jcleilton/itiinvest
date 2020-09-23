//
//  LoginViewModel.swift
//  ItiInvest
//
//  Created by Islas Girão Garcia on 23/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case invalidEmail
    case incorrectPassword
    case weakPassword
    case nonexistentAccount
    case userAlreadyExists
    
    var title: String {
        switch self {
        case .invalidEmail, .incorrectPassword, .nonexistentAccount:
            return "Erro"
        case .weakPassword, .userAlreadyExists:
            return "Erro no cadastro"
        }
    }
    
    var description: String {
        switch self {
        case .invalidEmail:
            return "E-mail inválido"
        case .incorrectPassword:
            return "Senha incorreta"
        case .nonexistentAccount:
            return "Conta inexistente"
        case .weakPassword:
            return "Senha fraca"
        case .userAlreadyExists:
            return "Email já em uso"
        }
    }
}

protocol LoginDisplay: AnyObject {
    func displayError(title: String, message: String)
}

protocol LoginViewModeling {
    func createAccount(email: String, password: String)
    func login(email: String, password: String)
}

protocol FirebaseAuthing {
    func createAccount(email: String, password: String, completion: (Result<Void, LoginError>)->Void)
    func login(email: String, password: String, completion: (Result<Void, LoginError>)->Void)
}

final class LoginViewModel: LoginViewModeling {
    private weak var viewController: LoginDisplay
    private let auth: FirebaseAuthing
    
    init(viewController: LoginDisplay, auth: FirebaseAuthing) {
        self.viewController = viewController
        self.auth = auth
    }
    
    func createAccount(email: String, password: String) {
        
    }
    
    func login(email: String, password: String) {
        auth.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                break
            case let .failure(error):
                self?.handleFailure(error: error)
            }
        }
    }
    
    private func handleFailure(error: LoginError) {
        viewController.displayError(title: error.title, message: error.description)
    }
}
