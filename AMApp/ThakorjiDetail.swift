//
//  ThakorjiDetail.swift
//  AM_App
//
//  Created by Vicky Rana on 3/5/17.
//  Copyright © 2017 Vicky Rana. All rights reserved.
//

import Foundation
import UIKit

class ThakorjiImage: UIViewController {
    
    var mandir = String()
    var date = String()
    var id = Int16()
    var count = Int16()
    var time = String()
    
    var templeurl = String()
    
    
    
  //  var imagesURLS = [String]()
    
    @IBOutlet weak var ThakorjiImage: UIScrollView!
    @IBOutlet weak var mandirLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        
        if let templeint:Int16 = (id) as? Int16
        {
            //  var templeurl = ""
            if templeint == 1
            {   templeurl = "india" }
                
            else if templeint == 2
            {   templeurl = "uk"    }
                
            else if templeint == 3
            {   templeurl = "usa"   }
                
            else if templeint == 4
            {   templeurl = "kharghar" }
                
            else if templeint == 5
            {   templeurl = "surat" }
                
            else if templeint == 6
            {   templeurl = "vemar" }
            
            else if templeint == 7
            { templeurl = "amdavad" }
            
        }
        //mandirLabel.text = mandir
        //dateLabel.text = date

        ThakorjiImage.frame = view.frame
        
        //for i in 0..<count {
          //  imagesURLS.append("http://anoopam.org/thakorjitoday/\(id)/images/god0\(i+1)L.jpg") }
        
        for j in 0..<count {
            
            let imageview = UIImageView()
            
            imageview.sd_setImage(with: URL(string: "http://anoopam.org/thakorjitoday/\(templeurl)/images/god0\(j+1)L.jpg?a=\(time)"))//,placeholderImage: UIImage(named: "Placeholder.png"))
            

            
            imageview.contentMode = .scaleAspectFit

            let xPos = self.view.frame.width * CGFloat(j)
            imageview.frame = CGRect(x: xPos, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
            ThakorjiImage.contentSize.width = ThakorjiImage.frame.width * CGFloat(j+1)
            
            ThakorjiImage.addSubview(imageview)
        
        }
        
    }
    
    
}
