//
//  DepositViewController.swift
//  MC2
//
//  Created by Evan Christian on 12/07/19.
//  Copyright © 2019 Linando Saputra. All rights reserved.
//

import UIKit

class DepositViewController: UIViewController {
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var balanceTotalLabel: UILabel!
    @IBOutlet weak var depositButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moneyTextField.keyboardType = UIKeyboardType.numberPad
        depositButton.isEnabled = false
        depositButton.alpha = 0.5
        //User Defaults
        let balance = UserDefaults.standard.integer(forKey: "balance")
        balanceTotalLabel.text = "\(balance)"
    }
    
    
    
    
    @IBAction func moneyTextFieldEditingChanged(_ sender: Any) {
        depositButton.isEnabled = true
        depositButton.alpha = 1
    }
    
    
    
    @IBAction func depositButtonTapped(_ sender: Any) {
        let balance:Int = Int(balanceTotalLabel.text!)!
        let moneyInput:Int = Int(moneyTextField.text!)!
        balanceTotalLabel.text = "\(balance + moneyInput)"
        UserDefaults.standard.set(Int(balanceTotalLabel.text!)!, forKey: "balance")
        moneyTextField.text = ""
        depositButton.isEnabled = false
        depositButton.alpha = 0.5
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
