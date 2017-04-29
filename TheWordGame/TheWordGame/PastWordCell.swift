//
//  PastWordCell.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 4/26/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class PastWordCell: UITableViewCell {
    
    @IBOutlet weak var wordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("does this bullshit even do anything")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
