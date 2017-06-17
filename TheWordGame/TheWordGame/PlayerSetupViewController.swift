//
//  PlayerSetupViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 6/14/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class PlayerSetupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var playerList = [String!].init(repeating: nil, count: 20)
    var playerCount = 5
    var playerListTableView: UITableView!
    var bannerView: UIView!
    
    func backButtonPressed() {
        present(MainMenuViewController(), animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = WordGameUI.getBanner(view: view)
        view.addSubview(bannerView)
        
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
        // Do any additional setup after loading the view.
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
        cell.setUpCell()
        playerList[indexPath.row] = cell.input.text!

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUpCell() {
        input = UITextField(frame: CGRect(x: 20, y: 0, width: contentView.bounds.width, height: contentView.bounds.height))
        input.font = WordGameUI.font(size: 24)
        input.textColor = WordGameUI.yellow
        input.tintColor = WordGameUI.blue
        contentView.backgroundColor = WordGameUI.dark
        contentView.addSubview(input)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
