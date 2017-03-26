//
//  FirstViewController.swift
//  TestTabbedApp
//
//  Created by Vicky Rana on 3/5/17.
//  Copyright © 2017 Vicky Rana. All rights reserved.
//

import UIKit
import Alamofire


struct post{
    let image: UIImage
    let name: String
    let count: Int16
    let date: String
    let id: Int16
    let time: String
    
}

class FirstViewController: UITableViewController {
    
    var templeurl = String()
    
    var ThakorjUpdatetime = ""
    
    var Thakorji = [post]()
    
    
    typealias JSONStandard = [String :AnyObject]
    
    /*
     func fetch(_ completion: () -> Void) {
        callAlamor()
        completion()
    }
    */
    
    func callAlamor(url : String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            
            self.parseData(JSONData: response.data!)
        }).resume()
    }
    
    func parseData(JSONData: Data) {
        
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData , options: .mutableContainers) as! JSONStandard
            if let items = readableJSON["temples"] as? [JSONStandard]{
                for item in items {
                    
                    
                    let temple_name = item["templePlace"] as! String
                    
                    let ThakorjiLastUpdate = item["mainImage"] as! String
                        
                    
                    let  ThakorjiURL = URL(string: item["mainImage"] as! String)
                    let ThakorjiData = NSData(contentsOf: ThakorjiURL!)
                    let ThakorjiImage = UIImage(data: ThakorjiData as! Data)
                    
                  //  var ThakorjUpdatetime: String
                        ThakorjUpdatetime = String(ThakorjiLastUpdate.characters.suffix(10))
                    
                    let todaysDate = item["lastUpdatedTimestamp"] as! String
                    
                    let image_count = item["imageCount"] as! Int16
                    let id = item["templeID"] as! Int16
      
                 /*   if let temple_id:Int16 = (id) as? Int16
                    {
                    
                    if temple_id == 1
                    {   templeurl = "india" }
                        
                    else if temple_id == 2
                    {   templeurl = "uk"    }
                        
                    else if temple_id == 3
                    {   templeurl = "usa"   }
                        
                    else if temple_id == 4
                    {   templeurl = "kharghar" }
                        
                    else if temple_id == 5
                    {   templeurl = "surat" }
                        
                    else if temple_id == 6
                    {   templeurl = "vemar" }
                        
                    else if temple_id == 7
                    { templeurl = "amdavad" }
                
                    }
                    
                    let imageview = UIImageView()
                
              //  imageview.sd_setImage(with: URL(string: "http://anoopam.org/thakorjitoday/\(templeurl)/images/god01)L.jpg?a=\(ThakorjUpdatetime)"))//,placeholderImage: UIImage(named: "Placeholder.png"))
                
              //  imageview.sd_setImage(with: URL(string: "http://anoopam.org/thakorjitoday/\(templeurl)/images/god01)L.jpg?a=\(ThakorjUpdatetime)"))//,placeholderImage: UIImage(named: "Placeholder.png"))
                    imageview.sd_setImage(with: ThakorjiLastUpdate)
                        
                Thakorji.append(post.init(image: imageview, name: temple_name, count: image_count, date: todaysDate, id: id, time: ThakorjUpdatetime))
                */
                    
                    Thakorji.append(post.init(image: ThakorjiImage!, name: temple_name, count: image_count, date: todaysDate, id: id, time: ThakorjUpdatetime))
                    
                self.tableView.reloadData()
                }
                
                }
        }
        
            
        catch {
            print(error)
            
        }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ThakorjiTodayURL = "http://anoopam.org/api/ams/v2/thakorji.php"
        callAlamor(url: ThakorjiTodayURL)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Thakorji.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")//, for: indexPath)
        
        var ThakorjiImageview = cell?.viewWithTag(2) as! UIImageView
        ThakorjiImageview.image = Thakorji[indexPath.row].image
    
        
        //ThakorjiImageview.contentMode = .scaleAspectFit
        
        //let xPos = self.view.frame.width * CGFloat(1)
         //ThakorjiImageview.frame = CGRect(x: xPos, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
      //  ThakorjiImageview.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        // view.addSubview(ThakorjiImageview)
        
        let Location = cell?.viewWithTag(1) as! UILabel
        Location.text = Thakorji[indexPath.row].name
        
        let date = cell?.viewWithTag(3) as! UILabel
        date.text = Thakorji[indexPath.row].date
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedRow = self.tableView.indexPathForSelectedRow!.row
        
        let ThakorjiView = segue.destination as? ThakorjiImage
        
        ThakorjiView?.date = Thakorji[selectedRow].date
        ThakorjiView?.mandir = Thakorji[selectedRow].name
        ThakorjiView?.id = Thakorji[selectedRow].id
        ThakorjiView?.count = Thakorji[selectedRow].count
        ThakorjiView?.time = Thakorji[selectedRow].time
    }
    
   // override func viewWillAppear(_ animated: Bool) {
     //   tableView.estimatedRowHeight = 50
       // tableView.rowHeight = UITableViewAutomaticDimension
   // }
    
    
    
    
}

