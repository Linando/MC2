//
//  PortofolioTableViewCell.swift
//  MC2
//
//  Created by Evan Christian on 18/07/19.
//  Copyright © 2019 Linando Saputra. All rights reserved.
//

import UIKit

class PortofolioTableViewCell: UITableViewCell {

    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockAmountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
