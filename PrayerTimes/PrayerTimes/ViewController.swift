//
//  ViewController.swift
//  PrayerTimes
//
//  Created by NosaibahMW on 07/02/1444 AH.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var prayerTimeTableView: UITableView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var prayer:[Prayer] = [Prayer(name: "Fajr", time: "", image: "sunrise"),
                           Prayer(name: "Dhuhr", time: "", image: "sun.max"),
                           Prayer(name: "Asr", time: "", image: "sun.min"),
                           Prayer(name: "Maghrib", time: "", image: "sunset"),
                           Prayer(name: "Isha", time: "", image: "moon.stars")]
    
    var indexOfArray = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexOfArray = getDataArrayIndex()
        setDayAndDate()
        prayerTimeTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        fetchPost()
        
        subView.layer.cornerRadius = 5
    }
    
    
    
    //to get index of today's date
    func getDataArrayIndex() -> Int{
        
        var index = 0
        
        let todaysDate = Date.now
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "dd"
        let date = formatter3.string(from: todaysDate)
        
        if date.prefix(1) == "0" {
            index = Int(date.suffix(1))!
            print(index)
            return index
        }
        
        return Int(date)!
    }
    
    
    
    func setDayAndDate(){
        
        let today = Date.now
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "d MMM y"
        dateLabel.text = formatter3.string(from: today)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dayLabel.text = dateFormatter.string(from: today)
        
    }
}




extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayer.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = prayerTimeTableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell

        cell.prayerName.text = prayer[indexPath.row].name
        cell.prayerTime.text = "\((prayer[indexPath.row].time).prefix(5))" //change time format to be HH:mm
        cell.prayerImage.image = UIImage(systemName: prayer[indexPath.row].image)
        
        return cell
        
    }
}




extension ViewController {
    
    func fetchPost(){

        let stringURL = "https://api.aladhan.com/v1/calendarByCity?city=Riyadh&country=Saudi%20Arabia&method=4"
        guard let url = URL(string: stringURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
            guard error == nil else { //if there an error, please don't complete
                print(error?.localizedDescription)
                return
                
            }
            
            guard let response = response as? HTTPURLResponse else { //is there a response?
                print("Invalid response!!")
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode <= 299 else { //from 200 to 299 meaning Success/OK status code
                print("Status code should be 2xx, but the code is \(response.statusCode)")
                return
            }
            
            guard let post = try? JSONDecoder().decode(Welcome.self, from: data!) else {return}
            
            
            DispatchQueue.main.async {
                self.prayer[0].time = post.data[self.indexOfArray].timings.fajr
                self.prayer[1].time = post.data[self.indexOfArray].timings.dhuhr
                self.prayer[2].time = post.data[self.indexOfArray].timings.asr
                self.prayer[3].time = post.data[self.indexOfArray].timings.maghrib
                self.prayer[4].time = post.data[self.indexOfArray].timings.isha
                self.prayerTimeTableView.reloadData()
            }
        }
        
        task.resume()
        
    }
}






// MARK: - Welcome
struct Welcome: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let timings: Timings
}
// MARK: - Timings
struct Timings: Codable {
    let fajr, sunrise, dhuhr, asr: String
    let sunset, maghrib, isha, imsak: String
    let midnight, firstthird: String

    enum CodingKeys: String, CodingKey {
        case fajr = "Fajr"
        case sunrise = "Sunrise"
        case dhuhr = "Dhuhr"
        case asr = "Asr"
        case sunset = "Sunset"
        case maghrib = "Maghrib"
        case isha = "Isha"
        case imsak = "Imsak"
        case midnight = "Midnight"
        case firstthird = "Firstthird"
    }
}


