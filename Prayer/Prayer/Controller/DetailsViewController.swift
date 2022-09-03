//
//  DetailsViewController.swift
//  Prayer
//
//  Created by REOF ALMESHARI on 03/09/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    var fajrtime : String?
    var duhrrtime : String?
    var asrtime : String?
    var magribtime : String?
    var ishatime : String?
    var day : String?

    @IBOutlet weak var asrLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
   // @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dhurLabel: UILabel!
    @IBOutlet weak var maghribLabel: UILabel!
    @IBOutlet weak var ishaLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
     //   dayLabel.text = day
        timeLabel.text = "Fajr : \(fajrtime!)"
        dhurLabel.text = "Duhr : \(duhrrtime!)"
        asrLabel.text = "Asr : \(asrtime!)"
        maghribLabel.text = "Maghrib : \(magribtime!)"
        ishaLabel.text = "Isha : \(ishatime!)"
        // Do any additional setup after loading the view.
        title = day
     
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
