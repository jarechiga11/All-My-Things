//
//  CustomItemViewCell.swift
//  AMT
//
//  Created by Jesus Arechiga on 4/16/15.
//  Copyright (c) 2015 RAD. All rights reserved.
//

import UIKit

class CustomItemViewCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemThumbnailImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
