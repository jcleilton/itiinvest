//
//  PurchaseFundViewController.swift
//  ItiInvest
//
//  Created by Gabriel Henrique Paul on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

class PurchaseFundViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
