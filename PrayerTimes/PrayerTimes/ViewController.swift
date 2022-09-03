//
//  ViewController.swift
//  PrayerTimes
//
//  Created by Kholoud Almutairi on 06/02/1444 AH.
//

import UIKit

class ViewController: UIViewController {
    


    var Mydata = [Datum]()
    

    @IBOutlet weak var MytabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchPost()
    
        
    }
    

        // call the fnc in viewDidLoad
        func fetchPost(){
            
            // 1 Step One
let Stringurl = "https://api.aladhan.com/v1/calendarByCity?city=Riyadh&country=Saudi%20Arabia"
            guard let url = URL(string: Stringurl) else {return}

            
            // 2 Step tow
            
          let Task =  URLSession.shared.dataTask(with: url) { data, response, error in
                guard error ==  nil else {return} // if have erorr stop
                
                guard let response = response as? HTTPURLResponse else {
                    print("Invalid Respose !!")
                    return }
                
                guard response.statusCode >= 200 && response.statusCode < 300 else {
                    print("Status Code Shode Be 2xx , but the code is \(response.statusCode) ")
                    return
                    
                }
            
                print("SUCCSSSSFULY Get Data ✅")
              
        
              let jsonString = String(data: data!, encoding: .utf8)
              print(jsonString!)

              guard let post = try? JSONDecoder().decode(Welcome.self, from: data!)else{
                  return
              }
              print("data is" , post)

              DispatchQueue.main.async {
                  self.Mydata = post.data
                  self.MytabelView.reloadData()
              }



            }

            Task.resume()

        }}







//--------------------------------------

extension ViewController : UITableViewDelegate , UITableViewDataSource   {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Mydata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MytabelView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.Label1.text = "\(Mydata[indexPath.row].date.hijri.weekday.en)"
        cell.Label2.text = Mydata[indexPath.row].date.gregorian.date
        cell.Labelf.text = "Fajr : \(Mydata[indexPath.row].timings.fajr) "
        cell.Labelt.text = "Dhuhr : \(Mydata[indexPath.row].timings.dhuhr)"
        cell.Labela.text = "Asar : \(Mydata[indexPath.row].timings.asr) "
        cell.Labelm.text = "Maghrib : \(Mydata[indexPath.row].timings.maghrib)"
        cell.Labels.text = "Isha : \(Mydata[indexPath.row].timings.isha)"
        return cell
    }
    

    }
