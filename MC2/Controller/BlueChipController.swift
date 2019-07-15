//
//  BlueChipViewController.swift
//  MC2
//
//  Created by Linando Saputra on 15/07/19.
//  Copyright © 2019 Linando Saputra. All rights reserved.
//

import UIKit

class BlueChipController: UIViewController {
    
    var temp: [TimeSeries.StockDate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        do{
            let decodedStock = try JSONDecoder().decode(Stock.self, from: blueChipJSON[0])
            temp = decodedStock.timeSeries.stockDates.sorted(by: { $0.date > $1.date })
            
        } catch let jsonErr{
            print("Error serializing json: ", jsonErr)
        }
        
        cell.stockSymbol.text = blueChipSymbol[indexPath.row]
        cell.stockPrice.text = temp[indexPath.row].open
        cell.stockChange.text = "50%"
        
        return cell
    }
}
