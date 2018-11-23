//
//  FirstResultViewController.swift
//  Dentaku
//
//  Created by 大江祥太郎 on 2018/11/16.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import Social
import AVFoundation
import LTMorphingLabel

class FirstResultViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    
    @IBOutlet weak var lastScoreLabel: LTMorphingLabel!
    
    
    @IBOutlet weak var lastScoreTextLabel: LTMorphingLabel!
    
    @IBOutlet weak var rankLabel: LTMorphingLabel!
    
    @IBOutlet weak var rankTextLabel: LTMorphingLabel!
    
    @IBOutlet weak var shareTextLabel: LTMorphingLabel!
    
    var timerArray = [Double]()
    var highTimerArray = [Double]()
    var firstQuestionNumArray = [Int]()
    var lastTime:Double = 0.0
    var highTime:Double = 0.0
    
    var rankResault:String!
    var rank:Double = 0
    
    var effectTimer:Timer?
    var index:Int = 0
    
    //var rankText = ["○❓△Rank","○❓△rank","○❓△RANK"]
    
    let ud = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LTMorphing
        rankLabel.morphingEffect = .burn
        rankTextLabel.morphingEffect = .fall
        lastScoreTextLabel.morphingEffect = .sparkle
        lastScoreLabel.morphingEffect = .sparkle
        shareTextLabel.morphingEffect = .pixelate
        
        do {
            let filePath = Bundle.main.path(forResource: "goal",ofType: "mp3")
            let musicPath = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: musicPath)
            
        } catch {
            print("error")
        }
        audioPlayer.play()
        
        
        ///lastScoreというキー値で保存された、配列timerArrayを取り出す
        if ud.object(forKey: "lastScore") != nil{
            timerArray = ud.object(forKey: "lastScore") as! [Double]
            lastTime = timerArray[0]
            lastScoreTextLabel.text = String(lastTime)
        }
        rankQuestion()
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
       // rankTextLabel.text = rankText[index]
        rankLabel.text = rankResault
        
        
    }
    
    
    func rankQuestion(){
        if UserDefaults.standard.object(forKey: "firstQuestionsNum") != nil{
            firstQuestionNumArray = ud.object(forKey: "firstQuestionsNum") as! [Int]
            
            rankCheck()
            ud.removeObject(forKey: "firstQuestionsNum")
            
            /*    問題と解答を削除したので、キーが"questions"のオブジェクトの値がnilになる
             *  -> 読み込まれたときのエラーを回避するために値に空の配列を入れておく
             */
            ud.set([], forKey: "firstQuestionsNum")
        }
    }
    func rankCheck(){
        rank = lastTime/Double(firstQuestionNumArray[0])
        switch rank {
        case 0..<1.0:
            rankLabel.textColor = UIColor.blue
            rankResault = "SS"
        case 1.0..<1.5:
            rankLabel.textColor = UIColor.purple
            rankResault = "SS"
        case 1.5..<1.8:
            rankLabel.textColor = UIColor.orange
            rankResault = "S"
        case 1.8..<2.0:
            rankLabel.textColor = UIColor.yellow
            rankResault = "A"
        case 2.0..<2.3:
            rankLabel.textColor = UIColor.yellow
            rankResault = "B"
        case 2.3..<2.5:
            rankLabel.textColor = UIColor.yellow
            rankResault = "C"
        case 2.5..<2.8:
            rankLabel.textColor = UIColor.red
            rankResault = "D"
        case 2.8..<3.0:
            rankLabel.textColor = UIColor.red
            rankResault = "E"
        case 3.0..<3.3:
            rankLabel.textColor = UIColor.red
            rankResault = "F"
        case 3.3..<3.5:
            rankLabel.textColor = UIColor.magenta
            rankResault = "G"
            
        default:
            rankLabel.textColor = UIColor.magenta
            rankResault = "Z"
            
        }
        rankLabel.text = rankResault
    }


    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toReset", sender: nil)
        
    }
    @IBAction func TweetButton(sender: UIButton) {
        
        let text = "Number❓Number"
        
        let composeViewController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
        composeViewController.setInitialText(text)
        
        self.present(composeViewController, animated: true, completion: nil)
    }
    @IBAction func FacebookButton(sender: UIButton) {
        
        let text = "Number❓Number"
        
        let composeViewController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
        composeViewController.setInitialText(text)
        
        self.present(composeViewController, animated: true, completion: nil)
    }
    
    
    
}

