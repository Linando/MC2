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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        
        let balance = UserDefaults.standard.integer(forKey: "balance")
        if balance > 0{
            
            balanceLabel.text = "\(balance)"
        }else{
            balanceLabel.text = "0"
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
