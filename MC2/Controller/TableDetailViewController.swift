//
//  TableDetailViewController.swift
//  MC2
//
//  Created by Evan Christian on 16/07/19.
//  Copyright © 2019 Linando Saputra. All rights reserved.
//

import UIKit
import CoreData

class TableDetailViewController: UIViewController {

    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var stockChangeLabel: UILabel!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var stockNameSellLabel: UILabel!
    
    @IBOutlet weak var buyAmountTextField: UITextField!
    @IBOutlet weak var sellAmountTextField: UITextField!
    var money:Int = 0
    var stockName = ""
    var stockPrice:Float = 0
    var stockPercentage:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalBalanceLabel.text = "\(money)"
        stockNameLabel.text = stockName
        stockPriceLabel.text = "\(stockPrice)"
        stockChangeLabel.text = "\(stockPercentage)"
        stockNameSellLabel.text = stockName
        
        if(stockPercentage > 0)
        {
            stockChangeLabel.backgroundColor = .green
        }
        else
        {
            stockChangeLabel.backgroundColor = .red
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let buy = Buy(context: managedContext)
        
        buy.name = stockName
        buy.price = stockPrice
        buy.amount = Int64(buyAmountTextField.text!)!
        buy.date = Date()
        
        do {
            try managedContext.save()
        } catch  {
            print("gagal menyimpan")
        }
    }
    
     @IBAction func sellButtonTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let sell = Sell(context: managedContext)
        
        sell.name = stockName
        sell.price = stockPrice
        sell.amount = Int64(sellAmountTextField.text!)!
        sell.date = Date()
        
        do {
            try managedContext.save()
        } catch  {
            print("gagal menyimpan")
        }
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
