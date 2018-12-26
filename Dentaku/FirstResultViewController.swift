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


class FirstResultViewController: UIViewController  {
    
    
   
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
    var timeIndex:Int = 0
    var shareIndex:Int = 0
    
    //var rankText = ["○❓△Rank","○❓△rank","○❓△RANK"]
    var timeText = ["Last Time","Time"]
    var shareText = ["share!!","share share!!","share share share!!"]
    let ud = UserDefaults.standard
    
    //桁数を判別する変数
    var modeNum:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //LTMorphing
        rankLabel.morphingEffect = .burn
        rankTextLabel.morphingEffect = .fall
        lastScoreTextLabel.morphingEffect = .sparkle
        lastScoreLabel.morphingEffect = .sparkle
        shareTextLabel.morphingEffect = .fall
        
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
        //rankLabel.text = rankResault
        lastScoreLabel.text = timeText[timeIndex]
        shareTextLabel.text = shareText[shareIndex]
        
        timeIndex += 1
        if timeIndex >= timeText.count {
            timeIndex = 0
        }
        shareIndex += 1
        if shareIndex >= shareText.count{
            shareIndex = 0
        }
        
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
        
        switch modeNum{
        case 0:
            switch rank {
            case 0..<1.0:
                rankLabel.textColor = UIColor.blue
                rankResault = "SSS"
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
        case 1:
            switch rank {
            case 0..<1.0:
                rankLabel.textColor = UIColor.blue
                rankLabel.text = "Super"
            case 1.0..<2.0:
                rankLabel.textColor = UIColor.purple
                rankLabel.text = "Greate!"
            case 2.0..<3.0:
                rankLabel.textColor = UIColor.orange
                rankLabel.text = "Good!"
            case 3.0..<4.0:
                rankLabel.textColor = UIColor.yellow
                rankLabel.text = "SS"
            case 4.0..<5.0:
                rankLabel.textColor = UIColor.yellow
                rankLabel.text = "S"
            case 5.0..<5.5:
                rankLabel.textColor = UIColor.yellow
                rankLabel.text = "A"
            case 5.5..<6.0:
                rankLabel.textColor = UIColor.red
                rankLabel.text = "B"
            case 6.0..<6.5:
                rankLabel.textColor = UIColor.red
                rankLabel.text = "C"
            case 6.5..<7.0:
                rankLabel.textColor = UIColor.red
                rankLabel.text = "D"
            case 7.0..<7.5:
                rankLabel.textColor = UIColor.magenta
                rankLabel.text = "E"
                
            default:
                rankLabel.textColor = UIColor.black
                rankLabel.text = "Z"
                
            }
        case 2:
            switch rank {
            case 0..<2.0:
                rankLabel.textColor = UIColor.blue
                rankLabel.text = "SSS"
            case 2.0..<3.0:
                rankLabel.textColor = UIColor.purple
                rankLabel.text = "SS"
            case 3.0..<4.0:
                rankLabel.textColor = UIColor.orange
                rankLabel.text = "S"
            case 4.0..<5.0:
                rankLabel.textColor = UIColor.yellow
                rankLabel.text = "A"
            case 5.0..<6.0:
                rankLabel.textColor = UIColor.yellow
                rankLabel.text = "B"
            case 6.0..<7.0:
                rankLabel.textColor = UIColor.yellow
                rankLabel.text = "C"
            case 7.0..<8.0:
                rankLabel.textColor = UIColor.red
                rankLabel.text = "D"
            case 8.0..<9.0:
                rankLabel.textColor = UIColor.red
                rankLabel.text = "E"
            case 10..<11:
                rankLabel.textColor = UIColor.red
                rankLabel.text = "F"
            case 11..<12:
                rankLabel.textColor = UIColor.magenta
                rankLabel.text = "G"
                
            default:
                rankLabel.textColor = UIColor.black
                rankLabel.text = "Z"
            }
        default:
            break
        }
       
        rankLabel.text = rankResault
    }


    
    @IBAction func backButton(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "toBack1", sender: nil)
        
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
extension ViewController: LTMorphingLabelDelegate {
    
    func morphingDidStart(_ label: LTMorphingLabel) {
        print("morphingDidStart")
    }
    
    func morphingDidComplete(_ label: LTMorphingLabel) {
        print("morphingDidComplete")
    }
    
    func morphingOnProgress(_ label: LTMorphingLabel, progress: Float) {
        print("morphingOnProgress", progress)
    }
}


