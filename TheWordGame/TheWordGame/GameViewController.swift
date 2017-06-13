//
//  GameViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 6/13/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // UI Elements
    var pastWordsTableView: PastWordsTableView!
    
    var topLabel: UILabel!
    var currentWordLabel: UILabel!
    var logLabel: UILabel!
    
    var inputTextField: UITextField!
   
    var activityIndicator: UIActivityIndicatorView!
    
    var hintButton: UIButton!
    func hintButtonPressed() {
        
    }
    var submitButton: UIButton!
    func submitButtonPressed() {
        
    }
    
    func setUpUI() {
        view.backgroundColor = WordGameUI.dark
        let width = view.bounds.width
        let height = view.bounds.height
        currentWordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width * 0.9, height: height * 0.15))
        currentWordLabel.font = WordGameUI.font(size: 64)
        currentWordLabel.textColor = WordGameUI.yellow
        currentWordLabel.center = CGPoint(x: width / 2, y: height * 0.45)
        currentWordLabel.textAlignment = .center
        currentWordLabel.text = "testing"
        self.view.addSubview(currentWordLabel)
        
        inputTextField = UITextField(frame: CGRect(x: 0, y: 0, width: width * 0.95, height: 30))
        inputTextField.borderStyle = UITextBorderStyle.roundedRect
        inputTextField.backgroundColor = UIColor.white
        inputTextField.textAlignment = .center
        inputTextField.keyboardAppearance = UIKeyboardAppearance.dark
        inputTextField.font = WordGameUI.font(size: 17)
        inputTextField.center = CGPoint(x: width / 2, y: height * 0.58)
        inputTextField.autocorrectionType = UITextAutocorrectionType.no
        inputTextField.spellCheckingType = UITextSpellCheckingType.no
        inputTextField.autocapitalizationType = UITextAutocapitalizationType.none
        inputTextField.returnKeyType = UIReturnKeyType.done
        inputTextField.becomeFirstResponder()
        self.view.addSubview(inputTextField)
        
        
    }
    
    // Properties
    var activeGame: WordGame!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
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
