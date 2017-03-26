//
//  PlayAudio.swift
//  TestTableView
//
//  Created by Vicky Rana on 3/10/17.
//  Copyright © 2017 Vicky Rana. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PlayAudio: UIViewController {
    
    
    
    var audiotitle = String()
    var audiourl = String()
    var audioimage = UIImage()
   
    @IBOutlet weak var smallBhajanImage: UIImageView!
    
    
    @IBOutlet weak var bigBhajanImage: UIImageView!
    
    @IBOutlet weak var bhajanLabel: UILabel!
    @IBOutlet weak var PlayPauseLabel: UIButton!
    
    
    @IBOutlet weak var playpauselabel: UIButton!
    @IBAction func restartButton(_ sender: Any) {
        player1.currentTime = 0
        player1.play()
        
    }
    @IBAction func StopButton(_ sender: Any) {
        player1.stop()
    }
    @IBAction func PlayPauseButton(_ sender: Any) {
        
        if player1.isPlaying {
            player1.pause()
            playpauselabel.setTitle("Play", for: .normal)
        }
        
        else {
            player1.play()
            playpauselabel.setTitle("Pause", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        download(url: URL(string:audiourl)!)
        
        smallBhajanImage.image = audioimage
        bigBhajanImage.image = audioimage
        bhajanLabel.text = audiotitle
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func play(url: URL){
        
        do {
            player1 = try AVAudioPlayer(contentsOf: url)
            player1.prepareToPlay()
            player1.play()
            
            var audioSesssion = AVAudioSession.sharedInstance()
            do {
                try audioSesssion.setCategory(AVAudioSessionCategoryPlayback)
            }
            catch {
                print(error)
            }
            //player1.play()
        }
        catch {
            print(error)
        }
        
    }
    
    func download(url: URL) {
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: {
            customeURL, response, error  in
            self.play(url: customeURL!)
            
            
        })
        
        downloadTask.resume()
    }
    
    
    
    
}
