//
//  WGColors.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 6/13/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class WordGameUI {
    static let yellow = UIColor(red: 255 / 256, green: 208 / 256, blue: 60 / 256, alpha: 1.0)
    static let red = UIColor(red: 255 / 256, green: 137 / 256, blue: 119 / 256, alpha: 1.0)
    static let blue = UIColor(red: 181 / 256, green: 213 / 256, blue: 255 / 256, alpha: 1.0)
    static let green = UIColor(red: 134 / 256, green: 255 / 256, blue: 134 / 256, alpha: 1.0)
    static let dark = UIColor(red: 34 / 256, green: 40 / 256, blue: 47 / 256, alpha: 1.0)
    
    static func font(size: Int) -> UIFont {
        return UIFont(name: "GillSans-Light", size: CGFloat(size))!
    }
    
}
