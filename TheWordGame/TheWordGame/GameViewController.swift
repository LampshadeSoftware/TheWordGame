//
//  GameViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 6/13/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    // UI Elements
    var bannerView: UIView!
    
    var pastWordsTableView: UITableView!
    
    var topLabel: UILabel!
	
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
		
		/*
        pastWordsTableView = UITableView(frame: CGRect(x:0, y:height * 0.1, width: width, height: height * 0.3), style: UITableViewStyle.plain)
        pastWordsTableView.rowHeight = 64
        pastWordsTableView.separatorStyle = .none
        pastWordsTableView.backgroundColor = WordGameUI.dark
        pastWordsTableView.register(PastWordCell.self, forCellReuseIdentifier: "PastWordCell")
        pastWordsTableView.delegate = self
        pastWordsTableView.dataSource = self
        pastWordsTableView.transform = CGAffineTransform (scaleX: 1,y: -1)
        view.addSubview(pastWordsTableView)
		
		*/
        
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
		
		// New UI Stuff
		screenSize = self.view.bounds
		defaultDimension = Double(0.9*screenSize.width)/(1.1*4.0 - 0.1)
		//self.currentWordHolderView.center = self.view.center
		
		// Styling for add indicator
		currentWordHolderView = UIView(frame: CGRect(x: 0, y: height * 0.33, width: width, height: 80))
		
		changedLetterIndicator = UIView(frame: CGRect(x: 0, y: 85, width: 40, height: 10))
		changedLetterIndicator.backgroundColor = UIColor(red:0.94, green:0.56, blue:0.23, alpha:1.0)
		changedLetterIndicator.alpha = 0
		currentWordHolderView.addSubview(changedLetterIndicator)
		view.addSubview(currentWordHolderView)
		
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
            // currentWordLabel.text = activeGame.currentWord
            updateTopLabel()
        } else {
            // currentWordLabel.text = ""
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
		let play = inputTextField.text!
        let move = activeGame.submitWord(play)
		if move >= 0 {
			let type: Int = move / 100
			let index = move % 100
			if type == 0 {
				addTile(letter: play[index], index: index)
			} else if type == 1 {
				removeTile(index: index)
			} else if type == 2 {
				swapTile(letter: play[index], index: index)
			}
		}
        inputTextField.text = ""
        errorLog(message: activeGame.errorLog)
        // currentWordLabel.text = activeGame.currentWord
        updateTopLabel()
        DispatchQueue.main.async {
            // self.pastWordsTableView.reloadData()
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
        // currentWordLabel.text = ""
        if activeGame != nil {
            activeGame.usedWords = [""]
        }
        // pastWordsTableView.reloadData()
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
        // self.currentWordLabel.text = self.activeGame.currentWord
		setTiles(to: activeGame.currentWord)
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
	
	// New UI Stuff
	var screenSize: CGRect!
	var currentWordHolderView: UIView!
	var currentDimension: Double! // is the scalled dimesion when more than 4 tiles are on screen
	var defaultDimension: Double! // this dimension perfectly fits 4 tiles on a screen without scalling
	var newTile: Tile!  // is the tile that was added most recently
	var currentWord = [Tile]()  // Array of all tiles (letters) on the screen
	var moveType: Int!  // 0: add, 1: remove, 2: sub, 3: rearrange
	var previousMoveType = 1
	var changedLetterIndicator = UIView()
	
	func addTile(letter: String, index: Int){
		// creates a new tile
		moveType = 0
		newTile = Tile(letter: letter, defaultDimension: defaultDimension)
		currentWordHolderView.addSubview(newTile)
		currentWord.insert(newTile, at: index)
		updateWordVisuals(index: index)  // centers all the other letters and adjusts their size
	}
	func removeTile(index: Int){
		moveType = 1
		let tileToRemove = currentWord[index]
		currentWord.remove(at: index)
		self.updateWordVisuals(index: index)  // centers all the other letters and adjusts their size
		
		// Fades out the tile to remove
		UIView.animate(withDuration: 0.5, animations: {
			tileToRemove.alpha = 0
			tileToRemove.center.y += 100
		}) { (sucsess:Bool) in
			tileToRemove.removeFromSuperview()
		}
	}
	func swapTile(letter: String, index: Int){
		moveType = 2
		let oldTile = currentWord[index]
		currentWord.remove(at: index)
		
		UIView.animate(withDuration: 0.5, animations: {
			oldTile.alpha = 0
			oldTile.center.y -= 75
		}) { (sucsess:Bool) in
			oldTile.removeFromSuperview()
		}
		
		newTile = Tile(letter: letter, defaultDimension: defaultDimension)
		newTile.center = oldTile.center
		newTile.center.y += 150
		newTile.transform = oldTile.transform
		currentWordHolderView.addSubview(newTile)
		currentWord.insert(newTile, at: index)
		updateWordVisuals(index: index)
	}
	func updateWordVisuals(index: Int){
		currentWordHolderView.bringSubview(toFront: changedLetterIndicator)
		// gets dimension variables
		let numTiles = currentWord.count
		currentDimension = Double(0.9*screenSize.width)/(1.1*Double(numTiles) - 0.1)
		if currentDimension > defaultDimension || currentDimension < 0 {  // sets max tile size
			currentDimension = defaultDimension
		}
		let scaleDimension = currentDimension/defaultDimension  // is a decimal value e.g. 0.8
		let scaledTileHeight = self.newTile.bounds.height*CGFloat(scaleDimension) // represents the new height after the original is scaled
		
		// sets initial xPos to match 5% padding on each side and centers the tiles
		var xPos = Double(screenSize.width * 0.05)
		if currentWord.count < 4{
			xPos += Double(4 - currentWord.count)*currentDimension*1.1/2.0
		}
		
		// centers a letter thats added by calculating where its center will be
		if moveType == 0 || moveType == 2{ // is ADD or SWAP
			let xCenter = CGFloat(xPos) + CGFloat(index)*scaledTileHeight*1.1 + CGFloat(currentDimension/2)
			if previousMoveType != 0 && previousMoveType != 2{  // centers the letter indicator
				changedLetterIndicator.center.x = xCenter
			}
			if moveType == 0{
				newTile.center.x = xCenter
				newTile.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
			}
		}
		
		UIView.animate(withDuration: 0.7) {
			self.newTile.alpha = 1
			for index in 0..<self.currentWord.count{
				let tile = self.currentWord[index]
				tile.removeIndicator()
				tile.transform = CGAffineTransform(scaleX: CGFloat(scaleDimension), y: CGFloat(scaleDimension))
				tile.frame.origin = CGPoint(x: xPos, y: 0)
				tile.center.y = self.currentWordHolderView.bounds.height/2
				tile.setTileStyle()
				xPos += Double(scaledTileHeight) * 1.1
			}
			
			self.newTile.addIndicator()
			
			// Adds the slide changedLetterIndicator
			if self.moveType == 0 || self.moveType == 2 {
				self.changedLetterIndicator.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 50*scaleDimension, height: 10*scaleDimension))
				self.changedLetterIndicator.alpha = 0 // SET TO 1 TO ENABLE THE SLIDE ADD EFFECT
				self.changedLetterIndicator.center.x = self.newTile.center.x
				let yCenter = self.newTile.center.y + scaledTileHeight/CGFloat(2) + self.changedLetterIndicator.bounds.height
				self.changedLetterIndicator.center.y = yCenter
			} else {
				if self.changedLetterIndicator.center.y < 120 {
					self.changedLetterIndicator.center.y += 100
					self.changedLetterIndicator.alpha = 0
				}
			}
		} // END of UIView animation
		
		previousMoveType = moveType
	}
	func setTiles(to word: String) {
		for _ in 0..<currentWord.count {
			removeTile(index: 0)
		}
		currentWord = [Tile]()
		for char in word.characters {
			addTile(letter: String(char), index: currentWord.count)
		}
		
	}

}
