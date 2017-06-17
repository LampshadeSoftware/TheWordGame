//
//  MainMenuViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 6/13/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    
    var zenPortal: UIButton!
    func zenPortalPressed() {
        present(ZenGameViewController(), animated: true, completion: nil)
    }
    var timePortal: UIButton!
    func timePortalPressed() {
        present(TimeGameViewController(), animated: true, completion: nil)
    }
    var passPlayPortal: UIButton!
    func passPlayPortalPressed() {
        present(PlayerSetupViewController(), animated: true, completion: nil)
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
        var tmp = UILabel(frame: CGRect(x: 0, y: 7, width: width, height: 82))
        tmp.text = "the"
        tmp.textColor = WordGameUI.blue
        tmp.textAlignment = .center
        tmp.font = WordGameUI.font(size: 64)
        view.addSubview(tmp)
        
        tmp = UILabel(frame: CGRect(x: 0, y: 67, width: width, height: 82))
        tmp.text = "WORD"
        tmp.textColor = WordGameUI.yellow
        tmp.textAlignment = .center
        tmp.font = UIFont(name: "Gill Sans", size: 72)
        tmp.shadowColor = .black
        tmp.shadowOffset = CGSize(width: 3, height: 0)
        view.addSubview(tmp)
        
        tmp = UILabel(frame: CGRect(x: 0, y: 118, width: width, height: 82))
        tmp.text = "game"
        tmp.textColor = WordGameUI.blue
        tmp.textAlignment = .center
        tmp.font = WordGameUI.font(size: 64)
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
        zenPortal.setTitleColor(WordGameUI.green, for: .normal)
        zenPortal.titleLabel?.font = WordGameUI.font(size: 42)
        zenPortal.titleLabel?.textAlignment = .center
        zenPortal.addTarget(self, action: #selector(zenPortalPressed), for: .touchDown)
        view.addSubview(zenPortal)
        
        timePortal = UIButton(frame: CGRect(x: 0, y: height / 3 + 70, width: width, height: 50))
        timePortal.setTitle("TIME TRIAL", for: .normal)
        timePortal.setTitleColor(WordGameUI.green, for: .normal)
        timePortal.titleLabel?.font = WordGameUI.font(size: 42)
        timePortal.titleLabel?.textAlignment = .center
        timePortal.addTarget(self, action: #selector(timePortalPressed), for: .touchDown)
        view.addSubview(timePortal)
        
        passPlayPortal = UIButton(frame: CGRect(x: 0, y: height / 3 + 140, width: width, height: 50))
        passPlayPortal.setTitle("MULTIPLAYER", for: .normal)
        passPlayPortal.setTitleColor(WordGameUI.green, for: .normal)
        passPlayPortal.titleLabel?.font = WordGameUI.font(size: 42)
        passPlayPortal.titleLabel?.textAlignment = .center
        passPlayPortal.addTarget(self, action: #selector(passPlayPortalPressed), for: .touchDown)
        view.addSubview(passPlayPortal)
        
        resetButton = UIButton(frame: CGRect(x: 0, y: height - 50, width: 100, height: 50))
        resetButton.setTitle("RESET", for: .normal)
        resetButton.setTitleColor(WordGameUI.red, for: .normal)
        resetButton.titleLabel?.textAlignment = .center
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchDown)
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
