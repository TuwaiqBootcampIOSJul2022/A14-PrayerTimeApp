//
//  SecondViewController.swift
//  PrayerTimeApp
//
//  Created by AlenaziHazal on 07/02/1444 AH.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableViewSecond: UITableView!
    var dhr1 = ""
    var fjr2 = ""
    var asr3 = ""
    var mgr4 = ""
    var asha5 = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "2")
        tableViewSecond.dataSource = self
        tableViewSecond.delegate = self
        tableViewSecond.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "cellMain1")
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
extension SecondViewController: UITableViewDelegate {
    
}
extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain1", for: indexPath) as! SecondTableViewCell
        cell.almagribTime.text = mgr4
        cell.alfajertime.text = fjr2
        cell.alasirTime.text = asr3
        cell.aldaherTime.text = dhr1
        cell.alashaTime.text = asha5
        return cell
    }
    
    
}
