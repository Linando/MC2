//
//  StockViewController.swift
//  MC2
//
//  Created by Evan Christian on 12/07/19.
//  Copyright © 2019 Linando Saputra. All rights reserved.
//

import UIKit


class StockViewController: UIViewController {

    @IBOutlet weak var balanceTotalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let balance = UserDefaults.standard.integer(forKey: "balance")
        if balance > 0{
            
            balanceTotalLabel.text = "Rp. \(balance.formattedWithSeparator)"
        }else{
            balanceTotalLabel.text = "0"
        }
        // Do any additional setup after loading the view.
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
