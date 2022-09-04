//
//  HomeViewController.swift
//  PrayerTimeApp
//
//  Created by Rashed Shrahili on 08/02/1444 AH.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var regionsTableView: UITableView!
    
    var index:Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        regionsTableView.dataSource = self
        regionsTableView.delegate = self
        
        regionsTableView.register(UINib(nibName: "RegionCell", bundle: nil), forCellReuseIdentifier: "regionCell")
        
    }
    
    
    
}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return regionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath) as! RegionCell
        
        cell.regionNameLabel.text = regionArr[indexPath.row].regionName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        index = indexPath.row
        
        performSegue(withIdentifier: "prayerView", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "prayerView" {
            
            if let viewVC = segue.destination as? ViewController {
                
                viewVC.selectedRegion = regionArr[index!].regionNameEn
            }
        }
    }
    
}
