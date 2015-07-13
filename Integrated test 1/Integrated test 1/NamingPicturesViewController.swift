//
//  NamingPicturesViewController.swift
//  Integrated test 1
//
//  Created by saman on 7/12/15.
//  Copyright (c) 2015 saman. All rights reserved.
//

import UIKit

class NamingPicturesViewController: UIViewController {
    var imageName = "Comb"
    //var imageView: UIImageView!
    
    //imageView.frame = CGRectMake(0.0, 60.0, view.bounds.height-50, ((view.bounds.height-50)*3/4))
    
    
    @IBAction func correct(sender: AnyObject) {
        
    }
    
    
    
    @IBAction func Incorrect(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  var imageView = UIImageView(frame:CGRectMake(0.0, 60.0, view.bounds.height-50, ((view.bounds.height-50)*3/4)))
        
        var imageView = UIImageView(frame:CGRectMake(0.0, 100.0, view.bounds.height-50, ((view.bounds.height-50)*3/4)))
        var image = UIImage(named: imageName)
        imageView.image = image
        self.view.addSubview(imageView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }
    


}
