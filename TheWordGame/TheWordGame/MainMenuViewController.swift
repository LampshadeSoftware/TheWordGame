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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WordGameUI.dark
    
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
