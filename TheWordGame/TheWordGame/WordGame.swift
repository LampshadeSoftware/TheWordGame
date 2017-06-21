//
//  WordGame.swift
//  The Word Game
//
//  Created by Daniel McCrystal on 11/28/16.
//  Copyright © 2016 Lampshade Software. All rights reserved.
//

import Foundation

class WordGame: NSObject, NSCoding {
    private var players: [PlayerData]
    var turn: Int
    var lastWord, currentWord: String
    var usedWords: [String]
    var errorLog: String
    
    static var dictionary = WordGame.generateDictionary()
    static var common = WordGame.generateCommons()
    
    override init() {
        players = [PlayerData]()
        turn = 0
        lastWord = ""
        currentWord = WordGame.generateStartWord()
        usedWords = [String]()
        errorLog = ""
    }
    init(lastWord: String, currentWord: String, usedWords: [String], players: [PlayerData], turn: Int) {
        self.players = players
        self.turn = turn
        self.lastWord = lastWord
        self.currentWord = currentWord
        self.usedWords = usedWords
        errorLog = ""
    }
    
    // Decode
    required convenience init?(coder aDecoder: NSCoder) {
        guard let _lastWord = aDecoder.decodeObject(forKey: "lastWord") as? String
        else {
            print("Unable to decode [lastWord]")
            return nil
        }
        guard let _currentWord = aDecoder.decodeObject(forKey: "currentWord") as? String
            else {
                print("Unable to decode [currentWord]")
                return nil
        }
        guard let _usedWords = aDecoder.decodeObject(forKey: "usedWords") as? [String]
            else {
                print("Unable to decode [usedWords]")
                return nil
        }
        guard let _playerData = aDecoder.decodeObject(forKey: "playerData") as? [PlayerData]
            else {
                print("Unable to decode [playerData]")
                return nil
        }
        let _turn = aDecoder.decodeInteger(forKey: "turn")
        self.init(lastWord: _lastWord, currentWord: _currentWord, usedWords: _usedWords, players: _playerData, turn: _turn)
    }
    
    // Encode
    func encode(with aCoder: NSCoder) {
        aCoder.encode(lastWord, forKey: "lastWord")
        aCoder.encode(currentWord, forKey: "currentWord")
        aCoder.encode(usedWords, forKey: "usedWords")
        aCoder.encode(players, forKey: "playerData")
        aCoder.encode(turn, forKey: "turn")
    }
    
    func addPlayer(_ name: String) {
        players.append(PlayerData(name: name))
    }
    func playerForfeited() {
        players[turn].active = false
		cyclePlayers()
    }
    func getCurrentPlayer() -> PlayerData {
        return players[turn]
    }
	func cyclePlayers() {
		turn = (turn + 1) % players.count
		while !players[turn].active {
			turn = (turn + 1) % players.count
		}
	}
		
    static func generateStartWord() -> String {
        var potential = WordGame.common[Int(arc4random_uniform(UInt32(WordGame.common.count)))]
        
        while numPlays(on: potential, lessThan: 5) {
            potential = WordGame.common[Int(arc4random_uniform(UInt32(WordGame.common.count)))]
        }
        
        return potential
    }
    static func numPlays(on word: String, lessThan goal: Int) -> Bool {
        var count = 0
        for test in WordGame.dictionary {
            if isValidPlayLite(test, on: word) {
                // print(test + " is a valid play on " + word)
                count += 1
                if count == goal {
                    return false
                }
            }
        }
        return true
    }
    static func numPlays(on word: String) -> Int {
        var count = 0
        for test in WordGame.dictionary {
            if isValidPlayLite(test, on: word) {
                // print(test + " is a valid play on " + word)
                count += 1
            }
        }
        return count
    }
    func numGamePlays(on word: String) -> Int {
        var count = 0
        for test in WordGame.dictionary {
            if isValidPlay(test, on: word, last: lastWord) == 6 {
                count+=1
            }
        }
        return count
    }
    
    static func isValidPlayLite(_ play: String, on word: String) -> Bool {
        if play == word {
            return false
        }
        return WordGame.isValidAdd(play, on: word) >= 0
            || WordGame.isValidSub(play, on: word) >= 0
            || WordGame.isValidReplace(play, on: word) >= 0
            || WordGame.isValidRearrange(play, on: word)
    }
    
