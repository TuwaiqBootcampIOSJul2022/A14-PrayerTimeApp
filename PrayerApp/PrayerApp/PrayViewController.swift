//
//  PrayViewController.swift
//  PrayerApp
//
//  Created by Raneem Alkahtani on 02/09/2022.
//

import UIKit

class PrayViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var arrPray : [Datum] = []
    var times = [Time]()
    
    var fajr:String?
    var imsak:String?
    var sunrise:String?
    var dhuhr:String?
    var asr:String?
    var sunset:String?
    var maghrib:String?
    var isha:String?
    var midnight:String?
    var name:String?
    var gregorian:String?
    var hijri:String? = ""
    var timeStamp:String?
    var latitude:Double? = 24.774265
    var longitude:Double? = 46.738586
    var timeZone:String?
    var method = "Majlis Ugama Islam Singapura, Singapore"
    
    
    @IBOutlet weak var cityLab: UILabel!
    @IBOutlet weak var lab: UILabel!
    
    @IBOutlet weak var ImageRiyadh: UIImageView!
    @IBOutlet weak var PrayTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PrayTableView.delegate = self
        PrayTableView.dataSource = self
        PrayTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "prayCell")
        ImageRiyadh.layer.cornerRadius = 20
        PrayTableView.layer.cornerRadius = 20
        getJsonFromUrl()

          }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellA =  tableView.dequeueReusableCell(withIdentifier: "prayCell", for: indexPath) as! TableViewCell
       cellA.layer.cornerRadius = 20

        //        if self.arrPray[indexPath.row].date.gregorian.date == "\(Date.now)" {
       
        let timeItem = times[indexPath.row]
        cellA.prayLabelcell.text = timeItem.name
        cellA.TimeLabelCell.text = timeItem.time
            //print("timing is :" + arrPray[indexPath.row].timings.fajr)
        return cellA

        }

    func addIntoArray(){
        guard let time1 = Time(name:"Imsak", time:self.imsak!, gregorian: self.gregorian!, hijri: self.hijri!, timeStamp: "", latitude: self.latitude!, longitude: self.longitude!, timeZone: self.timeZone!, method: self.method) else {
            fatalError("Unable to instantiate time1")
        }
        
        guard let time2 = Time(name:"Fajr", time:self.fajr!, gregorian: self.gregorian!, hijri: self.hijri!, timeStamp: "", latitude: self.latitude!, longitude: self.longitude!, timeZone: self.timeZone!, method: self.method) else {
            fatalError("Unable to instantiate time1")
        }
        
        guard let time3 = Time(name:"Sunrise", time:self.sunrise!, gregorian: self.gregorian!, hijri: self.hijri!, timeStamp: "", latitude: self.latitude!, longitude: self.longitude!, timeZone: self.timeZone!, method: self.method) else {
            fatalError("Unable to instantiate time1")
        }
        
        guard let time4 = Time(name:"Dhuhr", time:self.dhuhr!, gregorian: self.gregorian!, hijri: self.hijri!, timeStamp: "", latitude: self.latitude!, longitude: self.longitude!, timeZone: self.timeZone!, method: self.method) else {
            fatalError("Unable to instantiate time1")
        }
        
        guard let time5 = Time(name:"Asr", time:self.asr!, gregorian: self.gregorian!, hijri: self.hijri!, timeStamp: "", latitude: self.latitude!, longitude: self.longitude!, timeZone: self.timeZone!, method: self.method) else {
            fatalError("Unable to instantiate time1")
        }
        
        guard let time6 = Time(name:"Sunset", time:self.sunset!, gregorian: self.gregorian!, hijri: self.hijri!, timeStamp: "", latitude: self.latitude!, longitude: self.longitude!, timeZone: self.timeZone!, method: self.method) else {
            fatalError("Unable to instantiate time1")
        }
        
        guard let time7 = Time(name:"Maghrib", time:self.maghrib!, gregorian: self.gregorian!, hijri: self.hijri!, timeStamp: "", latitude: self.latitude!, longitude: self.longitude!, timeZone: self.timeZone!, method: self.method) else {
            fatalError("Unable to instantiate time1")
        }
        
        guard let time8 = Time(name:"Fajr", time:self.isha!, gregorian: self.gregorian!, hijri: self.hijri!, timeStamp: "", latitude: self.latitude!, longitude: self.longitude!, timeZone: self.timeZone!, method: self.method) else {
            fatalError("Unable to instantiate time1")
        }
        
        guard let time9 = Time(name:"Midnight", time:self.midnight!, gregorian: self.gregorian!, hijri: self.hijri!, timeStamp: "", latitude: self.latitude!, longitude: self.longitude!, timeZone: self.timeZone!, method: self.method) else {
            fatalError("Unable to instantiate time1")
        }
        
        self.times += [time1,time2,time3,time4,time5,time6,time7,time8,time9]
    }

    //this function is fetching the json from URL
    func getJsonFromUrl(){
        
        // Getting date from calendar
        let date = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date) // gets current year (i.e. 2022)
        let currentMonth = calendar.component(.month, from: date) // gets current month (i.e. 9)
        let currentDate = calendar.component(.day, from: date) // gets current day (i.e. 3)
        
        // Print it for checking
        print(currentMonth)
        print(currentYear)

        
        // Making query for URL
        let query = "calendar?latitude=24.774265&longitude=46.738586&method=11&month=\(currentMonth)&year=\(currentYear)"
        //Create URL
        let url = URL(string: APIConfig.END_POINT+query)
        print(url)
        print(query)
        // Fetching the data from the URL
       let task =  URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error in
           guard error == nil else {return}
           guard let response = response as? HTTPURLResponse else { return
               print("error response")
           }
           guard response.statusCode >= 200 && response.statusCode <= 299 else {return
               print("\(response.statusCode)")
           }
           
           print("Connectid")
          // let jsonString = String(data: data!, encoding: .utf8)

          if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
               print("Doing request...")
            
         
                
                if let dataArray = jsonObj.value(forKey: "data") as? NSArray {
                    
                    var index = 0
                    for data in dataArray{
                        
                        if let dataDict = data as? NSDictionary{
                            if let timingsObj = dataDict.value(forKey: "timings") as? NSDictionary {
                                self.fajr = timingsObj.value(forKey: "Fajr") as? String
                                self.imsak = timingsObj.value(forKey: "Imsak") as? String
                                self.sunrise = timingsObj.value(forKey: "Sunrise") as? String
                                self.dhuhr = timingsObj.value(forKey: "Dhuhr") as? String
                                self.asr = timingsObj.value(forKey: "Asr") as? String
                                self.sunset = timingsObj.value(forKey: "Sunset") as? String
                                self.maghrib = timingsObj.value(forKey: "Maghrib") as? String
                                self.isha = timingsObj.value(forKey: "Isha") as? String
                                self.midnight = timingsObj.value(forKey: "Midnight") as? String
                                
                            }
                            if let dateObj = dataDict.value(forKey: "date") as? NSObject {
                                if let gregorianObj = dateObj.value(forKey: "gregorian") as? NSObject {
                                    self.gregorian = gregorianObj.value(forKey: "date") as? String
                                }
                                if let hijriObj = dateObj.value(forKey: "hijri") as? NSObject {
                                    self.hijri = hijriObj.value(forKey: "date") as? String
                                }
                            }
                            if let metaObj = dataDict.value(forKey: "meta") as? NSObject {
                                self.timeZone = metaObj.value(forKey: "timezone") as? String
                                
                            }
                            if index == (currentDate-1) {
                                self.addIntoArray()
                            }
                            index = index + 1
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    //it will show the names to label
                    print("Request done...")
                    self.lab.text = "\(Date.now)" //self.gregorian
                    self.cityLab.text = "Riyadh, Saudi Arabi"
                    self.PrayTableView.reloadData()
                  //  indicator.stopAnimating()
                })
            }
        }).resume()
    }
    
 
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    }
extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
        let width: CGFloat = floor(adjustedWidth / columns)
        let height: CGFloat = width / 1.5
        return CGSize(width: width, height: height)
    }
}
