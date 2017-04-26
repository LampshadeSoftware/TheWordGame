//
//  ViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 4/26/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Outelts
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var userInput: UITextField!
    
    // Actions
    @IBAction func playWord(_ sender: Any) {
        updateWord()
    }
    
    // Functions
    func updateWord() {
        wordLabel.text = userInput.text
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

