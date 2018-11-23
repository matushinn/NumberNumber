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

class ThirdViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    @IBOutlet weak var leftLabel: LTMorphingLabel!
    
    @IBOutlet weak var rightLabel: LTMorphingLabel!
    
    @IBOutlet weak var calcLabel: LTMorphingLabel!
    
    @IBOutlet weak var answerLabel: LTMorphingLabel!
    
    @IBOutlet weak var timerLabel: LTMorphingLabel!
    
    @IBOutlet weak var questionNumLabel: LTMorphingLabel!
    
    
    @IBOutlet weak var maruImageView: UIImageView!
    
    @IBOutlet weak var batsuImageView: UIImageView!
    
    @IBOutlet weak var questions10ButtonLabel: UIButton!
    
    @IBOutlet weak var questions20ButtonLabel: UIButton!
    
    @IBOutlet weak var questions30ButtonLabel: UIButton!
    
    @IBOutlet weak var randomQuestionsButtonLabel: UIButton!
    
    @IBOutlet weak var explanationLabel: LTMorphingLabel!
    
    var calc:[String] = ["+","-","×"]
    
    var questionNum :Int = 1
    
    var result:Int = 0
    
    var leftNumber :Int = 0
    var rightNumber :Int = 0
    
    var answer:Int = 0
    
    var timer:Timer!
    //  timer保存する配列
    var thirdTimerArray = [Double]()
    var count:Double = 0.0
    var thirdQuestionsNumArray = [Int]()
    
    //Button識別のためのカウント
    var count10:Int=0
    var count20:Int = 0
    var count30:Int=0
    var randomCount:Int = 0
    @IBOutlet weak var noteTextViewLabel: UITextView!
    
    @IBOutlet weak var noteViewLabel: UIView!
    
    

    func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
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
        //1~9までの数字
        leftNumber=Int(arc4random(lower: 10, upper: 100))
        rightNumber=Int(arc4random(lower: 10, upper: 100))
        
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
            //正解
            vibrate()
            //正解音
            AudioServicesPlayAlertSound(1025)
             UIView.animate(withDuration: 0.7, animations: {
             self.maruImageView.alpha = 1
             }, completion: { finished in
             self.maruImageView.alpha = 0
             })
            showQuestion()
            questionNum += 1
            questionNumLabel.text = String(questionNum)
            //buttonによる識別
            if count10 == 1{
                if questionNum == 8{
                    questionNumLabel.textColor = UIColor.yellow
                }
                if questionNum == 9{
                    questionNumLabel.textColor = UIColor.blue
                }
                if questionNum == 10{
                    questionNumLabel.textColor = UIColor.red
                }
                if questionNum == 11{
                    screenTransition()
                }
            }
            if count20 == 1{
                if questionNum == 18{
                    questionNumLabel.textColor = UIColor.yellow
                }
                if questionNum == 19{
                    questionNumLabel.textColor = UIColor.blue
                }
                if questionNum == 20{
                    questionNumLabel.textColor = UIColor.red
                }
                if questionNum == 21{
                    screenTransition()
                }
            }
            if count30 == 1{
                if questionNum == 28{
                    questionNumLabel.textColor = UIColor.yellow
                }
                if questionNum == 29{
                    questionNumLabel.textColor = UIColor.blue
                }
                if questionNum == 30{
                    questionNumLabel.textColor = UIColor.red
                }
                if questionNum == 31{
                    screenTransition()
                }
            }
            if randomCount == 1{
                if questionNum == 25{
                    screenTransition()
                }
            }
            
            
           
        }else{
            //不正解
            vibrate()
            //不正解音
            AudioServicesPlayAlertSound(1006)
             UIView.animate(withDuration: 0.7, animations: {
             self.batsuImageView.alpha = 1
             }, completion: { finished in
             self.batsuImageView.alpha = 0
             })
            
            
        }
        
        answer = 0
        answerLabel.text = "0"
    }
    //画面遷移
    func screenTransition(){
        timer.invalidate()
        print(questionNum)
        //textFieldで記入されたテキストを入れる
        thirdTimerArray.append(Double(timerLabel.text!)!)
        
        thirdQuestionsNumArray.append(Int(questionNumLabel.text!)!)
        
        //キー値"array"で配列の保存
        UserDefaults.standard.set(thirdTimerArray, forKey: "lastScore")
        UserDefaults.standard.set(thirdQuestionsNumArray, forKey: "thirdQuestionsNum")
        
        self.performSegue(withIdentifier: "toThirdResult", sender: nil)
        
        audioPlayer.stop()
        
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
        if answerLabel.text == "0"{
            answer = 1
        }
        if answerLabel.text != "0" && answerLabel.text != "-" && answer > 0{
            answer = 10*answer + 1
        }
        if answerLabel.text == "-"{
            answer = -1
        }
        if answerLabel.text != "-" && answer < 0 {
            answer = 10*answer - 1
        }
        
        answerLabel.text = String(answer)
        
    }
    
    @IBAction func twoButton(_ sender: Any) {
        if answerLabel.text == "0"{
            answer = 2
        }
        if answerLabel.text != "0" && answerLabel.text != "-" && answer > 0{
            answer = 10*answer + 2
        }
        if answerLabel.text == "-"{
            answer = -2
        }
        if answerLabel.text != "-" && answer < 0 {
            answer = 10*answer - 2
        }
        
        answerLabel.text = String(answer)
        
    }
    
    @IBAction func threeButton(_ sender: Any) {
        if answerLabel.text == "0"{
            answer = 3
        }
        if answerLabel.text != "0" && answerLabel.text != "-" && answer > 0{
            answer = 10*answer + 3
        }
        if answerLabel.text == "-"{
            answer = -3
        }
        if answerLabel.text != "-" && answer < 0 {
            answer = 10*answer - 3
        }
        
        answerLabel.text = String(answer)
        
    }
    @IBAction func fourButton(_ sender: Any) {
        if answerLabel.text == "0"{
            answer = 4
        }
        if answerLabel.text != "0" && answerLabel.text != "-" && answer > 0{
            answer = 10*answer + 4
        }
        if answerLabel.text == "-"{
            answer = -4
        }
        if answerLabel.text != "-" && answer < 0 {
            answer = 10*answer - 4
        }
        
        answerLabel.text = String(answer)
        
    }
    
    @IBAction func fiveButton(_ sender: Any) {
        if answerLabel.text == "0"{
            answer = 5
        }
        if answerLabel.text != "0" && answerLabel.text != "-" && answer > 0{
            answer = 10*answer + 5
        }
        if answerLabel.text == "-"{
            answer = -5
        }
        if answerLabel.text != "-" && answer < 0 {
            answer = 10*answer - 5
        }
        
        answerLabel.text = String(answer)
        
    }
    @IBAction func sixButton(_ sender: Any) {
        
        
        if answerLabel.text == "0"{
            answer = 6
        }
        if answerLabel.text != "0" && answerLabel.text != "-" && answer > 0{
            answer = 10*answer + 6
        }
        if answerLabel.text == "-"{
            answer = -6
        }
        if answerLabel.text != "-" && answer < 0 {
            answer = 10*answer - 6
        }
        
        answerLabel.text = String(answer)
        
    }
    
    @IBAction func sevenButton(_ sender: Any) {
        
        if answerLabel.text == "0"{
            answer = 7
        }
        if answerLabel.text != "0" && answerLabel.text != "-" && answer > 0{
            answer = 10*answer + 7
        }
        if answerLabel.text == "-"{
            answer = -7
        }
        if answerLabel.text != "-" && answer < 0 {
            answer = 10*answer - 7
        }
        
        answerLabel.text = String(answer)
        
    }
    
    @IBAction func eightButton(_ sender: Any) {
        if answerLabel.text == "0"{
            answer = 8
        }
        if answerLabel.text != "0" && answerLabel.text != "-" && answer > 0{
            answer = 10*answer + 8
        }
        if answerLabel.text == "-"{
            answer = -8
        }
        if answerLabel.text != "-" && answer < 0 {
            answer = 10*answer - 8
        }
        
        answerLabel.text = String(answer)
    }
    
    
    @IBAction func nineButton(_ sender: Any) {
        
        if answerLabel.text == "0"{
            answer = 9
        }
        if answerLabel.text != "0" && answerLabel.text != "-" && answer > 0{
            answer = 10*answer + 9
        }
        if answerLabel.text == "-"{
            answer = -9
        }
        if answerLabel.text != "-" && answer < 0 {
            answer = 10*answer - 9
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
            let filePath = Bundle.main.path(forResource: "sentou",ofType: "mp3")
            let musicPath = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: musicPath)
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
        explanationLabel.morphingEffect = .pixelate
        
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(FirstViewController.update), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func questions10Button(_ sender: Any) {
        buttonProcessing()
        count10 += 1
    }
    @IBAction func questions20Button(_ sender: Any) {
        buttonProcessing()
        count20 += 1
    }
    @IBAction func questions30Button(_ sender: Any) {
        buttonProcessing()
        count30 += 1
    }
    
    @IBAction func randomQuestionsButton(_ sender: Any) {
        buttonProcessing()
        randomCount += 1
    }
    //Button処理の関数
    func buttonProcessing(){
        noteViewLabel.alpha=0.0
        noteTextViewLabel.alpha=0.0
        questions10ButtonLabel.isHidden = true
        questions20ButtonLabel.isHidden = true
        questions30ButtonLabel.isHidden = true
        randomQuestionsButtonLabel.isHidden = true
        startTimer()
        
        audioPlayer.play()
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        audioPlayer.stop()
    }
    
    //    timer
    @objc func update(){
        count = count + 0.1
        timerLabel.text = String(format: "%.1f", count)
        
    }
    
}
