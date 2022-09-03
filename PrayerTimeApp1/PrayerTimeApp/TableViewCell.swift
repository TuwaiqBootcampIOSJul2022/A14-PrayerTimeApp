//
//  TableViewCell.swift
//  PrayerTimeApp
//
//  Created by AlenaziHazal on 07/02/1444 AH.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var nameCity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
