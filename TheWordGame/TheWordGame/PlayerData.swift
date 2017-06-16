//
//  PlayerData.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 6/14/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import Foundation

class PlayerData: NSObject, NSCoding {
    let name: String
    var wordsPlayed: [String]
    var active: Bool
    
    init(name: String) {
        self.name = name
        wordsPlayed = [String]()
        active = true
    }
    
    init(name: String, wordsPlayed: [String], active: Bool) {
        self.name = name
        self.wordsPlayed = wordsPlayed
        self.active = active
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let _name = aDecoder.decodeObject(forKey: "name") as? String
            else {
                print("Unable to decode name")
                return nil
        }
        guard let _wordsPlayed = aDecoder.decodeObject(forKey: "wordsPlayed") as? [String]
            else {
                print("Unable to decode wordsPlayed")
                return nil
        }
        let _active = aDecoder.decodeBool(forKey: "active")
        
        self.init(name: _name, wordsPlayed: _wordsPlayed, active: _active)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(wordsPlayed, forKey: "wordsPlayed")
        aCoder.encode(active, forKey: "active")
    }
    
    func addPlayedWord(word: String) {
        wordsPlayed.append(word)
    }

}
