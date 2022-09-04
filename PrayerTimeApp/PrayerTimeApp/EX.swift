//
//  EX.swift
//  PrayerTimeApp
//
//  Created by user on 07/02/1444 AH.
//

import Foundation
import UIKit
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTabel.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TamieTVCell
        //cell.TimeLabel.text = "\(MyArray[indexPath.row].date.hijri.weekday.ar)"
        cell.TimeLabel.text = "يوم \(MyArray[indexPath.row].date.hijri.weekday.ar) "
        cell.TimeLabel2.text = " \(MyArray[indexPath.row].date.gregorian.date)"
        return cell
        
    }
    
    
    func fetchPost(){
        // setp(1)
        let stringURL = "https://api.aladhan.com/v1/calendarByCity?city=Riyadh&country=Saudi%20Arabia"
        guard let url = URL(string: stringURL) else {return}
        
        //strp(2) - create session
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
            
            print("SUCCESSFULY GET DATA ✅")
            //guard let post = try? JSONDecoder().decode(Welcome.self, from: data!) else {return}
            guard let post = try? JSONDecoder().decode(Welcome.self, from: data!) else {return}
            print("this is data",post)
            DispatchQueue.main.async {
                //self.MyArray = post.data
                self.MyArray = post.data
                self.MyTabel.reloadData()
            }
            //TimeLabel.text = "\(post.fajr)"
            
           
            

        }
        
        task.resume()
        
    }
}
