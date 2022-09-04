//
//  PrayerTimeTableViewCell.swift
//  PrayerTimeApp
//
//  Created by Maan Abdullah on 02/09/2022.
//

import UIKit

class PrayerTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fajerLabel: UILabel!
    @IBOutlet weak var duherLabel: UILabel!
    @IBOutlet weak var asrLabel: UILabel!
    @IBOutlet weak var maghribLabel: UILabel!
    @IBOutlet weak var ishaLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(day: String, date: String, fajer: String, duher: String, asr: String, maghrib: String, isha: String) {
        dayLabel.text = day
        dateLabel.text = date
        fajerLabel.text = fajer
        duherLabel.text = duher
        asrLabel.text = asr
        maghribLabel.text = maghrib
        ishaLabel.text = isha
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
}
