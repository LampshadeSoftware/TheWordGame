//
//  PlayerSetupViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 6/14/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class PlayerSetupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	static var playerList: [String]!
    var playerCount = 0
    var playerListTableView: UITableView!
    var bannerView: UIView!
    
    func backButtonPressed() {
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = kCATransitionPush
		transition.subtype = kCATransitionFromLeft
		view.window!.layer.add(transition, forKey: kCATransition)
        present(MainMenuViewController(), animated: false, completion: nil)
    }
	
	var startButton: UIButton!
	func startButtonPressed() {
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = kCATransitionPush
		transition.subtype = kCATransitionFromRight
		view.window!.layer.add(transition, forKey: kCATransition)
		present(PassPlayViewController(), animated: false, completion: nil)
	}
    
    func presentAlert() {
        let alert = UIAlertController(title: "How many players?", message: "", preferredStyle: .alert)
        let actionInput = UIAlertAction(title: "Go", style: .default) { (_) in
            let field = alert.textFields![0]
			let fieldAsNum = Int(field.text!)
            if fieldAsNum != nil && fieldAsNum! > 1 && fieldAsNum! < 25 {
                self.playerCount = fieldAsNum!
                PlayerSetupViewController.playerList = [String]()
                for i in 1...self.playerCount {
                    PlayerSetupViewController.playerList.append("Player \(i)")
                }
                self.playerListTableView.reloadData()
            } else {
                // user did not fill field
                self.present(alert, animated: true, completion: nil)
            }
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Num players"
            textField.textAlignment = .center
            textField.keyboardType = UIKeyboardType.numberPad
        }
        alert.addAction(actionInput)
        
        present(alert, animated: true, completion: nil)
    }
	
	
    
    override func viewDidLoad() {
        super.viewDidLoad()
		PlayerSetupViewController.playerList = ["Player 1", "Player 2"]
		
		view.backgroundColor = WordGameUI.dark
        bannerView = WordGameUI.getBanner(view: view)
        view.addSubview(bannerView)
		
		let infoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bannerView.bounds.width, height: bannerView.bounds.height))
		infoLabel.font = WordGameUI.font(size: 20)
		infoLabel.textColor = WordGameUI.dark
		infoLabel.textAlignment = .center
		infoLabel.text = "ENTER NAMES"
		bannerView.addSubview(infoLabel)
        
        playerListTableView = UITableView(frame: CGRect(x:0, y: view.bounds.height * 0.1, width: view.bounds.width, height: view.bounds.height * 0.9), style: UITableViewStyle.plain)
        playerListTableView.rowHeight = 64
        playerListTableView.separatorStyle = .singleLine
        playerListTableView.separatorInset = .zero
        playerListTableView.separatorColor = WordGameUI.blue
        playerListTableView.backgroundColor = WordGameUI.dark
        playerListTableView.allowsSelection = false
        playerListTableView.register(PlayerInputCell.self, forCellReuseIdentifier: "PlayerInputCell")
        playerListTableView.delegate = self
        playerListTableView.dataSource = self
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: bannerView.bounds.height))
        backButton.setTitle("BACK", for: .normal)
        backButton.setTitleColor(WordGameUI.dark, for: .normal)
        backButton.titleLabel?.font = WordGameUI.font(size: 20)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchDown)
        bannerView.addSubview(backButton)
        
        view.addSubview(playerListTableView)
		
		
		startButton = UIButton(frame: CGRect(x: bannerView.bounds.width - 100, y: 0, width: 100, height: bannerView.bounds.height))
		startButton.setTitle("START", for: .normal)
		startButton.setTitleColor(WordGameUI.dark, for: .normal)
		startButton.titleLabel?.font = WordGameUI.font(size: 20)
		startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchDown)
		bannerView.addSubview(startButton)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presentAlert()
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
        return playerCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellIdentifier = "PlayerInputCell"
        
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerInputCell  else {
            fatalError("The dequeued cell is not an instance of PlayerInputCell.")
        }
		cell.setUpCell(n: indexPath.row)
        cell.input.attributedPlaceholder = NSAttributedString(string: "Player \(indexPath.row + 1)", attributes: [NSForegroundColorAttributeName: WordGameUI.blue])
		
		return cell
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

class PlayerInputCell: UITableViewCell {
    
    var input: UITextField!
	var n: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
	
	func textFieldDidChange() {
		if input.text!.characters.count > 0 {
			PlayerSetupViewController.playerList[n] = input.text!
		} else {
			PlayerSetupViewController.playerList[n] = "Player \(n + 1)"
		}
	}
    
	func setUpCell(n: Int) {
		if self.n != nil {
			return
		}
		self.n = n
        input = UITextField(frame: CGRect(x: 20, y: 0, width: contentView.bounds.width, height: contentView.bounds.height))
        input.font = WordGameUI.font(size: 24)
        input.textColor = WordGameUI.yellow
        input.tintColor = WordGameUI.blue
		input.keyboardAppearance = .dark
		input.autocorrectionType = .no
		input.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        contentView.backgroundColor = WordGameUI.lightDark
        contentView.addSubview(input)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
