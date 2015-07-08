//
//  ViewController.swift
//  TapInOrder
//
//  Created by School on 6/26/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit

import Darwin

class ViewController: UIViewController {
    
    var buttonState = [Bool]()
    var buttonList = [UIButton]()
    //var places:[(Int,Int)] = [(100, 200), (450, 250), (350, 450), (600, 400), (800, 150), (700, 600), (850, 500), (200, 300), (100, 550), (300, 600)]
    var places:[(Int,Int)] = [(100, 200), (450, 250), (350, 450)]
    var order = [Int]()
    
    var currpressed = 0
    
    //var imageView = UIImageView()
    @IBAction func Reset(sender: AnyObject) {
        randomizeOrder()
        drawsequence()
        currpressed = 0
    }
    
    func randomizeOrder() {
        order = [Int]()
        
        var array = [Int]()
        for i in 0...places.count-1 {
          array.append(i)
        }

        for var k=places.count-1; k>=0; --k{
            var random = Int(arc4random_uniform(UInt32(k)))
            order.append(array[random])
            array.removeAtIndex(random)
        }
        
        println("order is \(order)")

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        randomizeOrder()
        
        
        for (index, i) in enumerate(order) {
            let(a,b) = places[i]
            
            var x : CGFloat = CGFloat(a)
            var y : CGFloat = CGFloat(b)
            
            let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            buttonList.append(button)
            button.frame = CGRectMake(x, y, 50, 50)
            button.backgroundColor = UIColor.redColor()
            //button.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
            //button.setTitle(names[i], forState: UIControlState.Normal)
            
            /*
            button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            */
            self.view.addSubview(button)
            
            println("do stuff")
            
            /*
            
            UNCOMMENT FOR TIMER
            
            var timer = NSTimer()
            
            let aSelector : Selector = "update"
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            
            startTime = NSDate.timeIntervalSinceReferenceDate()
            */
            
            
            /*
            let imageSize = CGSize(width: 50, height: 50)
            imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 100, y: 100), size: imageSize))
            self.view.addSubview(imageView)
            let image = drawBox(imageSize)
            imageView.image = image
            */
            
            /*
            path = UIBezierPath(rect: CGRect(x: 100, y:100, width: 50, height: 50))
            UIColor.redColor().setFill()
            path.fill()
            */
            
            
            buttonState.append(false)
            
        }
        
        drawsequence()
    }
    
    
    func drawsequence() {
        
        for (index, i) in enumerate(order) {
            println("Setting \(index) to button \(i)")
            
            var delayTime:Double = Double(2+(2*index))
            
            delay(delayTime){
                self.buttonList[i].backgroundColor = UIColor.greenColor()
            }
            delay(delayTime+2){
                self.buttonList[i].backgroundColor = UIColor.redColor()
            }
            
            buttonList[i].removeTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            delay(2*Double(order.count)) {
                self.buttonList[i].addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
        
    }
    
    func selectionDone(n:Int, status:Bool) {
        for (index, i) in enumerate(order) {
            buttonList[i].removeTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        println("Done in \(n)! \(status)")
    }
    
    func buttonAction(sender:UIButton!)
    {
        println("Button tapped")
        for i in 0...buttonList.count-1 {
            if sender == buttonList[i] {
                println("In button \(i)")
                
                if order[i] != currpressed {
                    println("Problem \(i) is not \(order[i])")
                    selectionDone(i, status:false)
                } else if(currpressed == buttonList.count-1){
                    selectionDone(i, status:true)
                }
                currpressed = currpressed + 1
                
                sender.backgroundColor = UIColor.blackColor()
               
                delay(1) {
                    sender.backgroundColor = UIColor.redColor()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }    /*
    func drawBox(size:CGSize) -> UIImage {
        
        let bounds = CGRect(origin: CGPoint.zeroPoint, size: size)
        let opaque = false
        let scale: CGFloat = 0
        
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        //CGContextSetLineWidth(context, 2.0)
        
        CGContextFillRect(context, bounds)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
        
    }
*/
    
    let delayconst = 5.0
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)/delayconst)), dispatch_get_main_queue(), closure)
        
        
    }

}

