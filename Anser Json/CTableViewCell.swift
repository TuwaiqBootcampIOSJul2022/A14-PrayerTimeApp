//
//  CTableViewCell.swift
//  Json
//
//  Created by Anaal Albeeshi on 01/02/1444 AH.
//

import UIKit

class CTableViewCell: UITableViewCell {
    
    @IBOutlet weak var L1: UILabel!
    @IBOutlet weak var L2: UILabel!
    @IBOutlet weak var L4: UILabel!
    @IBOutlet weak var L3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
