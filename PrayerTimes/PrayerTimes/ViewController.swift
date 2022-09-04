//
//  ViewController.swift
//  PrayerTimes
//
//  Created by Waad on 06/02/1444 AH.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    
    @IBOutlet weak var myTable: UITableView!
    
    //var prayesData = [Pray]()
    
    var arrTimes = [Datum]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.delegate = self
        myTable.dataSource = self
        
         fetchPost()
        
//        DispatchQueue.main.async {
//
//            self.myTable.reloadData()
//        }
       
        
    }

    func fetchPost() {
    let stringURL = "https://api.aladhan.com/v1/calendar?latitude=24.774265&longitude=46.738586&method=2"
            guard let url = URL(string: stringURL) else {
                print("Url Error")
                return
                
            }
        
        // 2. Step Two
        let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
                    
                    guard error == nil else {
                        
                        print(error?.localizedDescription as Any)
                        return
                        
                    }
                    guard let response = response as? HTTPURLResponse else {
                        
                        print("Invalid Response!!")
                        return
                    }
                    
                    guard response.statusCode >= 200 && response.statusCode < 300 else {
                        
                        print("Status Code Should Be 2xx, but the code is \(response.statusCode)")
                        
                        return
                    }
                    
                    guard let prayerTimeRequest = try? JSONDecoder().decode(Pray.self, from: data!)
                        
            else {
                        print("Can't Decode")
                        return
                    }
                    
                    print("Successfully Get Data ✅")
            
            let date = Date()

                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
            let formatedDate = dateFormatter.string(from: date)
            
                        print(formatedDate)
         
            
            DispatchQueue.main.async { [self] in
                arrTimes.self = prayerTimeRequest.data
                self.myTable.reloadData()
                print(arrTimes)
            }
           
           
                  print("=============================")
                //print(self.prayesData)
                 // print(prayesData.count)
                  print(prayerTimeRequest)
                
                }
                
                task.resume()
        
    }
}


    extension ViewController: UITableViewDataSource {
      
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrTimes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            as! CustomTableViewCell
        
    
          //  fajrTime.text = arrTimes[indexPath.row].meta.timezone
           // cell.textLabel?.text = arrTimes[indexPath.row].date.readable
            cell.textLabel?.text = arrTimes[indexPath.row].timings.fajr
            
            return cell
        }
    }
