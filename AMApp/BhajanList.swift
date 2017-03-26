//
//  AudioList.swift
//  TestTableView
//
//  Created by Vicky Rana on 3/9/17.
//  Copyright © 2017 Vicky Rana. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AVFoundation

var player1 = AVAudioPlayer()


struct audio {
    var audioURL = String()
    var titl = String()
    var catid = String()
    var audioID = String()
    var duration = String()
    
}

class BhajanList: UITableViewController {
    
    var mainCatid = String()
    var catName = String()
    var image23 = UIImage()
    
    var AudioList = [audio]()
    
    var sameAudioURL = "http://anoopam.org//api/ams/v2/fetch_images.php?feature=audio"
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
            if let items = readableJSON["audios"] as? [JSONStandard]{
                for item in items {
                    
                    //  print(item)
                    // print(mainCatid+catName)
                    
                    let  catID = item["catID"] as! String
                    
                    //print(catID)
                    //print("Main Catid"+mainCatid)
                    
                    if catID == mainCatid
                    {
                        print("***")
                        let audioid = item["audioID"] as! String
                        
                        let audiotitle = item["audioTitle"] as! String
                        
                        let audiourl = item["audioURL"] as! String
                        
                        let duration = item["duration"] as! String
                        
                        
                        AudioList.append(audio.init(audioURL: audiourl, titl: audiotitle, catid: catID, audioID: audioid, duration: duration))
                        
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
        callAlamor(url: sameAudioURL)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AudioList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let audiocell =  tableView.dequeueReusableCell(withIdentifier: "BhajanList")
        
        audiocell?.textLabel?.text = AudioList[indexPath.row].titl
        return audiocell!
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //   let selectedRow = self.tableView.indexPathForSelectedRow!.row
        
        // let Audiosegue = segue.destination as? AudioList
        
        
        let selectedAudio = self.tableView.indexPathForSelectedRow!.row
        
        let playAudio = segue.destination as? PlayAudio
        
        playAudio?.audiotitle = AudioList[selectedAudio].titl
        playAudio?.audiourl = AudioList[selectedAudio].audioURL
        playAudio?.audioimage = self.image23
        
        //Audiosegue?.catid = Audio[selectedRow].catID
        
        
    }
    
    
}
