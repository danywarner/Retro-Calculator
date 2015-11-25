//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Daniel Warner on 11/24/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
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
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
        
    }
    
    @IBAction func onPlusPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        if(currentOperation != Operation.Empty) {
            
            if(runningNumber != ""){
                rightValStr = runningNumber
                runningNumber = ""
            
                switch currentOperation {
                    case Operation.Multiply:
                        result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    case Operation.Divide:
                        result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    case Operation.Subtract:
                        result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    case Operation.Add:
                        result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    default:
                        break
                }
                
                
                leftValStr = result
                outputLbl.text = result
            
                
            }
            currentOperation = op
            
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if(btnSound.playing) {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    

}

