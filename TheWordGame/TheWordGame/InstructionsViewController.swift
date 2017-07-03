//
//  InstructionsViewController.swift
//  TheWordGame
//
//  Created by Daniel McCrystal on 7/2/17.
//  Copyright © 2017 Lampshade Software. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {

	func backButtonPressed() {
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = kCATransitionPush
		transition.subtype = kCATransitionFromLeft
		view.window!.layer.add(transition, forKey: kCATransition)
		present(MainMenuViewController(), animated: false, completion: nil)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = WordGameUI.dark
		
		let bannerView = WordGameUI.getBanner(view: view)
		view.addSubview(bannerView)
		
		let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: bannerView.bounds.height))
		backButton.setTitle("BACK", for: .normal)
		backButton.setTitleColor(WordGameUI.dark, for: .normal)
		backButton.titleLabel?.font = WordGameUI.font(size: 20)
		backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchDown)
		bannerView.addSubview(backButton)
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
