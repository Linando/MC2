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
    
    var sortedTodayStock: [TimeSeries.StockDate] = []
    var todayBlueChipPrice: [Float] = []
    var todayMidCapPrice: [Float] = []
    var todayPennyStockPrice: [Float] = []
    
    var stockTransaction = [Transaction]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        let date = Date()
        let calendar = Calendar.current
        let dateStart = calendar.startOfDay(for: UserDefaults.standard.object(forKey: "lastLoginDate") as! Date)
        let dateEnd = calendar.startOfDay(for: date)
        
        let differenceInDay = calendar.dateComponents([.day], from: dateStart, to: dateEnd).day
        let balance = UserDefaults.standard.integer(forKey: "balance")
        if balance > 0{
            
            balanceLabel.text = "\(balance)"
        }else{
            balanceLabel.text = "0"
        }
        
        for i in 0...9
        {
            do {
                let decodedBlueChip = try JSONDecoder().decode(Stock.self, from: blueChipJSON[i])
                sortedTodayStock = decodedBlueChip.timeSeries.stockDates.sorted(by: { $0.date > $1.date })
                todayBlueChipPrice.append(Float(sortedTodayStock[98-differenceInDay!].open)!)
                let decodedMidCap = try JSONDecoder().decode(Stock.self, from: midCapJSON[i])
                sortedTodayStock = decodedMidCap.timeSeries.stockDates.sorted(by: { $0.date > $1.date })
                todayMidCapPrice.append(Float(sortedTodayStock[98-differenceInDay!].open)!)
                let decodedPennyStock = try JSONDecoder().decode(Stock.self, from: pennyStockJSON[i])
                sortedTodayStock = decodedPennyStock.timeSeries.stockDates.sorted(by: { $0.date > $1.date })
                todayPennyStockPrice.append(Float(sortedTodayStock[98-differenceInDay!].open)!)
            } catch let err{
                print("Gagal decode harga hari ini", err)
            }
        }
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        //2
        var transactions = [Transaction]()
        
        
        do {
            transactions = try managedContext!.fetch(Transaction.fetchRequest())
            var totalBuyValue: Float = 0
            var totalMarketValue: Float = 0
            for transaction in transactions{
                if(transaction.type == "Buy")
                {
                    totalBuyValue += Float(transaction.amount) * transaction.price
                    
                    if((blueChipSymbol.firstIndex(of: transaction.name!)) != nil)
                    {
                        totalMarketValue += Float(transaction.amount) * todayBlueChipPrice[blueChipSymbol.firstIndex(of: transaction.name!)!]
                    }
                    if((midCapSymbol.firstIndex(of: transaction.name!)) != nil)
                    {
                        totalMarketValue += Float(transaction.amount) * todayBlueChipPrice[midCapSymbol.firstIndex(of: transaction.name!)!]
                    }
                    if((pennyStockSymbol.firstIndex(of: transaction.name!)) != nil)
                    {
                        totalMarketValue += Float(transaction.amount) * todayBlueChipPrice[pennyStockSymbol.firstIndex(of: transaction.name!)!]
                    }
                }
                else
                {
                    totalBuyValue -= Float(transaction.amount) * transaction.price
                    if((blueChipSymbol.firstIndex(of: transaction.name!)) != nil)
                    {
                        totalMarketValue -= Float(transaction.amount) * todayBlueChipPrice[blueChipSymbol.firstIndex(of: transaction.name!)!]
                    }
                    if((midCapSymbol.firstIndex(of: transaction.name!)) != nil)
                    {
                        totalMarketValue -= Float(transaction.amount) * todayBlueChipPrice[midCapSymbol.firstIndex(of: transaction.name!)!]
                    }
                    if((pennyStockSymbol.firstIndex(of: transaction.name!)) != nil)
                    {
                        totalMarketValue -= Float(transaction.amount) * todayBlueChipPrice[pennyStockSymbol.firstIndex(of: transaction.name!)!]
                    }
                }
                
            }
            totalBuyValLabel.text = "\(totalBuyValue)"
            totalMarketValLabel.text = "\(totalMarketValue)"
            if totalMarketValue-totalBuyValue > 0 {
                unrealizedGainLossLabel.text = "\(totalMarketValue-totalBuyValue)"
                unrealizedGainLossLabel.textColor = UIColor(displayP3Red: 0, green: 0.9, blue: 0, alpha: 1)
            }else if totalMarketValue-totalBuyValue < 0{
                unrealizedGainLossLabel.text = "\(totalMarketValue-totalBuyValue)"
                unrealizedGainLossLabel.textColor = UIColor(displayP3Red: 1, green: 0, blue: 0, alpha: 1)
            }else{
                unrealizedGainLossLabel.text = "\(totalMarketValue-totalBuyValue)"
            }
            netAssetLabel.text = "\(Float(balance) + totalMarketValue)"
            
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
extension PortofolioViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tableSize:Int = 0
        //salah
        for transaction in 0...stockTransaction.count {
            if stockTransaction[transaction].amount > 0{
                tableSize+=1
            }
        }
        return tableSize
        //            return stockTransaction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PortofolioTableViewCell") as! PortofolioTableViewCell
        
//        for i in 0...stockTransaction.count {
//            for j in 0...stockTransaction.count {
//                if stockTransaction[j].name < stockTransaction[j+1].name
//            }
//        }
        
        cell.stockNameLabel.text = ""
        cell.stockAmountLabel.text = stockTransaction[indexPath.row].type
        
        return cell
    }
}
