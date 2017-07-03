//
//  MainMenuViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 6/13/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit
import iAd

class MainMenuViewController: UIViewController {
	
	var zenPortal: UIButton!
    func zenPortalPressed() {
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = kCATransitionPush
		transition.subtype = kCATransitionFromRight
		view.window!.layer.add(transition, forKey: kCATransition)
		present(ZenGameViewController(), animated: false, completion: nil)
    }
	func zenPortalTouched() {
		zenPortal.backgroundColor = WordGameUI.lightDark
		zenPortal.setTitleColor(WordGameUI.green, for: .normal)
	}
	func zenPortalTouchLeft() {
		zenPortal.backgroundColor = WordGameUI.green
		zenPortal.setTitleColor(WordGameUI.dark, for: .normal)
	}
    var timePortal: UIButton!
    func timePortalPressed() {
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = kCATransitionPush
		transition.subtype = kCATransitionFromRight
		view.window!.layer.add(transition, forKey: kCATransition)
        present(TimeGameViewController(), animated: false, completion: nil)
    }
	func timePortalTouched() {
		timePortal.backgroundColor = WordGameUI.lightDark
		timePortal.setTitleColor(WordGameUI.blue, for: .normal)
	}
	func timePortalTouchLeft() {
		timePortal.backgroundColor = WordGameUI.blue
		timePortal.setTitleColor(WordGameUI.dark, for: .normal)
	}
    var passPlayPortal: UIButton!
    func passPlayPortalPressed() {
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = kCATransitionPush
		transition.subtype = kCATransitionFromRight
		view.window!.layer.add(transition, forKey: kCATransition)
		if Save.getToken(tokenKey: "passPlay") == nil {
			present(PlayerSetupViewController(), animated: false, completion: nil)
		} else {
			present(PassPlayViewController(), animated: false, completion: nil)
		}
    }
	func passPlayPortalTouched() {
		passPlayPortal.backgroundColor = WordGameUI.lightDark
		passPlayPortal.setTitleColor(WordGameUI.yellow, for: .normal)
	}
	func passPlayPortalTouchLeft() {
		passPlayPortal.backgroundColor = WordGameUI.yellow
		passPlayPortal.setTitleColor(WordGameUI.dark, for: .normal)
	}
	var instructionsPortal: UIButton!
	func instructionsPortalPressed() {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Instructions")
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = kCATransitionPush
		transition.subtype = kCATransitionFromRight
		view.window!.layer.add(transition, forKey: kCATransition)
		present(vc, animated: false, completion: nil)
	}
    var resetButton: UIButton!
    func resetButtonPressed() {
        let alert = UIAlertController(title: "Reset", message: "Are you sure you want to reset all saved data?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (_) in
            Save.resetData()
        }
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func generateTitle() {
        let width = view.bounds.width
        var tmp = UILabel(frame: CGRect(x: 0, y: 15, width: width, height: 82))
        tmp.text = "THE"
        tmp.textColor = WordGameUI.blue
        tmp.textAlignment = .center
        tmp.font = WordGameUI.font(size: 58)
        view.addSubview(tmp)
        
        tmp = UILabel(frame: CGRect(x: 0, y: 67, width: width, height: 82))
        tmp.text = "WORD"
        tmp.textColor = WordGameUI.yellow
        tmp.textAlignment = .center
        tmp.font = UIFont(name: "Gill Sans", size: 72)
		view.addSubview(tmp)
        
        tmp = UILabel(frame: CGRect(x: 0, y: 118, width: width, height: 82))
        tmp.text = "GAME"
        tmp.textColor = WordGameUI.blue
        tmp.textAlignment = .center
        tmp.font = WordGameUI.font(size: 58)
        view.addSubview(tmp)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WordGameUI.dark
        generateTitle()
    
        let width = view.bounds.width
        let height = view.bounds.height
		
		zenPortal = UIButton(frame: CGRect(x: 0, y: height / 3, width: width, height: 50))
        zenPortal.setTitle("ZEN", for: .normal)
        zenPortal.setTitleColor(WordGameUI.dark, for: .normal)
		zenPortal.backgroundColor = WordGameUI.green
        zenPortal.titleLabel?.font = WordGameUI.font(size: 42)
        zenPortal.titleLabel?.textAlignment = .center
        zenPortal.addTarget(self, action: #selector(zenPortalPressed), for: .touchUpInside)
		zenPortal.addTarget(self, action: #selector(zenPortalTouched), for: .touchDown)
		zenPortal.addTarget(self, action: #selector(zenPortalTouchLeft), for: .touchDragExit)
		zenPortal.addTarget(self, action: #selector(zenPortalTouched), for: .touchDragEnter)
        view.addSubview(zenPortal)
        
        timePortal = UIButton(frame: CGRect(x: 0, y: height / 3 + 70, width: width, height: 50))
        timePortal.setTitle("TIME TRIAL", for: .normal)
        timePortal.setTitleColor(WordGameUI.dark, for: .normal)
		timePortal.backgroundColor = WordGameUI.blue
        timePortal.titleLabel?.font = WordGameUI.font(size: 42)
        timePortal.titleLabel?.textAlignment = .center
        timePortal.addTarget(self, action: #selector(timePortalPressed), for: .touchUpInside)
		timePortal.addTarget(self, action: #selector(timePortalPressed), for: .touchUpInside)
		timePortal.addTarget(self, action: #selector(timePortalTouched), for: .touchDown)
		timePortal.addTarget(self, action: #selector(timePortalTouchLeft), for: .touchDragExit)
		timePortal.addTarget(self, action: #selector(timePortalTouched), for: .touchDragEnter)
        view.addSubview(timePortal)
        
        passPlayPortal = UIButton(frame: CGRect(x: 0, y: height / 3 + 140, width: width, height: 50))
        passPlayPortal.setTitle("MULTIPLAYER", for: .normal)
        passPlayPortal.setTitleColor(WordGameUI.dark, for: .normal)
		passPlayPortal.backgroundColor = WordGameUI.yellow
        passPlayPortal.titleLabel?.font = WordGameUI.font(size: 42)
        passPlayPortal.titleLabel?.textAlignment = .center
        passPlayPortal.addTarget(self, action: #selector(passPlayPortalPressed), for: .touchUpInside)
		passPlayPortal.addTarget(self, action: #selector(passPlayPortalPressed), for: .touchUpInside)
		passPlayPortal.addTarget(self, action: #selector(passPlayPortalTouched), for: .touchDown)
		passPlayPortal.addTarget(self, action: #selector(passPlayPortalTouchLeft), for: .touchDragExit)
		passPlayPortal.addTarget(self, action: #selector(passPlayPortalTouched), for: .touchDragEnter)
        view.addSubview(passPlayPortal)
		
		instructionsPortal = UIButton(frame: CGRect(x: 0, y: height - height / 3, width: width, height: 50))
		instructionsPortal.setTitle("INSTRUCTIONS", for: .normal)
		instructionsPortal.setTitleColor(.white, for: .normal)
		instructionsPortal.backgroundColor = WordGameUI.lightDark
		instructionsPortal.titleLabel?.font = WordGameUI.font(size: 42)
		instructionsPortal.titleLabel?.textAlignment = .center
		instructionsPortal.addTarget(self, action: #selector(instructionsPortalPressed), for: .touchUpInside)
		view.addSubview(instructionsPortal)
		
        resetButton = UIButton(frame: CGRect(x: 0, y: height - 50, width: 100, height: 50))
        resetButton.setTitle("RESET", for: .normal)
        resetButton.setTitleColor(WordGameUI.red, for: .normal)
        resetButton.titleLabel?.textAlignment = .center
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        view.addSubview(resetButton)
	
		
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
