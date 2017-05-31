//
//  TimeGameViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 5/25/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class TimeGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // Outlets
    // ---------
    // Labels
    @IBOutlet weak var currentWordLabel: UILabel!
    @IBOutlet weak var errorLogLabel: UILabel!
    @IBOutlet weak var hintLogLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    
    // Misc
    @IBOutlet weak var pastWordsTableView: PastWordsTableView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var hintActivityIndicator: UIActivityIndicatorView!
    
    // ===============
    
    // Actions
    // --------
    // Buttons
    @IBAction func startButtonPressed(_ sender: Any) {
        // Remove start button
        startButton.isEnabled = false
        startButton.isHidden = true
        
        // Display countdown
        infoLabel.text = "3"
        timeValue = timeLimit
        updateTimer()
        
        // Start timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    @IBAction func hintButtonPressed(_ sender: Any) {
        // Clear error and hint
        errorLogLabel.text = ""
        hintLogLabel.text = ""
        
        // Show activity indicator
        hintActivityIndicator.isHidden = false
        hintActivityIndicator.startAnimating()
        
        // Start new thread to find number of plays
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let tmp = "There are " + String(self.activeGame.numGamePlays(on: self.activeGame.currentWord)) + " potential plays on " + self.activeGame.currentWord
            self.hintLogLabel.text = tmp
            self.hintActivityIndicator.stopAnimating()
            self.hintActivityIndicator.isHidden = true
        }
        
    }
    @IBAction func resetButtonPressed(_ sender: Any) {
        reset()
    }
    @IBAction func submitButtonPressed(_ sender: Any) {
        submit()
    }
    @IBAction func returnKeyPressed(_ sender: Any) {
        if gameInProgress {
            submit()
        }
    }
    
    // Aux Functions
    func countDown() {
        if infoLabel.text == "3" {
            infoLabel.text = "2"
        } else if infoLabel.text == "2" {
            infoLabel.text = "1"
        } else if infoLabel.text == "1" {
            infoLabel.text = ""
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
        timeLabel.text = "0:\(displayVal)"
        if timeValue == 0 {
            infoLabel.text = "SCORE: \(activeGame.usedWords.count)"
            timer.invalidate()
            finishGame()
        }
        timeValue = timeValue - 1
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
        
        inputTextField.text = ""
        errorLogLabel.text = ""
        hintLogLabel.text = ""
        timeLabel.text = ""
        currentWordLabel.text = ""
        activeGame.usedWords = [""]
        pastWordsTableView.reloadData()
        
        hintButton.isEnabled = false
        hintButton.isHidden = true
        
        submitButton.isEnabled = false
        submitButton.isHidden = true
        
    }
    
    
    func submit() {
        activeGame.submitWord(inputTextField.text!)
        inputTextField.text = ""
        hintLogLabel.text = ""
        errorLogLabel.text = activeGame.errorLog
        currentWordLabel.text = activeGame.currentWord

        DispatchQueue.main.async {
            self.pastWordsTableView.reloadData()
        }
        if activeGame.usedWords.count > 0 {
            // scrollToBottom()
        }
        
    }
    func preScroll() {
        DispatchQueue.global(qos: .background).async {
            let indexPath = IndexPath(row: 1, section: 0)
            self.pastWordsTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    func scrollToBottom() {
        DispatchQueue.global(qos: .background).async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.pastWordsTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    
    func reset() {
        if timer != nil {
            timer.invalidate()
        }
        infoLabel.text = ""
        hintButton.isHidden = true
        hintButton.isEnabled = false
        submitButton.isHidden = true
        submitButton.isEnabled = false
        
        timeLabel.text = ""
        
        inputTextField.text = ""
        errorLogLabel.text = ""
        hintLogLabel.text = ""
        timeLabel.text = ""
        currentWordLabel.text = ""
        if activeGame != nil {
            activeGame.usedWords = [""]
        }
        pastWordsTableView.reloadData()
        hintActivityIndicator.isHidden = false
        hintActivityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.activeGame = WordGame()
            self.hintActivityIndicator.stopAnimating()
            self.hintActivityIndicator.isHidden = true
            self.currentWordLabel.text = ""
            self.startButton.isEnabled = true
            self.startButton.isHidden = false
        }

    }
    
    // Properties
    var activeGame: WordGame!
    var timer: Timer!
    let timeLimit = 59
    var timeValue: Int!
    var gameInProgress = false
    
    // Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        pastWordsTableView.delegate = self
        pastWordsTableView.dataSource = self
        pastWordsTableView.transform = CGAffineTransform (scaleX: 1,y: -1);
        
        inputTextField.becomeFirstResponder()
        
        infoLabel.text = ""
        hintButton.isHidden = true
        hintButton.isEnabled = false
        submitButton.isHidden = true
        submitButton.isEnabled = false
        startButton.isHidden = true
        startButton.isEnabled = false
        
        timeLabel.text = ""
        
        inputTextField.text = ""
        errorLogLabel.text = ""
        hintLogLabel.text = ""
        timeLabel.text = ""
        currentWordLabel.text = ""
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Table View Stuff
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if activeGame != nil {
            return activeGame.usedWords.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PastWordCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PastWordCell  else {
            fatalError("The dequeued cell is not an instance of PastWordCell.")
        }
        let word: String
        
        word = activeGame.usedWords[activeGame.usedWords.count - 1 - indexPath.row]
        
        cell.wordLabel!.text = word
        cell.transform = CGAffineTransform (scaleX: 1,y: -1);
        return cell
    }

}
