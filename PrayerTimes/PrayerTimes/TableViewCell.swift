//
//  TableViewCell.swift
//  PrayerTimes
//
//  Created by Kholoud Almutairi on 07/02/1444 AH.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Labelf: UILabel!
    @IBOutlet weak var Labelt: UILabel!
    @IBOutlet weak var Labela: UILabel!
    @IBOutlet weak var Labelm: UILabel!
    @IBOutlet weak var Labels: UILabel!





    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
