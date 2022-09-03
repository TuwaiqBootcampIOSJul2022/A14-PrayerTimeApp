//
//  SecondTableViewCell.swift
//  PrayerTimeApp
//
//  Created by AlenaziHazal on 07/02/1444 AH.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    @IBOutlet weak var alfajertime: UILabel!
    @IBOutlet weak var aldaherTime: UILabel!
    
    @IBOutlet weak var alashaTime: UILabel!
    @IBOutlet weak var almagribTime: UILabel!
    @IBOutlet weak var alasirTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
