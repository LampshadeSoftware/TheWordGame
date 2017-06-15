//
//  PassPlayViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 6/14/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class PassPlayViewController: GameViewController {

    override func viewDidLoad() {
        gameModeIdentifier = "passPlay"
        super.viewDidLoad()
        // topLabel.text = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func resetTopLabel() {
        topLabel.text = ""
    }
    override func updateTopLabel() {
        topLabel.text = "\(activeGame.getCurrentPlayer().name)\'s turn"
    }
    
    override func doAfterReset() {
        super.doAfterReset()
        activeGame.addPlayer("Daniel")
        activeGame.addPlayer("Cowboy")
        activeGame.addPlayer("Rio")
        updateTopLabel()
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
