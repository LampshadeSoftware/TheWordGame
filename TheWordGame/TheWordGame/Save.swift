//
//  Save.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 5/30/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import Foundation

class Save {

    // Static
    private static var data = [String: NSObject!]()
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("data")
    
    static func writeSaveData() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Save.data, toFile: Save.ArchiveURL.path)
        if isSuccessfulSave {
            print("Successfully saved data")
        } else {
            print("Failed to save data...")
        }
    }
    
    static func loadSaveData() {
        let onDisk = NSKeyedUnarchiver.unarchiveObject(withFile: Save.ArchiveURL.path) as! [String: NSObject]?
        if onDisk != nil {
            data = onDisk!
            print("Successfully retrieved data")
        } else {
            print("Failed to retrieve data...")
        }
    }
    
    static func setToken(tokenKey: String, newVal: NSObject!) {
        if tokenKey == "default" {
            print("Error: GameModeIdentifier was not set. Save Failed.")
            return
        }
        data[tokenKey] = newVal
        print("Succssfully staged token [\(tokenKey)] for save")

    }
	static func unsetToken(tokenKey: String) {
		data.removeValue(forKey: tokenKey)
	}
    
    static func getToken(tokenKey: String) -> NSObject? {
        let val = data[tokenKey]
        if val == nil {
            return nil
        } else {
            return val!
        }
    }
    
    static func resetData() {
        data = [String: NSObject]()
        writeSaveData()
        print("Data has been reset")
    }
}


