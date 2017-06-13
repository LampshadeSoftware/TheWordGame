//
//  ViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 4/26/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class ZenGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Outelts
    @IBOutlet weak var pastWordsTableView: PastWordsTableView!
    @IBOutlet weak var currentWordLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var errorLogLabel: UILabel!
    @IBOutlet weak var hintLogLabel: UILabel!
    @IBOutlet weak var hintActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var streakLabel: UILabel!
    
    // Actions
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
        streakLabel.text = "Streak: \(activeGame.usedWords.count)"
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
    @IBAction func hintButtonPressed(_ sender: Any) {
        errorLogLabel.text = ""
        hintLogLabel.text = ""
        
        hintActivityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let tmp = "There are " + String(self.activeGame.numGamePlays(on: self.activeGame.currentWord)) + " potential plays on " + self.activeGame.currentWord
            self.hintLogLabel.text = tmp
            self.hintActivityIndicator.stopAnimating()
        }
        
    }
    @IBAction func resetButtonPressed(_ sender: Any) {
        reset()
    }
    
    func reset() {
        inputTextField.text = ""
        errorLogLabel.text = ""
        hintLogLabel.text = ""
        streakLabel.text = "Streak: 0"
        currentWordLabel.text = ""
        if activeGame != nil {
            activeGame.usedWords = [""]
        }
        pastWordsTableView.reloadData()
        hintActivityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.activeGame = WordGame()
            Save.setToken(tokenKey: "zenActiveGame", newVal: self.activeGame)
            self.hintActivityIndicator.stopAnimating()
            self.currentWordLabel.text = self.activeGame.currentWord
        }
    }
    
    // Properties
    var activeGame: WordGame!
    
    // Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        pastWordsTableView.delegate = self
        pastWordsTableView.dataSource = self
        pastWordsTableView.transform = CGAffineTransform (scaleX: 1,y: -1);
        
        currentWordLabel.text = ""
        
        if let gameToken = Save.getToken(tokenKey: "zenActiveGame") as! WordGame? {
            activeGame = gameToken
            currentWordLabel.text = activeGame.currentWord
            streakLabel.text = "Streak: \(activeGame.usedWords.count)"
        } else {
            currentWordLabel.text = ""
            
        }
        
        errorLogLabel.text = ""
        hintLogLabel.text = ""
        
        inputTextField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if activeGame == nil {
            reset()
        }
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

