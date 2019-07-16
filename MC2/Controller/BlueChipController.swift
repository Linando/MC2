//
//  BlueChipViewController.swift
//  MC2
//
//  Created by Linando Saputra on 15/07/19.
//  Copyright © 2019 Linando Saputra. All rights reserved.
//

import UIKit

class BlueChipController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var titlePage = ""
    var money:Int = 0
    var jsonCounter = 98
    var stockPercentage: Float = 0
    var sortedStock: [TimeSeries.StockDate] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        if(UserDefaults.standard.object(forKey: "lastLoginDate") != nil)
        {
            let dateStart = calendar.startOfDay(for: UserDefaults.standard.object(forKey: "lastLoginDate") as! Date)
            let dateEnd = calendar.startOfDay(for: date)
            
            let differenceInDay = calendar.dateComponents([.day], from: dateStart, to: dateEnd).day
            if(date != (UserDefaults.standard.object(forKey: "lastLoginDate") as! Date))
            {
                jsonCounter += differenceInDay!
            }
        }
        UserDefaults.standard.set(date, forKey: "lastLoginDate")
        self.title = titlePage
        if self.title == "Blue Chip"{
            descriptionLabel.text = "Blue chip : denoting companies or their shares considered to be a reliable investment, though less secure than gilt-edged stock."
        }else if self.title == "Mid-Cap"{
            descriptionLabel.text = "Mid-cap is the term given to companies with a market capitalization (value) between $150 and $800 million."
        }else if self.title == "Penny Stock"{
            descriptionLabel.text = "Penny stock : a common stock valued at less than one dollar, and therefore highly speculative."
        }
    
        
        // Do any additional setup after loading the view.
    }
    
}

extension BlueChipController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlueChipCell") as! BlueChipCell
        
        if titlePage == "Blue Chip" {
            do{
                let decodedStock = try JSONDecoder().decode(Stock.self, from: blueChipJSON[indexPath.row])
                sortedStock = decodedStock.timeSeries.stockDates.sorted(by: { $0.date > $1.date })
                cell.stockSymbol.text = blueChipSymbol[indexPath.row]
                
            } catch let jsonErr{
                print("Error serializing json: ", jsonErr)
            }
        }
        else if titlePage == "Mid-Cap"
        {
            do{
                let decodedStock = try JSONDecoder().decode(Stock.self, from: midCapJSON[indexPath.row])
                sortedStock = decodedStock.timeSeries.stockDates.sorted(by: { $0.date > $1.date })
                cell.stockSymbol.text = midCapSymbol[indexPath.row]
            } catch let jsonErr{
                print("Error serializing json: ", jsonErr)
            }

        }
        else if titlePage == "Penny Stock"
        {
            do{
                let decodedStock = try JSONDecoder().decode(Stock.self, from: pennyStockJSON[indexPath.row])
                sortedStock = decodedStock.timeSeries.stockDates.sorted(by: { $0.date > $1.date })
                cell.stockSymbol.text = pennyStockSymbol[indexPath.row]
                
            } catch let jsonErr{
                print("Error serializing json: ", jsonErr)
            }
            
        }
        cell.stockPrice.text = sortedStock[jsonCounter].open
        stockPercentage = (Float(sortedStock[jsonCounter].open)! - Float(sortedStock[jsonCounter+1].open)!) * 100 / Float(sortedStock[jsonCounter+1].open)!
        if(stockPercentage > 0)
        {
            cell.stockChange.text = String(format: "+%.2f%%", stockPercentage)
            cell.stockChange.backgroundColor = .green
        }
        else
        {
            cell.stockChange.text = String(format: "%.2f%%", stockPercentage)
            cell.stockChange.backgroundColor = .red
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = storyboard?.instantiateViewController(withIdentifier: "TableDetailViewController") as? TableDetailViewController
        if self.title == "Blue Chip"{
            print("masuk blue chip")
            vc?.stockName = blueChipSymbol[indexPath.row]
            vc!.money = money
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if self.title == "Mid-Cap"{
            print("masuk midcap")
            vc?.stockName = midCapSymbol[indexPath.row]
            vc!.money = money
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if self.title == "Penny Stock"{
            print("masuk penny stock")
            vc?.stockName = pennyStockSymbol[indexPath.row]
            vc!.money = money
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
}
