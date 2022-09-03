
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateGregorianLabel: UILabel!
    @IBOutlet weak var dateHijriLabel: UILabel!
    @IBOutlet weak var dayArabicLabel: UILabel!
    @IBOutlet weak var dayEnglishLabel: UILabel!
    @IBOutlet weak var choiseTimezoneButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayPrayer:[[String:String]] = [[:]]
    
    var dateGregorian:String = ""
    var dateHijri:String = ""
    var dayArabic:String = ""
    var dayEnglish:String = ""
    var stringURL = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

        let menuClosure = {(action: UIAction) in
            self.update(name: action.title)
          }
       
        choiseTimezoneButton.menu = UIMenu(children: [
                  UIAction(title: "Riyadh", state: .on, handler: menuClosure),
                  UIAction(title: "Dammam", handler: menuClosure),
                  UIAction(title: "Jeddah", handler: menuClosure),
              ])
        
        choiseTimezoneButton.showsMenuAsPrimaryAction = true
        choiseTimezoneButton.changesSelectionAsPrimaryAction = true
        
        fetchPost()
    }
    
    func update(name:String) {
       
       if name == "Riyadh" {
           stringURL = "https://api.aladhan.com/v1/timingsByCity?city=Riyadh&country=Saudi%20Arabia&method=8"
       }else if name == "Dammam" {
           stringURL = "https://api.aladhan.com/v1/timingsByCity?city=Dammam&country=Saudi%20Arabia&method=8"
       }else if name == "Jeddah" {
           stringURL = "https://api.aladhan.com/v1/timingsByCity?city=Jeddah&country=Saudi%20Arabia&method=8"
       }
        
        fetchPost()
   }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPrayer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.prayLabel.text = arrayPrayer[indexPath.row]["pray"]
        cell.imageViewPray.image = UIImage(named: arrayPrayer[indexPath.row]["image"] ?? "")
        cell.timeLabel.text = arrayPrayer[indexPath.row]["time"]
        
        dateGregorianLabel.text = dateGregorian
        dateHijriLabel.text = dateHijri
        dayArabicLabel.text = dayArabic
        dayEnglishLabel.text = dayEnglish
        
        return cell
    }
    
}

extension ViewController{
    func fetchPost(){
        
        if stringURL.isEmpty{
            stringURL = "https://api.aladhan.com/v1/timingsByCity?city=Riyadh&country=Saudi%20Arabia&method=8"
        }
        guard let url = URL(string: stringURL) else{return}


        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return}

            guard let response = response as? HTTPURLResponse else {
                print("Invalid Response")
                return }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else{
                print("Status Code Should Be 2xx, but the is \(response.statusCode)")
                return}
            print("succssfuly get data")

            _ = String(data: data!, encoding: .utf8)

            guard let post = try? JSONDecoder().decode(Welcome.self, from: data!) else{return}
            
            self.dateGregorian = post.data.date.gregorian.date
            self.dateHijri = post.data.date.hijri.date
            self.dayArabic = post.data.date.hijri.weekday.ar
            self.dayEnglish = post.data.date.gregorian.weekday.en
            
            self.arrayPrayer = [["pray":"الفجر","time":post.data.timings.fajr,"image":"sunrise"], ["pray":"الظهر","time":post.data.timings.dhuhr,"image":"sunny"], ["pray":"العصر","time":post.data.timings.asr,"image":"cloudy"], ["pray":"المغرب","time":post.data.timings.maghrib,"image":"sunset"], ["pray":"العشاء","time":post.data.timings.isha,"image":"moon"]]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }

}
