//
//  Save.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 5/30/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import Foundation

class Save: NSObject, NSCoding {
    private var tokens: [String: NSObject]
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(tokens, forKey: "tokens")
    }
    override init() {
        tokens = [String: NSObject]()
    }
    init(tokens: [String: NSObject]) {
        self.tokens = tokens
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let tokens = aDecoder.decodeObject(forKey: "tokens") as? [String: NSObject]
        else {
            print("Unable to decode Save object")
            return nil
        }
        self.init(tokens: tokens)
    }
    
    
    // Static
    private static var data = Save()
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("data")
    
    static func writeSaveData() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Save.data, toFile: Save.ArchiveURL.path)
        if isSuccessfulSave {
            print("Data successfully saved.")
        } else {
            print("Failed to save data...")
        }
    }
    
    static func loadSaveData() {
        let onDisk = NSKeyedUnarchiver.unarchiveObject(withFile: Save.ArchiveURL.path) as! Save?
        if onDisk != nil {
            data = onDisk!
            print("Successfully retrieved data")
        } else {
            print("Failed to retrieve data...")
        }
    }
    
    static func setToken(tokenKey: String, newVal: NSObject) {
        data.tokens[tokenKey] = newVal
    }
    
    static func getToken(tokenKey: String) -> NSObject? {
        let val = data.tokens[tokenKey]
        if val == nil {
            return nil
        } else {
            return val!
        }
    }
    
    static func resetData() {
        data = Save()
        writeSaveData()
    }
}


