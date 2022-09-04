//
//  SecondVC.swift
//  PrayerTimeApp
//
//  Created by user on 08/02/1444 AH.
//

import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var FajrLabel: UILabel!
    
    @IBOutlet weak var DhuhrLabel: UILabel!
    
    @IBOutlet weak var AsrLabel: UILabel!
    
    @IBOutlet weak var MaghribLabel: UILabel!
    
    
    @IBOutlet weak var IshaLabel: UILabel!
    
    @IBOutlet weak var dayTime: UILabel!
    
    var fajr = ""
    var dhuhr = ""
    var asr = ""
    var maghrib = ""
    var isha = ""
    var day = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        FajrLabel.text = fajr
        DhuhrLabel.text =  dhuhr
        AsrLabel.text = asr
        MaghribLabel.text = maghrib
        IshaLabel.text = isha
        dayTime.text = day 
        
        
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
