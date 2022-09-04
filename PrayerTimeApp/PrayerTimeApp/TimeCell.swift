//
//  TimeCell.swift
//  PrayerTimeApp
//
//  Created by Rashed Shrahili on 07/02/1444 AH.
//

import UIKit

class TimeCell: UITableViewCell {
    
    @IBOutlet weak var fajrPrayTime: UILabel!
    
    @IBOutlet weak var dhuhrPrayTime: UILabel!
    
    @IBOutlet weak var asirPrayTime: UILabel!
    
    @IBOutlet weak var maghrubPrayTime: UILabel!
    
    @IBOutlet weak var eshaPrayTime: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
