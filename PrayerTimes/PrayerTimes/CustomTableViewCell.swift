//
//  CustomTableViewCell.swift
//  PrayerTimes
//
//  Created by NosaibahMW on 07/02/1444 AH.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var prayerName: UILabel!
    
    @IBOutlet weak var prayerImage: UIImageView!
    
    @IBOutlet weak var prayerTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
