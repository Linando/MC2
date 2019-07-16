//
//  TableDetailViewController.swift
//  MC2
//
//  Created by Evan Christian on 16/07/19.
//  Copyright © 2019 Linando Saputra. All rights reserved.
//

import UIKit

class TableDetailViewController: UIViewController {

    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var stockChangeLabel: UILabel!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var stockNameSellLabel: UILabel!
    
    var money:Int = 0
    var stockName = ""
    var stockPrice:Int = 0
    var stockChange:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalBalanceLabel.text = "\(money)"
        stockNameLabel.text = stockName
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
