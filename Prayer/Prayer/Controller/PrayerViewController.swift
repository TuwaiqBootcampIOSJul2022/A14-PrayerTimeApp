//
//  PrayerViewController.swift
//  Prayer
//
//  Created by REOF ALMESHARI on 03/09/2022.
//

import UIKit

class PrayerViewController: UIViewController {

  
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PrayerTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        fetch()
    }
    
func fetch(){
        let stringURL = "https://api.aladhan.com/v1/calendarByAddress?address=Muhaisin%20Mosque,%20Riyadh,%20SaudiArabia&method=2&month=09&year=2022"
        guard let url = URL(string: stringURL) else {return
            print("Error")
            
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {return}
            guard let response = response as? HTTPURLResponse else { return
                print("error response")
            }
            guard response.statusCode >= 200 && response.statusCode <= 299 else {return
                print("\(response.statusCode)")
            }
            
            print("Connectid")
            
        // 2. Convert data to json
            let jsonString = String(data: data!, encoding: .utf8)
            print(jsonString!)
            
            //3. Convert Json to Model using quicktype website

            //4. decode Json (From Json to Swift Obj
            guard let post = try? JSONDecoder().decode(Welcome.self,from:data!) else { return}

            print("This is data " , post)

            DispatchQueue.main.async {
                arrPrayer = post.data
               // self.arrPrayer = post.data
                self.tableView.reloadData()

            }
            
        }
        
        
      
        task.resume()
   
    
        
     
    }


}

extension PrayerViewController : UITableViewDelegate , UITableViewDataSource {
 
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPrayer.count

     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PrayerTableViewCell
        
        cell.prayerLabel.text = arrPrayer[indexPath.row].date.hijri.weekday.en
        cell.dateMonthLabel.text = arrPrayer[indexPath.row].date.gregorian.date
        cell.fajrLabel.text = "Fajr : \(arrPrayer[indexPath.row].timings.fajr) "
        cell.dhuhorLabel.text = "Dhuhr : \(arrPrayer[indexPath.row].timings.dhuhr)"
        cell.asarLabel.text = "Asar : \(arrPrayer[indexPath.row].timings.asr) "
        cell.magribLabel.text = "Maghrib : \(arrPrayer[indexPath.row].timings.maghrib)"
        cell.eishaLabel.text = "Isha : \(arrPrayer[indexPath.row].timings.isha)"
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        vc.fajrtime = arrPrayer[indexPath.row].timings.fajr
        vc.duhrrtime = arrPrayer[indexPath.row].timings.dhuhr
        vc.asrtime = arrPrayer[indexPath.row].timings.asr
        vc.magribtime = arrPrayer[indexPath.row].timings.maghrib
        vc.ishatime = arrPrayer[indexPath.row].timings.isha
        vc.day = arrPrayer[indexPath.row].date.hijri.weekday.en
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    
}
