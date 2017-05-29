//
//  TimeGameViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 5/25/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class TimeGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var pastWordsTableView: PastWordsTableView!
    @IBOutlet weak var currentWordLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var errorLogLabel: UILabel!
    @IBOutlet weak var hintLogLabel: UILabel!
    @IBOutlet weak var hintActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    // Actions
    @IBAction func startButtonPressed(_ sender: Any) {
        startButton.isEnabled = false
        startButton.isHidden = true
        timeLabel.text = "3"
        timeValue = 59
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    func countDown() {
        if timeLabel.text == "3" {
            timeLabel.text = "2"
        } else if timeLabel.text == "2" {
            timeLabel.text = "1"
        } else if timeLabel.text == "1" {
            timeLabel.text = "GO"
            currentWordLabel.text = activeGame.currentWord
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    func updateTimer() {
        timeLabel.text = "0:\(timeValue!)"
        if timeValue == 0 {
            timer.invalidate()
            finishGame()
        }
        timeValue = timeValue - 1
    }
    func finishGame() {
        startButton.setTitle("SCORE: \(activeGame.usedWords.count)", for: .normal)
        startButton.isHidden = false
        inputTextField.text = ""
        errorLogLabel.text = ""
        hintLogLabel.text = ""
        timeLabel.text = ""
        currentWordLabel.text = ""
        activeGame.usedWords = [""]
        pastWordsTableView.reloadData()
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        submit()
    }
    @IBAction func returnKeyPressed(_ sender: Any) {
        submit()
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
            scrollToBottom()
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
    @IBAction func hintButtonPressed(_ sender: Any) {
        errorLogLabel.text = ""
        hintLogLabel.text = ""
        hintActivityIndicator.isHidden = false
        hintActivityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let tmp = "There are " + String(self.activeGame.numGamePlays(on: self.activeGame.currentWord)) + " potential plays on " + self.activeGame.currentWord
            self.hintLogLabel.text = tmp
            self.hintActivityIndicator.stopAnimating()
            self.hintActivityIndicator.isHidden = true
        }
        
    }
    @IBAction func resetButtonPressed(_ sender: Any) {
        
        startButton.isEnabled = true
        startButton.setTitle("START", for: .normal)
        
        inputTextField.text = ""
        errorLogLabel.text = ""
        hintLogLabel.text = ""
        timeLabel.text = ""
        currentWordLabel.text = ""
        activeGame.usedWords = [""]
        pastWordsTableView.reloadData()
        hintActivityIndicator.isHidden = false
        hintActivityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.activeGame = WordGame()
            self.hintActivityIndicator.stopAnimating()
            self.hintActivityIndicator.isHidden = true
            self.currentWordLabel.text = ""
        }
        
    }
    
    // Properties
    var activeGame = WordGame()
    var timer: Timer!
    var timeValue: Int!
    
    // Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        pastWordsTableView.delegate = self
        pastWordsTableView.dataSource = self
        pastWordsTableView.transform = CGAffineTransform (scaleX: 1,y: -1);
        
        currentWordLabel.text = ""
        errorLogLabel.text = ""
        hintLogLabel.text = ""
        hintActivityIndicator.isHidden = true
        
        timeLabel.text = ""
        
        inputTextField.becomeFirstResponder()
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
        return activeGame.usedWords.count
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
