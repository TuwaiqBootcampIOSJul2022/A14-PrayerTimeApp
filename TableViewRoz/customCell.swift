

import UIKit

class customCell: UITableViewCell {

    
    
    // tome for salah
    
    @IBOutlet weak var fjr: UILabel!
    @IBOutlet weak var dhr: UILabel!
    @IBOutlet weak var asr: UILabel!
    @IBOutlet weak var mgrb: UILabel!
    @IBOutlet weak var eshaa: UILabel!
    
    
    // name of salah
    
    @IBOutlet weak var fjr1: UILabel!
    @IBOutlet weak var dhr1: UILabel!
    @IBOutlet weak var asr1: UILabel!
    @IBOutlet weak var mgrb1: UILabel!
    @IBOutlet weak var eshaa1: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    

}
