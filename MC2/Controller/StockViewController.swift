//
//  StockViewController.swift
//  MC2
//
//  Created by Evan Christian on 12/07/19.
//  Copyright © 2019 Linando Saputra. All rights reserved.
//

import UIKit


class StockViewController: UIViewController {

    @IBOutlet weak var blueChipImageView: UIImageView!
    @IBOutlet weak var midCapImageView: UIImageView!
    @IBOutlet weak var pennyStockImageView: UIImageView!
    @IBOutlet weak var balanceTotalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let balance = UserDefaults.standard.integer(forKey: "balance")
        if balance > 0{
            
            balanceTotalLabel.text = "Rp. \(balance.formattedWithSeparator)"
        }else{
            balanceTotalLabel.text = "0"
        }
        
        let tapBlueChip = UITapGestureRecognizer(target: self, action: #selector(tappedBlueChip(_:)))
        blueChipImageView.addGestureRecognizer(tapBlueChip)
        blueChipImageView.isUserInteractionEnabled = true
        
        let tapMidCap = UITapGestureRecognizer(target: self, action: #selector(tappedMidCap(_:)))
        midCapImageView.addGestureRecognizer(tapMidCap)
        midCapImageView.isUserInteractionEnabled = true
        
        let tapPennyStock = UITapGestureRecognizer(target: self, action: #selector(tappedPennyStock(_:)))
        pennyStockImageView.addGestureRecognizer(tapPennyStock)
        pennyStockImageView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @objc func tappedBlueChip(_ sender: Any)
    {
        self.performSegue(withIdentifier: "blueChipSegue", sender: "")
    }
    
    @objc func tappedMidCap(_ sender: Any)
    {
        self.performSegue(withIdentifier: "blueChipSegue", sender: "")
    }
    
    @objc func tappedPennyStock(_ sender: Any)
    {
        self.performSegue(withIdentifier: "blueChipSegue", sender: "")
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
