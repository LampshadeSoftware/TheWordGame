//
//  Letter.swift
//  TheWordGameUITests
//
//  Created by Cowboy Lynk on 6/18/17.
//  Copyright © 2017 Cowboy Lynk. All rights reserved.
//

import Foundation
import UIKit


class Tile: UIView{
    var letter = ""
    var changedLetterIndicator = UIView()
    let label = UILabel()
    
    func setTileStyle(){
        
        // Label styling
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 40)
        label.text = self.letter
        
        // Tile styling
        self.addSubview(label)
        self.layer.shadowOffset = CGSize(width: 0, height: self.frame.height/12)
    }

    
    func addIndicator(){
        changedLetterIndicator.alpha = 1
    }
    
    func removeIndicator(){
        changedLetterIndicator.alpha = 0
    }
    
    init(letter: String, defaultDimension: Double){
        self.letter = letter
        super.init(frame: CGRect())
        
        self.frame.size = CGSize(width: defaultDimension, height: defaultDimension)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.alpha = 0
        
        label.frame.size = CGSize(width: defaultDimension, height: defaultDimension)
        label.textColor = .gray
        label.textAlignment = .center
        
        changedLetterIndicator.frame = CGRect(origin: CGPoint(x: 0, y: self.bounds.height), size: CGSize(width: 50, height: 10))
        changedLetterIndicator.alpha = 0
        changedLetterIndicator.center.x = self.bounds.width/2
        changedLetterIndicator.backgroundColor = UIColor(red:0.94, green:0.56, blue:0.23, alpha:1.0)
        self.addSubview(changedLetterIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
