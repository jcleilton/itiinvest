//
//  LoginViewModel.swift
//  ItiInvest
//
//  Created by Islas Girão Garcia on 23/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation

protocol LoginDisplay: AnyObject {
    func displayLoginSuccess()
    func displayCreateAccountSuccess()
    func displayError(title: String, message: String)
}

protocol LoginViewModeling {
    func createAccount(email: String, password: String)
    func login(email: String, password: String)
}

final class LoginViewModel: LoginViewModeling {
    private weak var viewController: LoginDisplay?
    private let auth: FirebaseAuthing
    
    init(viewController: LoginDisplay, auth: FirebaseAuthing) {
        self.viewController = viewController
        self.auth = auth
    }
    
    func createAccount(email: String, password: String) {
        guard !email.isEmpty && !password.isEmpty else {
            viewController?.displayError(title: "Erro", message: "Preencha os campos")
            return
        }
        auth.signUp(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.viewController?.displayCreateAccountSuccess()
            case let .failure(error):
                self?.handleFailure(error: error)
            }
        }
    }
    
    func login(email: String, password: String) {
        guard !email.isEmpty && !password.isEmpty else {
            viewController?.displayError(title: "Erro", message: "Preencha os campos de login")
            return
        }
        auth.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.viewController?.displayLoginSuccess()
            case let .failure(error):
                self?.handleFailure(error: error)
            }
        }
    }
    
    private func handleFailure(error: FirebaseError) {
        let title = titleError(error)
        let description = descriptionError(error)
        viewController?.displayError(title: title, message: description)
    }
    
    private func titleError(_ error: FirebaseError) -> String {
        switch error {
        case .invalidEmail, .incorrectPassword, .nonexistentAccount, .unknown:
            return "Erro"
        case .weakPassword, .userAlreadyExists:
            return "Erro no cadastro"
        }
    }
    
    private func descriptionError(_ error: FirebaseError) -> String {
        switch error {
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
        case .unknown:
            return "Erro com o serviço"
        }
    }
}
