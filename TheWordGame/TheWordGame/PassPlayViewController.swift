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
			if self.activeGame.numActivePlayers() == 1 {
				self.clearTiles()
				self.presentVictoryAlert(winner: self.activeGame.getCurrentPlayer().name)
			}
			self.updateTopLabel()
		}
		let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
		alert.addAction(yesAction)
		alert.addAction(noAction)
		
		present(alert, animated: true, completion: nil)
	}
	
	func presentVictoryAlert(winner: String) {
		let alert = UIAlertController(title: "\(winner) wins!", message: "Final word: \(activeGame.currentWord)", preferredStyle: .alert)
		let quitAction = UIAlertAction(title: "Quit", style: .destructive) { (_) in
			Save.setToken(tokenKey: "passPlay", newVal: nil)
			self.backButtonPressed()
		}
		let againAction = UIAlertAction(title: "Play Again", style: .default) { (_) in
			self.resetButtonPressed()
		}
		alert.addAction(quitAction)
		alert.addAction(againAction)
		
		present(alert, animated: true, completion: nil)
	}

    override func viewDidLoad() {
        gameModeIdentifier = "passPlay"
        super.viewDidLoad()
		let width = view.bounds.width
		let height = view.bounds.height
		
		giveUpButton = UIButton(frame: CGRect(x: 0, y: height * 0.55 + 40, width: width / 3, height: 45))
		giveUpButton.setTitle("FORFEIT", for: .normal)
		giveUpButton.backgroundColor = WordGameUI.red
		giveUpButton.setTitleColor(WordGameUI.dark, for: .normal)
		giveUpButton.titleLabel?.font = WordGameUI.font(size: 17)
		giveUpButton.addTarget(self, action: #selector(giveUpButtonPressed), for: .touchDown)
		view.addSubview(giveUpButton)
		
		hintButton.frame = CGRect(x: width / 3.0, y: height * 0.55 + 40, width: width / 3, height: 45)
		submitButton.frame = CGRect(x: 2 * width / 3.0, y: height * 0.55 + 40, width: width / 3, height: 45)
		
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
