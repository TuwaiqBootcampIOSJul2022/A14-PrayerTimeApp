//
//  PrayerTableViewCell.swift
//  Prayer
//
//  Created by REOF ALMESHARI on 03/09/2022.
//

import UIKit

class PrayerTableViewCell: UITableViewCell {
    @IBOutlet weak var eishaLabel: UILabel!
    @IBOutlet weak var magribLabel: UILabel!
    @IBOutlet weak var asarLabel: UILabel!
    @IBOutlet weak var dhuhorLabel: UILabel!
    @IBOutlet weak var fajrLabel: UILabel!
    @IBOutlet weak var prayerLabel: UILabel!
    @IBOutlet weak var dateMonthLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
