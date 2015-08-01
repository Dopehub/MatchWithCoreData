//
//  MyTableViewCell.swift
//  MatchWithCoreData
//
//  Created by Immadope on 6/27/15.
//  Copyright © 2015 Immadope. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var dateLabelText: UILabel!
    @IBOutlet weak var hourLabelText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
