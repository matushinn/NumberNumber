//
//  ViewController.swift
//  Dentaku
//
//  Created by 大江祥太郎 on 2018/11/23.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var modeButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func tappedModeButton(_ sender: UIButton) {
      //  let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstVC") as! FirstViewController
        
        switch sender.tag {
        case 0 :
            //firstVC.modeNum = 0
            print("1桁同士の計算")
            self.performSegue(withIdentifier: "toFirst", sender: self)
        case 1 :
            //firstVC.modeNum = 1
            print("1桁と２桁の計算")
            self.performSegue(withIdentifier: "toSecond", sender: self)
        case 2 :
            //firstVC.modeNum = 2
            print("2桁同士の計算")
            self.performSegue(withIdentifier: "toThird", sender: self)
        default:
            break
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let firstVC = segue.destination as! FirstViewController
    }
    
    
}
