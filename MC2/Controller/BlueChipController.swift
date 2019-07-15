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
    var jsonCounter = 98
    var stockPercentage: Float = 0
    var sortedStock: [TimeSeries.StockDate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titlePage
        
    
        
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
}
