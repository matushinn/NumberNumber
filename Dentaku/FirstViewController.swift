//
//  FirstViewController.swift
//  Dentaku
//
//  Created by 大江祥太郎 on 2018/10/28.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
import LTMorphingLabel

class FirstViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    
    @IBOutlet weak var leftLabel: LTMorphingLabel!
    
    @IBOutlet weak var rightLabel: LTMorphingLabel!
    
    @IBOutlet weak var calcLabel: LTMorphingLabel!
    
    @IBOutlet weak var answerLabel: LTMorphingLabel!
    
    @IBOutlet weak var timerLabel: LTMorphingLabel!
    
    @IBOutlet weak var questionNumLabel: LTMorphingLabel!
    
    
   
    @IBOutlet weak var maruImageView: UIImageView!
    
    @IBOutlet weak var batuImageView: UIImageView!
    
    
    
    var calc:[String] = ["+","-","×"]
    
    var correctNum :Int = 1
    
    var result:Int = 0
    
    var leftNumber :Int = 0
    var rightNumber :Int = 0
    
    var answer:Int = 0
    
    var timer:Timer!
    //  timer保存する配列
    var firstTimerArray = [Double]()
    var count:Double = 0.0
    
    //モードを管理する変数
    var modeNum:Int!
    
    
    var modeSecond:Int=90
   
    //何桁の問題か判別するための値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult"{
            let resultVC = segue.destination as! FirstResultViewController
            
            
            resultVC.modeNum = modeNum
            resultVC.modeSecond = modeSecond
            resultVC.lastQuestionNum = correctNum
        }
    }
    
    func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    //乱数
    func arc4random(lower: UInt32, upper: UInt32) -> UInt32 {
        guard upper >= lower else {
            return 0
        }
        
        return arc4random_uniform(upper - lower) + lower
    }
    //    問題を出す関数
    func showQuestion(){
        switch modeNum {
        case 0:
            //1~9までの数字
            leftNumber=Int(arc4random(lower: 1, upper: 10))
            rightNumber=Int(arc4random(lower: 1, upper: 10))
        case 1:
            //1~9までの数字
            leftNumber=Int(arc4random(lower: 10, upper: 100))
            rightNumber=Int(arc4random(lower: 1, upper: 10))
        case 2:
            //1~9までの数字
            leftNumber=Int(arc4random(lower: 10, upper: 100))
            rightNumber=Int(arc4random(lower: 10, upper: 100))
        default:
            break
        }
        
        leftLabel.text = String(leftNumber)
        rightLabel.text = String(rightNumber)
        
        
        let calculation = Int( arc4random_uniform(UInt32(calc.count)) )
        if calc[calculation] == "+"{
            calcLabel.textColor = UIColor.blue
        }
        if calc[calculation] == "-"{
            calcLabel.textColor = UIColor.green
        }
        if calc[calculation] == "×"{
            calcLabel.textColor = UIColor.yellow
        }
        
        calcLabel.text = calc[calculation]
        
    }
    func answerQuestion(){
        if result == answer{
            
            correctNum += 1
            questionNumLabel.text = String(correctNum)
            
            //正解
            vibrate()
            //正解音
            AudioServicesPlayAlertSound(1025)
            
            //正解アニメーション
            UIView.animate(withDuration: 0.7, animations: {
                self.maruImageView.alpha = 1.0
            }, completion: { finished in
                self.maruImageView.alpha = 0.0
            })
            
            showQuestion()
            
        }else{
            //不正解
            vibrate()
            //不正解音
            AudioServicesPlayAlertSound(1006)
            //audioPlayer.pause()
            
            UIView.animate(withDuration: 0.7, animations: {
                self.batuImageView.alpha = 1.0
            }, completion: { finished in
                self.batuImageView.alpha = 0.0
            })
            
        }
        
        answer = 0
        answerLabel.text = "0"
        
        
    }
    
    
    @IBAction func okButton(_ sender: Any) {
        if calcLabel.text == "+"{
            result = leftNumber + rightNumber
        }
        if calcLabel.text == "-"{
            result = leftNumber - rightNumber
        }
        if calcLabel.text == "×"{
            result = leftNumber * rightNumber
        }
        
        answerQuestion()
        
    }
    
    @IBAction func cButton(_ sender: Any) {
        answer = 0
        answerLabel.text = String(answer)
    }
    
    @IBAction func zeroButton(_ sender: Any) {
        if answerLabel.text != "0"{
            answer = 10*answer + 0
        }
        answerLabel.text = String(answer)
    }
    @IBAction func oneButton(_ sender: Any) {
        calcProcess(index: 1)
        
    }
    
    @IBAction func twoButton(_ sender: Any) {
       calcProcess(index: 2)
    }
    
    @IBAction func threeButton(_ sender: Any) {
       calcProcess(index: 3)
    }
    @IBAction func fourButton(_ sender: Any) {
        calcProcess(index: 4)
    }
    
    @IBAction func fiveButton(_ sender: Any) {
        calcProcess(index: 5)
    }
    @IBAction func sixButton(_ sender: Any) {
        calcProcess(index: 6)
        
    }
    
    @IBAction func sevenButton(_ sender: Any) {
        calcProcess(index: 7)
        
    }
    
    @IBAction func eightButton(_ sender: Any) {
        calcProcess(index: 8)
    }
    
    
    @IBAction func nineButton(_ sender: Any) {
        
        calcProcess(index: 9)
    }
    func calcProcess(index:Int){
        if answerLabel.text == "0"{
            answer = index
        }
        if answerLabel.text != "0" && answerLabel.text != "-" && answer > 0 {
            answer = 10*answer + index
        }
        if answerLabel.text == "-"{
            answer = -index
        }
        if answerLabel.text != "-" && answer < 0 {
            answer = 10*answer - index
        }
        
        answerLabel.text = String(answer)
    }
    
    
    @IBAction func mainasuButton(_ sender: Any) {
        answerLabel.text = "-"
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
        
        do {
            let filePath = Bundle.main.path(forResource: "hikouki",ofType: "mp3")
            let musicPath = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: musicPath)
            //roop
            audioPlayer.numberOfLoops = -1
            
        } catch {
            print("error")
        }
        //LTMorphingLabel
        leftLabel.morphingEffect = .anvil
        rightLabel.morphingEffect = .anvil
        calcLabel.morphingEffect = .anvil
        timerLabel.morphingEffect = .fall
        questionNumLabel.morphingEffect = .pixelate
        answerLabel.morphingEffect = .evaporate
        
        switch modeSecond {
        case 30:
            count = 30.0
            timerLabel.text = "30.0"
        case 60:
            count = 60.0
            timerLabel.text = "60.0"
        case 90:
            count = 90.0
            timerLabel.text = "90.0"
        case 82:
            count = 82
            timerLabel.text = "82"
        default:
            break
        }
        audioPlayer.play()
        startTimer()
        
        
    }
    
    
    
    @IBAction func cancelButton(_ sender: Any) {
        audioPlayer.stop()
        
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(FirstViewController.update), userInfo: nil, repeats: true)
    }
    
    //    timer
    @objc func update(){
        count = count - 0.1
        timerLabel.text = String(format: "%.1f", count)
        if count < 0{
            timer.invalidate()
            self.performSegue(withIdentifier: "toResult", sender: nil)
            
            audioPlayer.stop()
        }
    }
    
    
    
}
extension FirstViewController: LTMorphingLabelDelegate {
    
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

