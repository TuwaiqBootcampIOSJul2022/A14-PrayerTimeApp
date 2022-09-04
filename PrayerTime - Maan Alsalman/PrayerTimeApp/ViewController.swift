//
//  ViewController.swift
//  PrayerTimeApp
//
//  Created by Maan Abdullah on 02/09/2022.
//

import UIKit

class ViewController: UIViewController {
    var prayerTimesArray = [Timings]()
    var hajriDateArray = [Hijri]()
    var cityChosen = 0
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title =  "مواقيت الصلاة في \(cities[cityChosen].cityName)"
        navigationController?.navigationBar.tintColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PrayerTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "prayerCell")
        fetchData()
    }

    
    func fetchData(){
        let urlString = cities[cityChosen].cityURL
    
        guard let url = URL(string: urlString) else {
        print("Can't convert it to url")
        return  }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error!)
                return
                
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Invaild Response")
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else{
                print("Status code should be 2xx, but the code is \(response.statusCode)")
                return
            }
            print("Successful get data")
//            let json = String(data: data!, encoding: .utf8)
            
            guard let prayerTimes = try? JSONDecoder().decode(PrayerTime.self, from: data!) else {
                print("Can't decode it")
                return}
            DispatchQueue.main.async {
                for index in prayerTimes.data{
                    self.prayerTimesArray.append(index.timings)
                    self.hajriDateArray.append(index.date.hijri)
                }
                self.tableView.reloadData()
            }
        }
        task.resume()
        }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        prayerTimesArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prayerCell", for: indexPath) as! PrayerTimeTableViewCell
        let day = hajriDateArray[indexPath.section]
        let prayerTime = prayerTimesArray[indexPath.section]
        cell.setupCell(day: day.weekday.ar.rawValue, date: day.date, fajer: String(prayerTime.fajr.prefix(5)), duher: String(prayerTime.dhuhr.prefix(5)), asr: String(prayerTime.asr.prefix(5)), maghrib: String(prayerTime.maghrib.prefix(5)), isha: String(prayerTime.isha.prefix(5)))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
}
