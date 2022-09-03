//
//  dataTableViewCell.swift
//  PrayerTimeApp
//
//  Created by Ruba on 06/02/1444 AH.
//

import UIKit
import AVFoundation

class dataTableViewCell: UITableViewCell {

    var player:AVAudioPlayer?
    
    @IBOutlet weak var speaker: UIButton!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func speakerAct(_ sender: Any) {
        if let player = player, player.isPlaying{
            speaker.setTitle("Play", for: .normal)
            player.stop()
            
        }else{
            speaker.setTitle("Stop", for: .normal)
            let urlSting = Bundle.main.path(forResource: "audio", ofType: "mp3")
            
            do{
    try AVAudioSession.sharedInstance().setMode(.default)
    try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlSting = urlSting else{
                    return
                }
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlSting))
                guard let player = player else{
                    return
                }
                player.play()
            }catch{
                print("something went wrong")
            }
        }
    }
}
