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
    
    // Actions
    @IBAction func submitButtonPressed(_ sender: Any) {
    }
    
    // Properties
    var activeGame = WordGame()
    
    // Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pastWordsTableView.delegate = self
        pastWordsTableView.dataSource = self
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
        
        let word = activeGame.usedWords.dropFirst()[indexPath.row]
        cell.wordLabel!.text = word
        return cell
    }


}

