//
//  ViewController.swift
//  TableViewRoz
//
//  Created by Ahmed Salah on 03/09/2022.
//

import UIKit

class ViewController: UIViewController{
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var prayArray :[Datum] = []
    var re = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // for refresh
        re.tintColor = UIColor.black
        re.addTarget(self, action: #selector(GetRe), for: .valueChanged)
        tableView.addSubview(re)
        
        
        tableView.register(UINib(nibName: "customCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        jsonPray()
    }
    
    @objc func GetRe(){
        re.endRefreshing()
        tableView.reloadData()
    }
    
    func jsonPray(){
        
        let prayURL = "https://api.aladhan.com/v1/hijriCalendarByCity?city=Riyadh&country=SaudiArabia&method=4&month=02&year=1444"
        
        guard let url = URL(string: prayURL) else {
            print("linkURL")
            return
        }
        
        let check = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Invalid")
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode <= 299 else{
                print("\(response.statusCode)")
                return
            }
            
            print("Succssfuly Show Data")
            print("Data\(data)")
            let jsonString = String(data: data!, encoding: .utf8)
            print("Json is show \(jsonString!)")
            
            guard let prays =  try? JSONDecoder().decode(Welcome.self, from: data!) else {
                print("error")
                return
                
            }
            
            DispatchQueue.main.async {
                self.prayArray = prays.data
                print(self.prayArray[0].timings.fajr)
                print(self.prayArray[1].timings.dhuhr)
                print(self.prayArray[2].timings.asr)
                print(self.prayArray[3].timings.maghrib)
                print(self.prayArray[4].timings.isha)
                self.tableView.reloadData()
            }
        }
        check.resume()
    }
}





extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayArray.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return prayArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customCell
        
        
        
        // Time of Salah
        
        cell.fjr.text = prayArray[indexPath.section].timings.fajr
        cell.dhr.text = prayArray[indexPath.section].timings.dhuhr
        cell.asr.text = prayArray[indexPath.section].timings.asr
        cell.mgrb.text = prayArray[indexPath.section].timings.maghrib
        cell.eshaa.text = prayArray[indexPath.section].timings.isha
        
        // Name of Salah
        cell.fjr1.text = "الفجر :"
        cell.dhr1.text = "الضهر :"
        cell.asr1.text = "العصر :"
        cell.mgrb1.text = "المغرب :"
        cell.eshaa1.text = "العشاء :"
        
        
        return cell
        
        
    }
}
