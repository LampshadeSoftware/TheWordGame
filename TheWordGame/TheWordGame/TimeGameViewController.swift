//
//  TimeGameViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 5/25/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class TimeGameViewController: GameViewController {
	var auxLabel: UILabel!
	
    var startButton: UIButton!
    func startButtonPressed() {
        // Remove start button
        startButton.isEnabled = false
        startButton.isHidden = true
        
        // Display countdown
        auxLabel.textColor = WordGameUI.blue
        auxLabel.text = "3"
        timeValue = timeLimit
        updateTimer()
        
        // Start timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
	
    // Time Trial Specific Functions
    func countDown() {
        if auxLabel.text == "3" {
            auxLabel.text = "2"
        } else if auxLabel.text == "2" {
            auxLabel.text = "1"
        } else if auxLabel.text == "1" {
			auxLabel.text = ""
            startGame()
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    func updateTimer() {
        var displayVal = "\(timeValue!)"
        if timeValue < 10 {
            displayVal = "0\(timeValue!)"
        }
        topLabel.text = "0:\(displayVal)"
        if timeValue == 0 {
            timer.invalidate()
            finishGame()
        }
        timeValue = timeValue - 1
    }
    
    func startGame() {
        gameInProgress = true
        
        setTiles(to: activeGame.currentWord)
        hintButton.isEnabled = true
        hintButton.isHidden = false
        
        submitButton.isEnabled = true
        submitButton.isHidden = false
    }
    
    func finishGame() {
        gameInProgress = false
        
        auxLabel.textColor = WordGameUI.blue
        auxLabel.text = "SCORE: \(self.activeGame.usedWords.count)"
        
        // Clear game information
        inputTextField.text = ""
        logLabel.text = ""
		clearTiles()
        
        if activeGame.usedWords.count > best {
            best = activeGame.usedWords.count
            Save.setToken(tokenKey: "timeBest", newVal: best as NSObject)
        }
        topLabel.text = "Best: \(best)"
        
        activeGame.usedWords = [""]
                
        hintButton.isEnabled = false
        hintButton.isHidden = true
        
        submitButton.isEnabled = false
        submitButton.isHidden = true
        
    }
    
    
    
    // Properties
    var timer: Timer!
    let timeLimit = 59
    var timeValue: Int!
    var gameInProgress = false
    var best = 0
    
    // Override Functions
    
    override func viewDidLoad() {
        gameModeIdentifier = "time"
        saveGameEnabled = false
        if let bestToken = Save.getToken(tokenKey: "timeBest") {
            best = bestToken as! Int
        }
        super.viewDidLoad()
		auxLabel = UILabel(frame: CGRect(x: 0, y: view.bounds.height * 0.4, width: view.bounds.width, height: 50))
		auxLabel.textAlignment = .center
		auxLabel.font = WordGameUI.font(size: 56)
		auxLabel.textColor = WordGameUI.blue
		view.addSubview(auxLabel)
		
        topLabel.text = "Best: \(best)"
        startButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * 0.15))
        startButton.center = auxLabel.center
        startButton.setTitle("TAP TO START", for: .normal)
        startButton.setTitleColor(WordGameUI.green, for: .normal)
        startButton.titleLabel?.font = WordGameUI.font(size: 56)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchDown)
        startButton.isHidden = true
        startButton.isEnabled = false
        view.addSubview(startButton)
        
        hintButton.isHidden = true
        hintButton.isEnabled = false
        submitButton.isHidden = true
        submitButton.isEnabled = false
    
    }
    
    override func updateTopLabel() {
        // intentionally left blank
    }
    override func resetTopLabel() {
        topLabel.text = ""
    }
    
    override func returnKeyPressed() {
        if gameInProgress {
            super.returnKeyPressed()
        }
    }
    
    override func reset() {
        if timer != nil {
            timer.invalidate()
        }
        super.reset()
    }
    override func doAfterReset() {
        self.clearTiles()
		self.inputTextField.text = ""
        self.auxLabel.text = ""
        self.startButton.isEnabled = true
        self.startButton.isHidden = false
        activeGame.addPlayer("user")
		hintButton.isEnabled = false
		hintButton.isHidden = true
		
		submitButton.isEnabled = false
		submitButton.isHidden = true
		
    }
	
}
