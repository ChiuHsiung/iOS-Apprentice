//
//  ViewController.swift
//  BullsEye_SW
//
//  Created by zhuangqiuxiong on 16/3/13.
//  Copyright © 2016年 zhuangqiuxiong. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController, UIAlertViewDelegate {
    
    var curSliderValue: Int = 50
    var targetValue: Int = 1{
        
        didSet{
            self.targetLabel.text = String(self.targetValue)
        }
        
    }
    var score: Int = 0
    
    var round: Int = 0{
        
        didSet{
            self.roundLabel.text = String(self.round)
        }
    }
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initSliderView()
        
        startNewGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSliderView(){
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        self.slider.setThumbImage(thumbImageNormal, forState: .Normal)
        self.slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        if let trackLeftImage = UIImage(named: "SliderTrackLeft")
        {
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight")
        {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
    }

    @IBAction func showAlert(sender: AnyObject) {
        
        let diff: Int = curSliderValue > targetValue ? (curSliderValue - targetValue) : (targetValue - curSliderValue)
        
        var points = 100 - diff
        
        let title: String
        
        if diff == 0
        {
            title = "Perfect!"
            points += 10
        }
        else if diff < 5
        {
            
            title = "You almost had it!"
            points += 5
            
        }
        else if diff < 10
        {
            title = "Pretty good!"
            
        } else
        {
            
            title = "Not even close..."
            
        }
        
        score += points

        let msg : String = "You scored \(points) points"
        
        let alert = UIAlertView(title: title, message: msg, delegate: self, cancelButtonTitle: "OK")
        
        alert.show()
    
    }

    @IBAction func sliderMoved(sender: UISlider) {
        
        curSliderValue = Int(sender.value)
        
    }
    
    func startNewRound() {
        
        targetValue = 1 + Int(arc4random() % 100)
        curSliderValue = 50
        self.slider.value = Float(curSliderValue)
        self.scoreLabel.text = String(self.score)
        round += 1
        
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
    
        if buttonIndex == 0{
            startNewRound()
        }
    
    }
    
    @IBAction func startNewGame() {
            
        score = 0
        round = 0
            
        startNewRound()
        
        //Animation
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: "animation")
        
    }
}

