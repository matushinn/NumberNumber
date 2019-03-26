//
//  StartViewController.swift
//  Dentaku
//
//  Created by 大江祥太郎 on 2018/11/11.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import AVFoundation
import LTMorphingLabel

class StartViewController: UIViewController {
    
    
    
    var timer:Timer!
     var audioPlayer:AVAudioPlayer!
    
    private var effectTimer: Timer?
    private var index: Int = 0
    
    // 表示する文字リスト
    private let textList = ["Number","number"]
    var calList = ["+","-","×","❓"]
    
    
    @IBOutlet weak var upNumberLabel: LTMorphingLabel!
    
    @IBOutlet weak var lowNumberLabel: LTMorphingLabel!
    
    
    @IBOutlet weak var calLabel1: LTMorphingLabel!
    
    @IBOutlet weak var calLabel2: LTMorphingLabel!
    
    @IBOutlet weak var calLabel3: LTMorphingLabel!
    
    
    @IBOutlet weak var calLabel4: LTMorphingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let filePath = Bundle.main.path(forResource: "bgm",ofType: "mp3")
            
            let musicPath = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: musicPath)
            
            
        } catch {
            print("error")
        }
        
            //audioPlayer.play()
        
        upNumberLabel.morphingEffect = .fall
        lowNumberLabel.morphingEffect = .fall
        calLabel1.morphingEffect = .fall
        calLabel2.morphingEffect = .fall
        calLabel3.morphingEffect = .fall
        calLabel4.morphingEffect = .fall
    
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
        upNumberLabel.text = textList[index]
        lowNumberLabel.text = textList[index]
        
        
        switch calLabel1.text{
        case calList[0]:
            calLabel1.textColor = UIColor.blue
        case calList[1]:
            calLabel1.textColor = UIColor.green
        case calList[2]:
            calLabel1.textColor = UIColor.yellow
        case calList[3]:
            calLabel1.textColor = UIColor.red
        default:
            break
        }
        switch calLabel2.text{
        case calList[0]:
            calLabel2.textColor = UIColor.blue
        case calList[1]:
            calLabel2.textColor = UIColor.green
        case calList[2]:
            calLabel2.textColor = UIColor.yellow
        case calList[3]:
            calLabel2.textColor = UIColor.red
        default:
            break
        }
        switch calLabel3.text{
        case calList[0]:
            calLabel3.textColor = UIColor.blue
        case calList[1]:
            calLabel3.textColor = UIColor.green
        case calList[2]:
            calLabel3.textColor = UIColor.yellow
        case calList[3]:
            calLabel3.textColor = UIColor.red
        default:
            break
        }
        switch calLabel4.text{
        case calList[0]:
            calLabel4.textColor = UIColor.blue
        case calList[1]:
            calLabel4.textColor = UIColor.green
        case calList[2]:
            calLabel4.textColor = UIColor.yellow
        case calList[3]:
            calLabel4.textColor = UIColor.red
        default:
            break
        }
        //シャッフル
        for i in 0 ..< calList.count{
            let r = Int(arc4random_uniform(UInt32(calList.count)))
            calList.swapAt(i, r)
        }
        
        calLabel1.text = calList[0]
        calLabel2.text = calList[1]
        calLabel3.text = calList[2]
        calLabel4.text = calList[3]
        
        
        index += 1
        if index >= textList.count {
            index = 0
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        audioPlayer.play()
    }
    @IBAction func timeAttackButton(_ sender: Any) {
        audioPlayer.stop()
        self.performSegue(withIdentifier: "toTimeAttack", sender: nil)
    }
    
    
}
