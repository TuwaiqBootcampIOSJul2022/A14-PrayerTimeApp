//
//  TableViewCell.swift
//  app3
//
//  Created by Razan Abdullah on 07/02/1444 AH.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var fajrLabel: UILabel!
    @IBOutlet weak var dhahrLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var maghrbLabel: UILabel!
    @IBOutlet weak var ashaLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
