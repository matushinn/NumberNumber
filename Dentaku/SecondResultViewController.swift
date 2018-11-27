//
//  ResultViewController.swift
//  Dentaku
//
//  Created by 大江祥太郎 on 2018/11/08.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import Social
import AVFoundation
import LTMorphingLabel


class SecondResultViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    
   
    @IBOutlet weak var lastScoreLabel: LTMorphingLabel!
    
   
    @IBOutlet weak var lastScoreTextLabel : LTMorphingLabel!
    
    
    @IBOutlet weak var rankLabel: LTMorphingLabel!
    
    @IBOutlet weak var shareTextLabel: LTMorphingLabel!
    
    
    var timerArray = [Double]()
    var highTimerArray = [Double]()
    var secondQuestionNumArray = [Int]()
    var lastTime:Double = 0.0
    var highTime:Double = 0.0
    
    var rank:Double = 0
    var rankResault:String!
    var effectTimer:Timer?
    
    var timeIndex:Int = 0
    var shareIndex:Int = 0
    
    
    let ud = UserDefaults.standard
    
    var shareText = ["share!!","share share!!","share share share!!"]
    var timeText = ["Last Time","Time"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let filePath = Bundle.main.path(forResource: "goal",ofType: "mp3")
            let musicPath = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: musicPath)
            
        } catch {
            print("error")
        }
        audioPlayer.play()
        
        //LTMorphing
        rankLabel.morphingEffect = .burn
        shareTextLabel.morphingEffect = .fall
        lastScoreTextLabel.morphingEffect = .sparkle
        lastScoreLabel.morphingEffect = .sparkle
        shareTextLabel.morphingEffect = .pixelate
    
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
        if UserDefaults.standard.object(forKey: "secondQuestionsNum") != nil{
            secondQuestionNumArray = ud.object(forKey: "secondQuestionsNum") as! [Int]
            
            rankCheck()
            ud.removeObject(forKey: "secondQuestionsNum")
            
            /*    問題と解答を削除したので、キーが"questions"のオブジェクトの値がnilになる
             *  -> 読み込まれたときのエラーを回避するために値に空の配列を入れておく
             */
            ud.set([], forKey: "secondQuestionsNum")
        }
    }
    
    
   
    func rankCheck(){
        rank = lastTime/Double(secondQuestionNumArray[0])
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
    }
    @IBAction func backButton(_ sender: Any) {
       
        self.performSegue(withIdentifier: "toBack2", sender: nil)
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

