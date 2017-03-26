//
//  ViewController.swift
//  TestTableView
//
//  Created by Vicky Rana on 3/9/17.
//  Copyright © 2017 Vicky Rana. All rights reserved.
//

import UIKit
import Alamofire

struct posts{
    let image : UIImage
    let name : String
    let mainCat : String
    let catID : String
    
}



class AudioList: UITableViewController {
    
    var Audio = [posts]()
    
    var AudioURL = "http://anoopam.org//api/ams/v2/fetch_images.php?feature=audio"
    typealias JSONStandard = [String :AnyObject]
    
    
    func callAlamor(url : String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            
            self.parseData(JSONData: response.data!)
        })
    }
    
    func parseData(JSONData: Data) {
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData , options: .mutableContainers) as! JSONStandard
            if let items = readableJSON["categories"] as? [JSONStandard]{
                for item in items {
                    
                    let mainCatid = item["mainCatID"] as! String
                    let name = item["catName"] as! String
                    //let image = item["catImage"] as! String
                    let catID = item["catID"] as! String
                    
                    let ThakorjiURL = URL(string: item["catImage"] as! String)
                    let ThakorjiData = NSData(contentsOf: ThakorjiURL!)
                    let ThakorjiImage = UIImage(data: ThakorjiData as! Data)
                    
                    
                    if mainCatid == "0" {
                        //  print(name)
                        // print(ThakorjiURL!)
                        
                        // let imageview = UIImageView()
                        
                        //   let image = UIImage(imageview.sd_setImage(with: URL(string: image)))//,placeholderImage: UIImage(named: "Placeholder.png"))
                        
                        Audio.append(posts.init(image: ThakorjiImage!, name: name, mainCat: mainCatid, catID: catID))
                        
                        self.tableView.reloadData()
                    }
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAlamor(url: AudioURL)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Audio.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Audio")
        
        //cell?.textLabel?.text = Audio[indexPath.row].name
        
        //cell?.textLabel?.text = "New"
        
        
        let ThakorjiImageview = cell?.viewWithTag(1) as! UIImageView
        ThakorjiImageview.image = Audio[indexPath.row].image
        
        let Location = cell?.viewWithTag(2) as! UILabel
        Location.text = Audio[indexPath.row].name
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedRow = self.tableView.indexPathForSelectedRow!.row
        
        let Audiosegue = segue.destination as? BhajanList
        
        Audiosegue?.mainCatid = Audio[selectedRow].catID //not mainCatID
        //Audiosegue?.catid = Audio[selectedRow].catID
        Audiosegue?.catName = Audio[selectedRow].name
        Audiosegue?.image23 = Audio[selectedRow].image
        
        
        //ThakorjiView?.date = Thakorji[selectedRow].date
        
        
    }
    
}
