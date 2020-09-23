//
//  APIPreparing.swift
//  ItiInvest
//
//  Created by Cleilton Feitosa on 19/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import Foundation
import Firebase

fileprivate let collection = "stocks"

enum FirebaseError: Error {
    case invalidEmail
    case incorrectPassword
    case weakPassword
    case nonexistentAccount
    case userAlreadyExists
    case unknown
}

protocol FirebaseAuthing {
    func signUp(email: String, password: String, onCompletion: @escaping(Result<User, FirebaseError>) -> Void)
    func signIn(email: String, password: String, onCompletion: @escaping(Result<User, FirebaseError>) -> Void)
}

class RealTimeManager: FirebaseAuthing {
    private var ref: DatabaseReference
    
    static let shared: RealTimeManager = {
        let api = RealTimeManager(ref: Database.database().reference())
        return api
    }()
    
    fileprivate init(ref: DatabaseReference) {
        self.ref = ref
    }
    
    var symbols: [FIRStock] = []
    
    func loadData(onCompletion: @escaping(([FIRStock]) -> Void)) {
        self.ref.child(collection).observeSingleEvent(of: .value, with: { (snapshot) in
            var stocks = [FIRStock]()
            if let value = snapshot.value as? [String:Any] {
                for dic in value {
                    if let data = dic.value as? [String:String] {
                        let stock = FIRStock(id: dic.key, name: data["name"] ?? "", symbol: data["symbol"] ?? "")
                        stocks.append(stock)
                    }
                }
            }
            onCompletion(stocks)
        })
    }
    
    func fetchSymbols() {
        loadData() { [weak self] result in
            self?.symbols = result
        }
    }
    
    func signUp(email: String, password: String, onCompletion: @escaping(Result<User, FirebaseError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let authErrorCode = AuthErrorCode(rawValue: error._code)
                switch authErrorCode {
                case .credentialAlreadyInUse, .emailAlreadyInUse:
                    onCompletion(.failure(.userAlreadyExists))
                case .invalidEmail:
                    onCompletion(.failure(.invalidEmail))
                case .weakPassword:
                    onCompletion(.failure(.weakPassword))
                default:
                    onCompletion(.failure(.unknown))
                }
            } else if let user = authResult?.user {
                onCompletion(.success(user))
            } else {
                onCompletion(.failure(.unknown))
            }
        }
    }
    
    func signIn(email: String, password: String, onCompletion: @escaping(Result<User, FirebaseError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let authErrorCode = AuthErrorCode(rawValue: error._code)
                switch authErrorCode {
                case .credentialAlreadyInUse, .emailAlreadyInUse:
                    onCompletion(.failure(.userAlreadyExists))
                case .invalidEmail:
                    onCompletion(.failure(.invalidEmail))
                case .weakPassword:
                    onCompletion(.failure(.weakPassword))
                default:
                    onCompletion(.failure(.unknown))
                }
            } else if let user = authResult?.user {
                onCompletion(.success(user))
            } else {
                onCompletion(.failure(.unknown))
            }
        }
    }
}
