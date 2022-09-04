//
//  TableViewCell.swift
//  PrayerApp
//
//  Created by Raneem Alkahtani on 03/09/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    var prayset:String?
    @IBOutlet weak var TimeLabelCell: UILabel!
    @IBOutlet weak var prayLabelcell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        prayLabelcell.text = prayset
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