    /*
    Returns an error code based on the reason for invalidity
    -1: Word is invalid play on current word
    -2: Word is technically valid, but meaning did not change
    -3: Word is valid play, but not English
    -4: Word is valid play and English, but already used
    -5: Word is valid play and English and new, but it is a double play
    -6: Word is 'fjord', player can fuck off
    0+: Word is valid, return play type and index
		  00-99: Addition
		100-199: Subtraction
		200-299: Replacement
			300: Rearrange
    */
    func isValidPlay(_ play: String, on word: String, last: String) -> Int {
		var potential = -1
		
		let validAdd = WordGame.isValidAdd(play, on: word)
		let validSub = WordGame.isValidSub(play, on: word)
		let validRep = WordGame.isValidReplace(play, on: word)
		if validAdd >= 0 {
			if WordGame.addedS(play, on: word) || WordGame.addedD(play, on: word) {
				return -2
			} else {
				potential = validAdd
			}
		} else if validSub >= 0 {
			potential = 100 + validSub
		} else if validRep >= 0 {
			potential = 200 + validRep
		} else if WordGame.isValidRearrange(play, on: word) {
			potential = 300
		} else {
			return -1
		}
		
		if !WordGame.isEnglishWord(play) {
			return -3
		}
		if play == word || alreadyUsed(play) {
			return -4
		}
		if doublePlay(play, last: last) {
			return -5
		}
		if play == "fjord" || play == "fiord" {
			return -6
		}
		
		return potential
		
    }
    static func isValidAdd(_ play: String, on word: String) -> Int {
        if play.characters.count != word.characters.count + 1 {
            return -1
        }
        var i = 0
        while i < word.characters.count {
            if play[i] != word[i] {
                break
            }
            i += 1
        }
		let changeAt = i
        while i+1 < play.characters.count {
            if play[i+1] != word[i] {
                return -1
            }
            i += 1
        }
        return changeAt
    }
    
    static func addedS(_ play: String, on word: String) -> Bool {
        return play.getLastChar() == "s" && word.getLastChar() != "s"
    }
    static func addedD(_ play: String, on word: String) -> Bool {
        return play.getLastChar() == "d" && word.getLastChar() == "e"
    }
   
    static func isValidSub(_ play: String, on word: String) -> Int {
        return isValidAdd(word, on: play)
    }
    static func isValidReplace(_ play: String, on word: String) -> Int {
        if play.characters.count != word.characters.count {
            return -1
        }
        var i = 0
        while i < play.characters.count {
            if play[i] != word[i] {
                i += 1
                break
            }
            i += 1
        }
		let changeAt = i - 1
        while i < word.characters.count {
            if play[i] != word[i] {
                return -1
            }
            i += 1
        }
        return changeAt
    }
    static func isValidRearrange(_ play: String, on word: String) -> Bool {
        if play.characters.count != word.characters.count || word == "$$$" {
            return false
        }

        var letterCount = [Int](repeating: 0, count: 26)
        
        let playVals = play.unicodeScalars.filter{$0.isASCII}.map{$0.value}
        let wordVals = word.unicodeScalars.filter{$0.isASCII}.map{$0.value}
        for val in playVals {
            letterCount[Int(val) - 97] += 1
        }
        for val in wordVals {
            letterCount[Int(val) - 97] -= 1
        }
        for count in letterCount {
            if count != 0 {
                return false
            }
        }
        return true
    }
    static func isEnglishWord(_ play: String) -> Bool {
        let dict = WordGame.dictionary
        var hi = dict.count - 1
        var lo = 0
        var mid: Int
        while true {
            mid = (hi + lo) / 2
            let guess = dict[mid]
            if guess == play {
                return true
            } else if lo > hi {
                return false
            } else {
                if guess < play {
                    lo = mid + 1
                } else { // guess > play
                    hi = mid - 1
                }
            }
            mid = (hi + lo) / 2
        }
    }
    func alreadyUsed(_ play: String) -> Bool {
        return usedWords.contains(play)
    }
    func doublePlay(_ play: String, last word: String) -> Bool {
        return isValidPlay(play, on: word, last: "$$$") >= 0
    }
    
    func submitWord(_ word: String) -> Int {
        let code = isValidPlay(word, on: currentWord, last: lastWord)
        switch code {
        case -1:
            errorLog = "Invalid play! Try again"
            break
        case -2:
            errorLog = "That's crap and you know it"
            break
        case -3:
            errorLog = "Not an English word! Try again"
            break
        case -4:
            errorLog = "\(word) has already been played! Try again"
            break
        case -5:
            errorLog = "Double play! Try again"
            break
        case -6:
            errorLog = "You think you're pretty smart, huh?"
            break
        default:
            usedWords.append(currentWord)
            lastWord = currentWord
            players[turn].addPlayedWord(word: currentWord)
			cyclePlayers()
            currentWord = word
            errorLog = ""
		}
		return code
    }
    
    static func generateDictionary() -> [String] {
        guard let url = Bundle.main.path(forResource: "dictionary", ofType: "txt") else {
            print("Dictionary not found")
            return ["failed"]
        }
        do {
            let stringFromPath = try String(contentsOfFile: url, encoding: String.Encoding.utf8)
            return stringFromPath.components(separatedBy: "\r\n")
        } catch let error as NSError {
            print(error)
            return ["failed"]
        }
    }
    static func generateCommons() -> [String] {
        guard let url = Bundle.main.path(forResource: "common", ofType: "txt") else {
            print("Commons not found")
            return ["failed"]
        }
        do {
            let stringFromPath = try String(contentsOfFile: url, encoding: String.Encoding.utf8)
            return stringFromPath.components(separatedBy: "\n")
        } catch let error as NSError {
            print(error)
            return ["failed"]
        }
    }
}


