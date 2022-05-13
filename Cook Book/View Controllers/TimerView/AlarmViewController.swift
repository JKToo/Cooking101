//
//  AlarmViewController.swift
//  Cook Book
//
//  Created by Justin on 4/30/22.
//


//https://codewithchris.com/avaudioplayer-tutorial/

import UIKit
import AVFoundation

class AlarmViewController: UIViewController {

  
    @IBOutlet weak var btn: UIButton!
    var player = AVAudioPlayer()
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playMusic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let backgroundColor = UserDefaults.standard.bool(forKey: "themeKey")
            if(backgroundColor){
                self.view.backgroundColor = UIColor.white
                btn.backgroundColor = UIColor.appColor(.blue)
                textLabel.textColor = UIColor.black
            } else {
                self.view.backgroundColor = UIColor.black
                btn.backgroundColor = UIColor.appColor(.blue)
                textLabel.textColor = UIColor.white
            }
    }

    //https://developer.apple.com/forums/thread/71801
    @IBAction func btnPressed(_ sender: Any) {
        dismiss (animated: true, completion: nil)
    }
    
    
    func playMusic(){
        let soundURL = Bundle.main.url(forResource: "sound", withExtension: "mp3")
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL!)
            
        } catch {
            print("Error playing sound file")
        }
        player.play()
    }

}
