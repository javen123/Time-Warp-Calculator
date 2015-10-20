//
//  ViewController.swift
//  Time_Warp_Calculator
//
//  Created by Jim Aven on 10/20/15.
//  Copyright © 2015 Jim Aven. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var curOperation:Operation = .Empty
    
    var btnSound:AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        }
        catch let err as NSError {
            print(err.localizedDescription)
        }
    }
    
    @IBAction func numberPressed (btn:UIButton!) {
        
        playSound()
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func btnDividePressed(sender: UIButton) {
        processOperation(.Divide)
    }
    
    @IBAction func btnMultiplyPressed(sender: UIButton) {
        processOperation(.Multiply)
    }
    
    @IBAction func btnSubtractPressed(sender: UIButton) {
        processOperation(.Subtract)
    }
    
    @IBAction func btnAddPressed(sender: AnyObject) {
        processOperation(.Add)
    }
    
    @IBAction func btnEqualPressed(sender: AnyObject) {
        processOperation(curOperation)
    }
    
    func processOperation (op:Operation) {
        
        playSound()
       
        
        if curOperation != .Empty {
            
            if runningNumber != "" {
               rightValStr = runningNumber
                runningNumber = ""
                
                switch curOperation {
                case .Multiply:
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                case .Divide:
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                case .Add:
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                default:
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
            
                leftValStr = result
                outputLabel.text = result 
            }
            
            curOperation = op
        }
        else {
            //first time its pressed
            leftValStr = runningNumber
            runningNumber = ""
            curOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.play()
        }
        btnSound.play()
    }

}

