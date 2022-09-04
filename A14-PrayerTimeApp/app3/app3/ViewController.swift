//
//  ViewController.swift
//  app3
//
//  Created by Razan Abdullah on 07/02/1444 AH.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewCell
        cell.fajrLabel.text = ""
        cell.dhahrLabel.text = ""
        cell.label1.text = ""
        cell.maghrbLabel.text = ""
        cell.ashaLabel.text = ""
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
    fetchPost()
       
    }
    
    func fetchPost() {
        //1. Step One
        let stringURL = "https://api.aladhan.com/v1/timingsByAddress/03-09-2022?address=Riyadh,KSA&method=8"
        guard let url = URL(string: stringURL) else {return}
        
        //2. Step Two
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print(error?.localizedDescription)
                return }
            
            guard let response = response as? HTTPURLResponse else {
                print("Invalid Response!")
                return }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
print("Status Code Should Be 2xx, but the code is \(response.statusCode)")
                return
        }
    print("Successful Get Data ✅")
     print("Data:\(data)")
     let jsonString = String(data: data!, encoding: .utf8)
       print("My JSON String is🛑: \(jsonString!)")
      guard let post = try? JSONDecoder().decode(Welcome.self, from: data!) else {return}
        
        
        

        print(post.status)
        print("post \(post)")
    }
        task.resume()
        
}
    
}



// MARK: - Welcome
struct Welcome: Codable {
    let code: Int
    let status: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let timings: Timings
}


// MARK: - Timings
struct Timings: Codable {
    let fajr, sunrise, dhuhr, asr: String
    let sunset, maghrib, isha, imsak: String
    let midnight, firstthird, lastthird: String

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
        case lastthird = "Lastthird"
    }
}

