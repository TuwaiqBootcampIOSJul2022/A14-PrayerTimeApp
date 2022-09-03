//
//  ViewController.swift
//  PrayerTimeApp
//
//  Created by Ruba on 06/02/1444 AH.
//

import UIKit

class ViewController: UIViewController {

     var arrData = [Datum]()
  
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "dataTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        view.backgroundColor =  #colorLiteral(red: 0.9446164966, green: 0.9536541104, blue: 0.8376326561, alpha: 1)
        fetch()
    }
    
    func fetch(){
    let stringURL = "https://api.aladhan.com/v1/calendarByAddress?address=Muhaisin%20Mosque,%20Riyadh,%20SaudiArabia&method=2&month=09&year=2022"
        guard let url = URL(string: stringURL) else{
            return print("error")
            
        }
        let task = URLSession.shared.dataTask(with: url){ data, response , error in
           guard error == nil else{return}
            guard let response = response as? HTTPURLResponse else{
                return print("reero response")
            }
            guard response.statusCode >= 200 && response.statusCode < 300 else{
               return print("\(response.statusCode)")
            }
            print("connect")
            
            let jsonString = String(data: data!, encoding: .utf8)
            print(jsonString!)
            
            guard let post = try? JSONDecoder().decode(Welcome.self, from: data!)else{
                return
            }
            print("this is data" , post)
            
            DispatchQueue.main.async {
                self.arrData = post.data
                self.table.reloadData()
            }
            
        }
        task.resume()
        
    }
    

}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return arrData.count
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! dataTableViewCell
       cell.label1.text = arrData[indexPath.row].date.hijri.weekday.ar
       cell.label2.text = arrData[indexPath.row].date.readable
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        71.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "vc") as? infoViewController
        vc?.name1 = arrData[indexPath.row].timings.fajr
        vc?.name2 = arrData[indexPath.row].timings.dhuhr
        vc?.name3 = arrData[indexPath.row].timings.asr
        vc?.name4 = arrData[indexPath.row].timings.maghrib
        vc?.name5 = arrData[indexPath.row].timings.isha
        navigationController?.pushViewController(vc!, animated: true)
    }


}
