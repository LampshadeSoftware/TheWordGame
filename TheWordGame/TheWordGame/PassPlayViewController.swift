//
//  PassPlayViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 6/14/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class PassPlayViewController: GameViewController {
	
	var giveUpButton: UIButton!
	func giveUpButtonPressed() {
		let alert = UIAlertController(title: "Forfeit", message: "Are you sure you want to give up?", preferredStyle: .alert)
		let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (_) in
			self.activeGame.playerForfeited()
			self.updateTopLabel()
		}
		let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
		alert.addAction(yesAction)
		alert.addAction(noAction)
		
		present(alert, animated: true, completion: nil)
	}

    override func viewDidLoad() {
        gameModeIdentifier = "passPlay"
        super.viewDidLoad()
        self.hintButton.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height * 0.64)
		self.submitButton.center = CGPoint(x: view.bounds.width - 90, y: view.bounds.height * 0.64)
		
		giveUpButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
		giveUpButton.center = CGPoint(x: 90, y: view.bounds.height * 0.64)
		giveUpButton.setTitle("FORFEIT", for: .normal)
		giveUpButton.setTitleColor(WordGameUI.red, for: .normal)
		giveUpButton.titleLabel?.font = WordGameUI.font(size: 17)
		giveUpButton.addTarget(self, action: #selector(giveUpButtonPressed), for: .touchDown)
		view.addSubview(giveUpButton)
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
		for player in PlayerSetupViewController.playerList {
			activeGame.addPlayer(player)
		}
        updateTopLabel()
    }
	override func resetButtonPressed() {
		let alert = UIAlertController(title: "Are you playing with the same people?", message: "", preferredStyle: .alert)
		let sameAction = UIAlertAction(title: "Same Players", style: .default) { (_) in
			self.reset()
		}
		let newAction = UIAlertAction(title: "New Players", style: .cancel) { (_) in
			Save.unsetToken(tokenKey: "passPlay")
			self.present(PlayerSetupViewController(), animated: true, completion: nil)
		}
		alert.addAction(sameAction)
		alert.addAction(newAction)
		
		present(alert, animated: true, completion: nil)
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
