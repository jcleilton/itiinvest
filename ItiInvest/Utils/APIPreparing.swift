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

class RealTimeManager {
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
    
    func signUp(email: String, password: String, onCompletion: @escaping((User?, String?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let authErrorCode = AuthErrorCode(rawValue: error._code)
                switch authErrorCode {
                case .credentialAlreadyInUse:
                    onCompletion(nil,"")
                case .emailAlreadyInUse:
                    onCompletion(nil,"")
                case .invalidEmail:
                    onCompletion(nil,"")
                case .missingEmail:
                    onCompletion(nil,"")
                case .weakPassword:
                    onCompletion(nil,"")
                default:
                    onCompletion(nil,error.localizedDescription)
                }
                onCompletion(nil,error.localizedDescription)
            } else {
                if let user = authResult?.user {
                    onCompletion(user,nil)
                } else {
                    onCompletion(nil,"Não foi possível criar o usuário")
                }
            }
        }
    }
    
    func signIn(email: String, password: String, onCompletion: @escaping((User?, String?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let authErrorCode = AuthErrorCode(rawValue: error._code)
                switch authErrorCode {
                case .invalidCredential:
                    onCompletion(nil,"")
                case .emailAlreadyInUse:
                    onCompletion(nil,"")
                case .invalidEmail:
                    onCompletion(nil,"")
                case .wrongPassword:
                    onCompletion(nil,"")
                case .userNotFound:
                    onCompletion(nil,"")
                case .weakPassword:
                    onCompletion(nil,"")
                case .none:
                    onCompletion(nil,error.localizedDescription)
                case .some(_):
                    onCompletion(nil,error.localizedDescription)
                }
            } else {
                if let user = authResult?.user {
                    onCompletion(user,nil)
                } else {
                    
                }
            }
        }
    }
}
