

import UIKit

class ViewController: UIViewController {

    var prayArray :[Datum] = []
    @IBOutlet weak var prayTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prayTableView.delegate = self
        prayTableView.dataSource = self
        prayTableView.register(UINib(nibName: "customCell", bundle: nil), forCellReuseIdentifier: "cell")
        prayTableView.layer.cornerRadius = 16
        jsonPray()
        
    }
    
    func jsonPray(){
        
        let prayURL = "https://api.aladhan.com/v1/hijriCalendarByCity?city=Riyadh&country=SaudiArabia&method=4&month=02&year=1444"
        
        guard let url = URL(string: prayURL) else {
            print("url issue")
            return
        }
        let check = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                
                print(error?.localizedDescription ?? "")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                
                print("Invalid Response!!")
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode <= 299 else{
                
                print("Status code should be 2xx , but the code is \(response.statusCode)")
                return
            }
            print("Succssfuly downloaded DATA")
            print("Data\(data)")
            let jsonString = String(data: data!, encoding: .utf8)
            print("my json string is \(jsonString!)")
            
            guard let prays =  try? JSONDecoder().decode(Welcome.self, from: data!) else {
                print("problem")
                return}
            
//            print(prays.data[0].timings.fajr)
            
//            let jsonTime = prays.data[0].timings
            
            DispatchQueue.main.async {
                self.prayArray = prays.data
                print(self.prayArray[0].timings.fajr)
                self.prayTableView.reloadData()
            }

        }
        
        check.resume()
    }
    

}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
        
        cell.layer.cornerRadius = 16
        cell.views.layer.cornerRadius = 16
        cell.prayerTimesLabel.text = prayArray[indexPath.section].timings.fajr
        cell.dateLabel.text = prayArray[indexPath.section].date.hijri.date
        cell.prayerLabel.text = "الفجر"
        

        return cell
    }
}

