//
//  StartViewController.swift
//  Dentaku
//
//  Created by 大江祥太郎 on 2018/11/11.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import AVFoundation

class StartViewController: UIViewController {
    var timer:Timer!
     var audioPlayer:AVAudioPlayer!
   
    
    

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
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        audioPlayer.play()
    }
    @IBAction func timeAttackButton(_ sender: Any) {
        audioPlayer.stop()
        self.performSegue(withIdentifier: "toTimeAttack", sender: nil)
    }
    
    
}
