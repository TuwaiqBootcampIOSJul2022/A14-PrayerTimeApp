//
//  CellATableViewCell.swift
//  PrayerTimesAPI
//
//  Created by Anaal Albeeshi on 08/02/1444 AH.
//

import UIKit

class CellATableViewCell: UITableViewCell {
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var image_1: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
