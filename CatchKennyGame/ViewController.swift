//
//  ViewController.swift
//  CatchKennyGame
//
//  Created by Furkan Dölek on 20.03.2020.
//  Copyright © 2020 Furkan Dölek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView] ()
    var hiddenTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score :\(score)"
        //HighScore Checked
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        //Images
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        image7.isUserInteractionEnabled = true
        image8.isUserInteractionEnabled = true
        image9.isUserInteractionEnabled = true
        
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gesture9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        
        
        
        image1.addGestureRecognizer(gesture1)
        image2.addGestureRecognizer(gesture2)
        image3.addGestureRecognizer(gesture3)
        image4.addGestureRecognizer(gesture4)
        image5.addGestureRecognizer(gesture5)
        image6.addGestureRecognizer(gesture6)
        image7.addGestureRecognizer(gesture7)
        image8.addGestureRecognizer(gesture8)
        image9.addGestureRecognizer(gesture9)
        kennyArray = [image1,image2,image3,image4,image5,image6,image7,image8,image9]
        
        
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hiddenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hiddenKenny), userInfo: nil, repeats: true)
        
        hiddenKenny()
        // Do any additional setup after loading the view.
    }
    @objc func hiddenKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
    @objc func increaseScore () {
        score += 1
        scoreLabel.text = "Score:\(score)"
    }
    @objc func countDown () {
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0 {
            timer.invalidate()
            hiddenTimer.invalidate()
            
            for kenny in kennyArray {
                      kenny.isHidden = true
                  }
            //HighScore
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "HighScore:\(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
            //Alert
            let alert = UIAlertController(title: "Time's Up !", message: "Do you want to play again ?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score:\(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hiddenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hiddenKenny), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}

