//
//  ItemDetailTableViewCell.swift
//  AMT
//
//  Created by Jesus Arechiga on 4/23/15.
//  Copyright (c) 2015 RAD. All rights reserved.
//

import UIKit

class ItemDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fieldLabel:UILabel!
    @IBOutlet weak var valueLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
