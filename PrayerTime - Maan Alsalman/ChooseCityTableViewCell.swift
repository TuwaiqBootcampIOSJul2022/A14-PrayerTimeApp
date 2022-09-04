//
//  ChooseCityTableViewCell.swift
//  PrayerTimeApp
//
//  Created by Maan Abdullah on 03/09/2022.
//

import UIKit

class ChooseCityTableViewCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
}
