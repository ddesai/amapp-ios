//
//  AradhanaView.swift
//  AM_App
//
//  Created by Vicky Rana on 3/11/17.
//  Copyright © 2017 Vicky Rana. All rights reserved.
//

import Foundation
import UIKit

class AradhanaView: UIViewController {
    
    @IBOutlet weak var GujaratiLabel: UIButton!
    @IBOutlet weak var EnglishLabel: UIButton!
    @IBOutlet weak var AradhanaView: UIWebView!
    
    @IBAction func EnglishButton(_ sender: Any) {
        
        GujaratiLabel.isEnabled = true
        EnglishLabel.isEnabled = false
        
        var  path = NSURL(fileURLWithPath: Bundle.main.path(forResource: "aaradhana_english", ofType: "pdf")!)
        
        
        let request = NSURLRequest(url: path as URL)
        AradhanaView.loadRequest(request as URLRequest)
    }
    
    @IBAction func GujaratiButon(_ sender: Any) {
    
        GujaratiLabel.isEnabled = false
        EnglishLabel.isEnabled = true
        
        var  path = NSURL(fileURLWithPath: Bundle.main.path(forResource: "aaradhana_gujarati", ofType: "pdf")!)
        
        
        let request = NSURLRequest(url: path as URL)
        AradhanaView.loadRequest(request as URLRequest)
    }
    
    
    
    
    
    
    //var path = ""
    
    override func viewDidLoad() {
     
        //path = NSURL(fileURLWithPath: Bundle.mainBundle().pathForResource("aaradhana_gujarati", ofType:"pdf"))
       
        GujaratiLabel.isEnabled = false
        
       var  path = NSURL(fileURLWithPath: Bundle.main.path(forResource: "aaradhana_gujarati", ofType: "pdf")!)
        
        
        let request = NSURLRequest(url: path as URL)
        AradhanaView.loadRequest(request as URLRequest)
    }
    
    override func didReceiveMemoryWarning() {
        
    }
}
