//
//  PastWordCell.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 4/26/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class PastWordCell: UITableViewCell {
    
    var wordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUpCell() {
        if wordLabel == nil {
            let width = contentView.bounds.width
            let height = contentView.bounds.height
            wordLabel = UILabel(frame: CGRect(x: width / 2 , y: height / 2, width: width, height: height))
            wordLabel.center = contentView.center
            wordLabel.textAlignment = .center
            wordLabel.font = WordGameUI.font(size: 42)
            wordLabel.textColor = WordGameUI.blue
            contentView.backgroundColor = WordGameUI.dark
            contentView.addSubview(wordLabel)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
