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
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var lastScoreLabel: UILabel!
    
    @IBOutlet weak var highScoreTextLabel: UILabel!
    
    @IBOutlet weak var lastScoreTextLabel: UILabel!
    
    
    @IBOutlet weak var rankLabel: LTMorphingLabel!
    
    var timerArray = [Double]()
    var highTimerArray = [Double]()
    var secondQuestionNumArray = [Int]()
    var lastScore:Double = 0.0
    var highScore:Double = 0.0
    
    var rank:Double = 0
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //lastScoreというキー値で保存された、配列timerArrayを取り出す
        if UserDefaults.standard.object(forKey: "lastScore") != nil{
            timerArray = UserDefaults.standard.object(forKey: "lastScore") as! [Double]
            if UserDefaults.standard.object(forKey: "highScore") != nil{
                //highScoreあったら
                highTimerArray = UserDefaults.standard.object(forKey: "highScore") as! [Double]
                
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
    func checkHighScore(){
        lastScore = timerArray[0]
        lastScoreTextLabel.text = String(lastScore)
        
        //                highScore = highTimerArray[0]
        
        
        if highScore != 0.0{
            //2回目以降
            if highScore > lastScore{
                highScore = lastScore
            }
        }else{
            //highScore=0 -> 最初
            highScore = lastScore
            
        }
        highScoreTextLabel.text = String(highScore)
        
        //textFieldで記入されたテキストを入れる
        highTimerArray.append(Double(highScore))
        
        //キー値"array"で配列の保存
        UserDefaults.standard.set(highTimerArray, forKey: "highScore")
        
        
    }
    
    //rankを計算する
    
    
    func rankQuestion(){
        if UserDefaults.standard.object(forKey: "secondQuestionsNum") != nil{
            secondQuestionNumArray = UserDefaults.standard.object(forKey: "secondQuestionsNum") as! [Int]
            rank = lastScore/Double(secondQuestionNumArray[0])
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
        UserDefaults.standard.removeObject(forKey: "secondQuestionsNum")
        
        /*    問題と解答を削除したので、キーが"questions"のオブジェクトの値がnilになる
         *  -> 読み込まれたときのエラーを回避するために値に空の配列を入れておく
         */
        UserDefaults.standard.set([], forKey: "secondQuestionsNum")
    
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

