//
//  ViewController.swift
//  APITableView
//
//  Created by Farah Alyousef on 06/02/1444 AH.
//

import UIKit

class ViewController: UIViewController {
  
    
    @IBOutlet weak var tableView: UITableView!
    var newsData = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
ParsingJson{Data in
    self.newsData = Data
    DispatchQueue.main.async{
        self.tableView.reloadData()
    }
}
    }
    func ParsingJson(completion: @escaping ([Article])->()){
//    func ParsingJson(){
        
        let urlstring = " http://api.aladhan.com/v1/calendarByCity?city=London&country=United Kingdom&method=2&month=04&year=2017"
        let url = URL(string: urlstring)
        
        guard url != nil else {
            print ("error")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with:url!){data, response, error in
        
            if error == nil , data != nil {
                
                let decoder = JSONDecoder()
                do{
                    let ParsingData = try decoder.decode(NewsApi.self, from: data!)
                    completion(ParsingData.data)
                }catch{
                    print("Parsing error")
      }
   }

 }
        dataTask.resume()
}
}
struct NewsApi: Decodable {
    var status: String
    var code: Int
    var data:[Article]
}
struct Article:Decodable {
    var Fajr: String?
    var Sunrise: String?
    var Dhuhr: String?

}

        extension ViewController : UITableViewDelegate, UITableViewDataSource{
            func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
                return newsData.count
            }
            
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = newsData[indexPath.row].Fajr
                return cell
            }
        }

