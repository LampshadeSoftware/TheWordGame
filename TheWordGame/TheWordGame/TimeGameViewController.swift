//
//  TimeGameViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 5/25/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class TimeGameViewController: GameViewController {
    
    var startButton: UIButton!
    
    // Buttons
    @IBAction func startButtonPressed(_ sender: Any) {
        // Remove start button
        startButton.isEnabled = false
        startButton.isHidden = true
        
        // Display countdown
        currentWordLabel.textColor = WordGameUI.blue
        currentWordLabel.text = "3"
        timeValue = timeLimit
        updateTimer()
        
        // Start timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }

    // Aux Functions
    func countDown() {
        if currentWordLabel.text == "3" {
            currentWordLabel.text = "2"
        } else if currentWordLabel.text == "2" {
            currentWordLabel.text = "1"
        } else if currentWordLabel.text == "1" {
            currentWordLabel.text = ""
            currentWordLabel.textColor = WordGameUI.yellow
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
            currentWordLabel.textColor = WordGameUI.blue
            currentWordLabel.text = "SCORE: \(self.activeGame.usedWords.count)"
            timer.invalidate()
            finishGame()
        }
        timeValue = timeValue - 1
    }
    
    override func setTopLabel() {
        // intentionally left blank
    }
    
    func startGame() {
        gameInProgress = true
        
        currentWordLabel.text = activeGame.currentWord
        hintButton.isEnabled = true
        hintButton.isHidden = false
        
        submitButton.isEnabled = true
        submitButton.isHidden = false
    }
    
    func finishGame() {
        gameInProgress = false
        
        // Clear game information
        inputTextField.text = ""
        logLabel.text = ""
        
        if activeGame.usedWords.count > best {
            best = activeGame.usedWords.count
            Save.setToken(tokenKey: "timeBest", newVal: best as NSObject)
        }
        topLabel.text = "Best: \(best)"
        
        activeGame.usedWords = [""]
        pastWordsTableView.reloadData()
        
        hintButton.isEnabled = false
        hintButton.isHidden = true
        
        submitButton.isEnabled = false
        submitButton.isHidden = true
        
        
        
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
        self.currentWordLabel.text = ""
        self.currentWordLabel.textColor = WordGameUI.yellow
        self.startButton.isEnabled = true
        self.startButton.isHidden = false
        
    }
    
    // Properties
    var timer: Timer!
    let timeLimit = 10
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
        topLabel.text = "Best: \(best)"
        startButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * 0.15))
        startButton.center = currentWordLabel.center
        startButton.setTitle("TAP TO START", for: .normal)
        startButton.setTitleColor(WordGameUI.green, for: .normal)
        startButton.titleLabel?.font = WordGameUI.font(size: 60)
        startButton.addTarget(self, action: #selector(startButtonPressed(_:)), for: .touchDown)
        startButton.isHidden = true
        startButton.isEnabled = false
        view.addSubview(startButton)
        
        hintButton.isHidden = true
        hintButton.isEnabled = false
        submitButton.isHidden = true
        submitButton.isEnabled = false
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
