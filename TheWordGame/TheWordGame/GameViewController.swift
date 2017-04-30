//
//  ViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 4/26/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Outelts
    @IBOutlet weak var pastWordsTableView: PastWordsTableView!
    @IBOutlet weak var currentWordLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    // Actions
    @IBAction func submitButtonPressed(_ sender: Any) {
        activeGame.submitWord(inputTextField.text!)
        inputTextField.text = ""
        currentWordLabel.text = activeGame.currentWord
        pastWordsTableView.reloadData()
        scrollToBottom()
        
    }
    func scrollToBottom(){
        DispatchQueue.global(qos: .background).async {
            let indexPath = IndexPath(row: self.activeGame.usedWords.count - 1, section: 0)
            self.pastWordsTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    // Properties
    var activeGame = WordGame()
    
    // Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        let indexPath = IndexPath(row: self.activeGame.usedWords.count - 1, section: 0)
        // Do any additional setup after loading the view, typically from a nib.
        pastWordsTableView.delegate = self
        pastWordsTableView.dataSource = self
        pastWordsTableView.transform = CGAffineTransform (scaleX: 1,y: -1);
        pastWordsTableView.cellForRow(at: indexPath) = CGAffineTransform (scaleX: 1,y: -1);
        currentWordLabel.text = activeGame.currentWord
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
        
        word = activeGame.usedWords[indexPath.row]
        
        cell.wordLabel!.text = word
        return cell
    }


}

