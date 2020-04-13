//
//  MusicPlayer.swift
//  AppleDev-MC1
//
//  Created by Andrew Novansky Ignatius on 09/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayer: UIViewController {

    var player:AVAudioPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            let audioPath = Bundle.main.path(forResource: "Song", ofType: ".mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch{
            //ERROR
        }
        
        player.play()
        player.numberOfLoops = -1
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
