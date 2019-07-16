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
    let date = Date()
    let format = DateFormatter()
    var stockTransaction = [Transaction]()
    

    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var stockChangeLabel: UILabel!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var stockNameSellLabel: UILabel!
    @IBOutlet weak var stockAmountLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var sellButton: UIButton!
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
        
        buyButton.isEnabled = false
        buyButton.alpha = 0.8
        sellButton.isEnabled = false
        sellButton.alpha = 0.8
        
        if(stockPercentage > 0)
        {
            stockChangeLabel.backgroundColor = .green
        }
        else
        {
            stockChangeLabel.backgroundColor = .red
        }
        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        //2
        var transactions = [Transaction]()
        
        
        do {
            transactions = try managedContext!.fetch(Transaction.fetchRequest())
            var indexCounter = 0
            for transaction in transactions{
                if transaction.name == stockName
                {
                    stockTransaction.append(transaction)
                    indexCounter+=1
                }
            }
        } catch  {
            print("Gagal Memanggil")
        }
    }
    
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let transaction = Transaction(context: managedContext)
        
        transaction.name = stockName
        transaction.price = stockPrice
        transaction.amount = Int64(buyAmountTextField.text!)!
        transaction.date = Date()
        transaction.type = "Buy"
        
        do {
            try managedContext.save()
        } catch  {
            print("gagal menyimpan")
        }
        
        buyAmountTextField.text = ""
        buyButton.isEnabled = false
        buyButton.alpha = 0.8
    }
    
     @IBAction func sellButtonTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let transaction = Transaction(context: managedContext)
        
        transaction.name = stockName
        transaction.price = stockPrice
        transaction.amount = Int64(sellAmountTextField.text!)!
        transaction.date = Date()
        transaction.type = "Sell"
        
        do {
            try managedContext.save()
        } catch  {
            print("gagal menyimpan")
        }
        sellAmountTextField.text = ""
        sellButton.isEnabled = false
        sellButton.alpha = 0.8
     }
    @IBAction func buyTextFieldEditingChanged(_ sender: Any) {
        buyButton.isEnabled = true
        buyButton.alpha = 1
    }
    @IBAction func sellTextFieldEditingChanged(_ sender: Any) {
        sellButton.isEnabled = true
        sellButton.alpha = 1
    }
    
    
    
//    func sellData () {
//
//        //1
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//
//        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
//
//        //2
//        var users = [User]()
//
//        do {
//            users = try managedContext.fetch(User.fetchRequest())
//            for user in users {
//                let name = user.name
//                let age = user.age
//                nameLabel.text! += "\(name!) \(age), "
//                print(name!)
//            }
//        } catch  {
//            print("Gagal Memanggil")
//        }
//    }
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension TableDetailViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockTransaction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell") as! TransactionCell
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        
        cell.dateLabel.text = formattedDate
        //cell.typeLabel.text =
        cell.priceLabel.text = "\(stockTransaction[indexPath.row].price)"
        cell.amountLabel.text = "\(stockTransaction[indexPath.row].amount)"
        
        return cell
    }
    
}
