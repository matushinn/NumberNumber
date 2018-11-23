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
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var lastScoreLabel: UILabel!
    
    @IBOutlet weak var highScoreTextLabel: UILabel!
    
    @IBOutlet weak var lastScoreTextLabel: UILabel!
    
    @IBOutlet weak var rankLabel: LTMorphingLabel!
    
    
    var timerArray = [Double]()
    var highTimerArray = [Double]()
    var firstQuestionNumArray = [Int]()
    var lastScore:Double = 0.0
    var highScore:Double = 0.0
    
    var rank:Double = 0
    
    var effectTimer:Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LTMorphing
        rankLabel.morphingEffect = .burn
        
        do {
            let filePath = Bundle.main.path(forResource: "goal",ofType: "mp3")
            let musicPath = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: musicPath)
            
        } catch {
            print("error")
        }
        audioPlayer.play()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //lastScoreというキー値で保存された、配列timerArrayを取り出す
        if UserDefaults.standard.object(forKey: "lastScore") != nil{
            timerArray = UserDefaults.standard.object(forKey: "lastScore") as! [Double]
            if UserDefaults.standard.object(forKey: "highScore") != nil{
                //highScoreあったら
                highTimerArray = UserDefaults.standard.object(forKey: "highScore") as! [Double]
                //print(highTimerArray)
                print(highScore)
               checkHighScore()
                
            }else{
                //highScoreなかったら
                highScore = 0.0
                
               checkHighScore()
            
            }
            rankQuestion()
        }
    }
    //hightimeCheck
    @objc func checkHighScore(){
        lastScore = timerArray[0]
        lastScoreTextLabel.text = String(lastScore)
        //print(highTimerArray)
        //print(highTimerArray[0])
        
        //                highScore = highTimerArray[0]
        
        
        if highScore != 0.0{
            //2回目以降
            if highScore > lastScore{
                highScore = lastScore
            }else{
                print(highScore)
                highScoreTextLabel.text = String(highScore)
                
            }
        }else{
            
            //highScore=0 -> 最初
            highScore = lastScore
            highScoreTextLabel.text = String(highScore)
        }
        
       // highScoreTextLabel.text = String(highScore)
        
        //textFieldで記入されたテキストを入れる
        highTimerArray.append(Double(highScore))
        
        //キー値"array"で配列の保存
        UserDefaults.standard.set(highTimerArray, forKey: "highScore")
        
        
    }
        
        //rankを計算する
        

    func rankQuestion(){
        if UserDefaults.standard.object(forKey: "firstQuestionsNum") != nil{
            firstQuestionNumArray = UserDefaults.standard.object(forKey: "firstQuestionsNum") as! [Int]
           
            rankCheck()
        UserDefaults.standard.removeObject(forKey: "firstQuestionsNum")
        
        /*    問題と解答を削除したので、キーが"questions"のオブジェクトの値がnilになる
         *  -> 読み込まれたときのエラーを回避するために値に空の配列を入れておく
         */
        UserDefaults.standard.set([], forKey: "firstQuestionsNum")
    }
    }
    func rankCheck(){
        rank = lastScore/Double(firstQuestionNumArray[0])
        switch rank {
        case 0..<1.0:
            rankLabel.textColor = UIColor.blue
            rankLabel.text = "Super"
        case 1.0..<1.5:
            rankLabel.textColor = UIColor.purple
            rankLabel.text = "Greate!"
        case 1.5..<1.8:
            rankLabel.textColor = UIColor.orange
            rankLabel.text = "Good!"
        case 1.8..<2.0:
            rankLabel.textColor = UIColor.yellow
            rankLabel.text = "SS"
        case 2.0..<2.3:
            rankLabel.textColor = UIColor.yellow
            rankLabel.text = "S"
        case 2.3..<2.5:
            rankLabel.textColor = UIColor.yellow
            rankLabel.text = "A"
        case 2.5..<2.8:
            rankLabel.textColor = UIColor.red
            rankLabel.text = "B"
        case 2.8..<3.0:
            rankLabel.textColor = UIColor.red
            rankLabel.text = "C"
        case 3.0..<3.3:
            rankLabel.textColor = UIColor.red
            rankLabel.text = "D"
        case 3.3..<3.5:
            rankLabel.textColor = UIColor.magenta
            rankLabel.text = "E"
            
        default:
            rankLabel.textColor = UIColor.black
            rankLabel.text = "Z"
            
        }
    }
    
    
    @IBAction func backButton(_ sender: Any) {
         self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
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
