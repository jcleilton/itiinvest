//
//  Alert.swift
//  ItiInvest
//
//  Created by Cleilton Feitosa on 16/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class Alert {
    static func defaultWithOKButton(in viewController: UIViewController, title: String, subtitle: String, action: @escaping(() -> Void)) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { _ in
            action()
        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func defaultWithOKButtonAndCancel(in viewController: UIViewController, title: String, subtitle: String, okAction: @escaping(() -> Void), cancelAction: @escaping(() -> Void)) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { _ in
            okAction()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.destructive) { (_) in
            cancelAction()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
