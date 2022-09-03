//
//  customCell.swift
//  prayAPI
//
//  Created by Faisal Almutairi on 07/02/1444 AH.
//

import UIKit

class customCell: UITableViewCell {

    @IBOutlet weak var views: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var prayerLabel: UILabel!
    @IBOutlet weak var prayerTimesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
