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
    
    var rankResult:String!
    var rank:Double = 0
    
    var effectTimer:Timer?
    var timeIndex:Int = 0
    var shareIndex:Int = 0
    
    var modeSecond:Int=0
    
    //var rankText = ["○❓△Rank","○❓△rank","○❓△RANK"]
    var scoreText = ["Last Score","Score"]
    var shareText = ["share!!","share share!!","share share share!!"]
    let ud = UserDefaults.standard
    
    //桁数を判別する変数
    var modeNum:Int!
    
    var lastQuestionNum:Int = 0
    
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
        
        lastScoreTextLabel.text = "\(lastQuestionNum) questions"
        rankCheck()
        
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
        lastScoreLabel.text = scoreText[timeIndex]
        shareTextLabel.text = shareText[shareIndex]
        
        timeIndex += 1
        if timeIndex >= scoreText.count {
            timeIndex = 0
        }
        shareIndex += 1
        if shareIndex >= shareText.count{
            shareIndex = 0
        }
        
    }
    
    
    func rankCheck(){
        
        rank = Double(modeSecond/lastQuestionNum)
        
        switch modeNum{
        case 0:
            switch rank {
            case 0..<1.0:
                rankLabel.textColor = UIColor.blue
                rankResult = "SSS"
            case 1.0..<1.5:
                rankLabel.textColor = UIColor.purple
                rankResult = "SS"
            case 1.5..<1.8:
                rankLabel.textColor = UIColor.orange
                rankResult = "S"
            case 1.8..<2.0:
                rankLabel.textColor = UIColor.yellow
                rankResult = "A"
            case 2.0..<2.3:
                rankLabel.textColor = UIColor.yellow
                rankResult = "B"
            case 2.3..<2.5:
                rankLabel.textColor = UIColor.yellow
                rankResult = "C"
            case 2.5..<2.8:
                rankLabel.textColor = UIColor.red
                rankResult = "D"
            case 2.8..<3.0:
                rankLabel.textColor = UIColor.red
                rankResult = "E"
            case 3.0..<3.3:
                rankLabel.textColor = UIColor.red
                rankResult = "F"
            case 3.3..<3.5:
                rankLabel.textColor = UIColor.magenta
                rankResult = "G"
                
            default:
                rankLabel.textColor = UIColor.magenta
                rankResult = "Z"
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
       
        rankLabel.text = rankResult
    }


    
    @IBAction func backButton(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "toBack1", sender: nil)
        
    }
    @IBAction func TweetButton(sender: UIButton) {
        
        // 共有する項目
        let shareText = "Number Number\n \(rankResult!)"
        let shareWebsite = NSURL(string: "https://itunes.apple.com/us/app/numbernumber/id1444835578?l=ja&ls=1&mt=8")!
        
        
        let activityItems = [shareText, shareWebsite] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        
        // 使用しないアクティビティタイプ
        let excludedActivityTypes = [
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.print
        ]
        
        activityVC.excludedActivityTypes = excludedActivityTypes
        
        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)

    }
    @IBAction func FacebookButton(sender: UIButton) {
        
        // 共有する項目
        let shareText = "Number Number\n \(rankResult!)"
        let shareWebsite = NSURL(string: "https://itunes.apple.com/us/app/numbernumber/id1444835578?l=ja&ls=1&mt=8")!
        
        
        let activityItems = [shareText, shareWebsite] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        
        // 使用しないアクティビティタイプ
        let excludedActivityTypes = [
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.print
        ]
        
        activityVC.excludedActivityTypes = excludedActivityTypes
        
        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)
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


