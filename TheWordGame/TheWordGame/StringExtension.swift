//
//  StringExtension.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 6/20/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import Foundation

extension String {
	
	private subscript (i: Int) -> Character {
		return self[index(startIndex, offsetBy: i)]
	}
	
	subscript (i: Int) -> String {
		return String(self[i] as Character)
	}
	
	subscript (r: Range<Int>) -> String {
		let start = index(startIndex, offsetBy: r.lowerBound)
		let end = index(startIndex, offsetBy: r.upperBound - r.lowerBound)
		return self[Range(start ..< end)]
	}
	
	func getLastChar() -> String {
		return self[characters.count - 1] as String
	}
}
