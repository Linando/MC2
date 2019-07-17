//
//  PortofolioViewController.swift
//  MC2
//
//  Created by Linando Saputra on 17/07/19.
//  Copyright © 2019 Linando Saputra. All rights reserved.
//

import UIKit

class PortofolioViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var totalBuyValLabel: UILabel!
    @IBOutlet weak var totalMarketValLabel: UILabel!
    @IBOutlet weak var unrealizedGainLossLabel: UILabel!
    @IBOutlet weak var netAssetLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        
        let balance = UserDefaults.standard.integer(forKey: "balance")
        if balance > 0{
            
            balanceLabel.text = "\(balance)"
        }else{
            balanceLabel.text = "0"
        }
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        //2
        var transactions = [Transaction]()
        
        
        do {
            transactions = try managedContext!.fetch(Transaction.fetchRequest())
            var indexCounter = 0
            var stockAmount: Int64 = 0
            var totalBuyValue: Float = 0
            for transaction in transactions{
                totalBuyValue += Float(transaction.amount) * transaction.price
            }
            print(totalBuyValue)
            totalBuyValLabel.text = "\(totalBuyValue)"
        } catch  {
            print("Gagal Memanggil")
        }
        
        // Do any additional setup after loading the view.
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//
//        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
//
//        //2
//        var users = [User]()
//
//        do {
//            users = try managedContext.fetch(User.fetchRequest())
//            balanceLabel.text = "\(users[users.count-1].balance)"
//        } catch  {
//            print("Gagal Memanggil")
//        }
        
    }

}
