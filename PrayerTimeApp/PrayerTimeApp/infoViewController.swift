//
//  infoViewController.swift
//  PrayerTimeApp
//
//  Created by Ruba on 07/02/1444 AH.
//

import UIKit

class infoViewController: UIViewController {

    var name1:String?
    var name2:String?
    var name3:String?
    var name4:String?
    var name5:String?
    
    
    @IBOutlet weak var labelI: UILabel!
    @IBOutlet weak var labelM: UILabel!
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var labelD: UILabel!
    @IBOutlet weak var labelF: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        labelF.text = name1
        labelD.text = name2
        labelA.text = name3
        labelM.text = name4
        labelI.text = name5
      
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
