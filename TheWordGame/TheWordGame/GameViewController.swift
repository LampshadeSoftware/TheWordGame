//
//  GameViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 6/13/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // UI Elements
    var bannerView: UIView!
    
    var pastWordsTableView: UITableView!
    
    var topLabel: UILabel!
    var currentWordLabel: UILabel!
    var logLabel: UILabel!
    func errorLog(message: String) {
        logLabel.textColor = WordGameUI.red
        logLabel.text = message
    }
    func hintLog(message: String) {
        logLabel.textColor = WordGameUI.green
        logLabel.text = message
    }
    
    var inputTextField: UITextField!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnKeyPressed()
        return true
    }
    func returnKeyPressed() {
        submit()
    }
   
    var activityIndicator: UIActivityIndicatorView!
    
    var hintButton: UIButton!
    func hintButtonPressed() {
        logLabel.text = ""
        
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let tmp = "There are " + String(self.activeGame.numGamePlays(on: self.activeGame.currentWord)) + " potential plays on " + self.activeGame.currentWord
            self.hintLog(message: tmp)
            self.activityIndicator.stopAnimating()
        }

    }
    var submitButton: UIButton!
    func submitButtonPressed() {
        submit()
    }
    var resetButton: UIButton!
    func resetButtonPressed() {
        reset()
    }
    var backButton: UIButton!
    func backButtonPressed() {
        present(MainMenuViewController(), animated: true, completion: nil)
    }
    
    func setUpUI() {
        view.backgroundColor = WordGameUI.dark
        let width = view.bounds.width
        let height = view.bounds.height
        // print(width)
        // print(height)
        
        bannerView = WordGameUI.getBanner(view: view)
        view.addSubview(bannerView)
        
        pastWordsTableView = UITableView(frame: CGRect(x:0, y:height * 0.1, width: width, height: height * 0.3), style: UITableViewStyle.plain)
        pastWordsTableView.rowHeight = 64
        pastWordsTableView.separatorStyle = .none
        pastWordsTableView.backgroundColor = WordGameUI.dark
        pastWordsTableView.register(PastWordCell.self, forCellReuseIdentifier: "PastWordCell")
        pastWordsTableView.delegate = self
        pastWordsTableView.dataSource = self
        pastWordsTableView.transform = CGAffineTransform (scaleX: 1,y: -1)
        view.addSubview(pastWordsTableView)
        
        currentWordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width * 0.9, height: height * 0.15))
        currentWordLabel.font = WordGameUI.font(size: 64)
        currentWordLabel.textColor = WordGameUI.yellow
        currentWordLabel.center = CGPoint(x: width / 2, y: height * 0.45)
        currentWordLabel.textAlignment = .center
        currentWordLabel.text = ""
        currentWordLabel.shadowColor = .black
        currentWordLabel.shadowOffset = CGSize(width: 3, height: 0)
        view.addSubview(currentWordLabel)
        
        inputTextField = UITextField(frame: CGRect(x: 0, y: 0, width: width * 0.95, height: 30))
        inputTextField.borderStyle = .roundedRect
        inputTextField.backgroundColor = .white
        inputTextField.textAlignment = .center
        inputTextField.keyboardAppearance = .dark
        inputTextField.font = WordGameUI.font(size: 17)
        inputTextField.center = CGPoint(x: width / 2, y: height * 0.58)
        inputTextField.autocorrectionType = .no
        inputTextField.spellCheckingType = .no
        inputTextField.autocapitalizationType = .none
        inputTextField.returnKeyType = .done
        inputTextField.placeholder = "Enter a word"
        inputTextField.delegate = self
        inputTextField.becomeFirstResponder()
        view.addSubview(inputTextField)
        
        submitButton = UIButton(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
        submitButton.center = CGPoint(x: width - 135, y: height * 0.64)
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.setTitleColor(WordGameUI.blue, for: .normal)
        submitButton.titleLabel?.font = WordGameUI.font(size: 17)
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchDown)
        view.addSubview(submitButton)
        
        hintButton = UIButton(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
        hintButton.center = CGPoint(x: 135, y: height * 0.64)
        hintButton.setTitle("HINT", for: .normal)
        hintButton.setTitleColor(WordGameUI.green, for: .normal)
        hintButton.titleLabel?.font = WordGameUI.font(size: 17)
        hintButton.addTarget(self, action: #selector(hintButtonPressed), for: .touchDown)
        view.addSubview(hintButton)
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: width / 2 - 10, y: height * 0.51, width: 20, height: 20))
        view.addSubview(activityIndicator)
        
        topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: bannerView.bounds.height))
        topLabel.textAlignment = .center
        topLabel.font = WordGameUI.font(size: 22)
        topLabel.textColor = WordGameUI.dark
        bannerView.addSubview(topLabel)
        
        resetButton = UIButton(frame: CGRect(x: bannerView.bounds.width - 100, y: 0, width: 100, height: bannerView.bounds.height))
        resetButton.setTitle("RESET", for: .normal)
        resetButton.setTitleColor(WordGameUI.dark, for: .normal)
        resetButton.titleLabel?.font = WordGameUI.font(size: 20)
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchDown)
        bannerView.addSubview(resetButton)
        
        backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: bannerView.bounds.height))
        backButton.setTitle("BACK", for: .normal)
        backButton.setTitleColor(WordGameUI.dark, for: .normal)
        backButton.titleLabel?.font = WordGameUI.font(size: 20)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchDown)
        bannerView.addSubview(backButton)
        
        logLabel = UILabel(frame: CGRect(x: 0, y: height * 0.51, width: width, height: 22))
        logLabel.textAlignment = .center
        logLabel.font = WordGameUI.font(size: 17)
        logLabel.text = ""
        view.addSubview(logLabel)
    }
    
    // Properties
    var activeGame: WordGame!
    var gameModeIdentifier = "default"
    var defaultTopLabel = "Streak: 0"
    var saveGameEnabled = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        
        if let gameToken = Save.getToken(tokenKey: gameModeIdentifier) as! WordGame? {
            activeGame = gameToken
            currentWordLabel.text = activeGame.currentWord
            updateTopLabel()
        } else {
            currentWordLabel.text = ""
        }
        
        // Do any additional setup after loading the view.
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
    
    // General Functions
    func submit() {
        activeGame.submitWord(inputTextField.text!)
        inputTextField.text = ""
        errorLog(message: activeGame.errorLog)
        currentWordLabel.text = activeGame.currentWord
        updateTopLabel()
        DispatchQueue.main.async {
            self.pastWordsTableView.reloadData()
        }
        if activeGame.usedWords.count > 0 {
            // scrollToBottom()
        }
    }
    func resetTopLabel() {
        topLabel.text = defaultTopLabel
    }
    func updateTopLabel() {
        topLabel.text = "Streak: \(activeGame.usedWords.count)"
    }
    func reset() {
        inputTextField.text = ""
        logLabel.text = ""
        currentWordLabel.text = ""
        if activeGame != nil {
            activeGame.usedWords = [""]
        }
        pastWordsTableView.reloadData()
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.activeGame = WordGame()
            if self.saveGameEnabled {
                Save.setToken(tokenKey: self.gameModeIdentifier, newVal: self.activeGame)
            }
            self.activityIndicator.stopAnimating()
            self.doAfterReset()
            
        }
    }
    func doAfterReset() {
        resetTopLabel()
        self.currentWordLabel.text = self.activeGame.currentWord
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
        cell.setUpCell()
        cell.wordLabel!.text = word
        cell.transform = CGAffineTransform (scaleX: 1,y: -1);
        return cell
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
