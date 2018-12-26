//
//  ViewController.swift
//  Dentaku
//
//  Created by 大江祥太郎 on 2018/11/23.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import LTMorphingLabel

class ViewController: UIViewController{

    var effectTimer:Timer?
    var index:Int = 0
    
    var modeNum:Int = 0
    
    
    @IBOutlet var modeButtons: [UIButton]!
    
    @IBOutlet weak var titleLabel: LTMorphingLabel!
    
    let text = ["Time attack","Time Attack","time attack"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.morphingEffect = .fall
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        effectTimer = Timer.scheduledTimer(timeInterval: 3.0,
                                           target: self,
                                           selector: #selector(updateLabel(timer:)), userInfo: nil,
                                           repeats: true)
        effectTimer?.fire()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        effectTimer?.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func updateLabel(timer: Timer) {
        titleLabel.text = text[index]
        
        index += 1
        if index >= text.count {
            index = 0
        }
        
        
    }
    
    @IBAction func tappedModeButton(_ sender: UIButton) {
        
        switch sender.tag {
        case 0 :
            modeNum = 0
            print("1桁同士の計算")
            self.performSegue(withIdentifier: "toFirst", sender: self)
        case 1 :
            modeNum = 1
            print("1桁と２桁の計算")
            self.performSegue(withIdentifier: "toFirst", sender: self)
        case 2 :
            modeNum = 2
            print("2桁同士の計算")
            self.performSegue(withIdentifier: "toFirst", sender: self)
        default:
            break
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFirst"{
            //画面取り出す
            let firstVC = segue.destination as! FirstViewController
            switch modeNum{
            case 0:
                firstVC.modeNum = modeNum
            case 1:
                firstVC.modeNum = modeNum
            case 2:
                firstVC.modeNum = modeNum
            default:
                break
            }
            
        }
    }
    
    
}
