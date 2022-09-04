//
//  ViewController.swift
//  Json
//
//  Created by Anaal Albeeshi on 01/02/1444 AH.
//

import UIKit

class ViewController: UIViewController{
    var countElment = 0
    var dataMy: [[String:Any]] = []
    
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        table.register(UINib(nibName: "CTableViewCell", bundle: nil),
                       forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
        readJsonFile(fileName: "myData") {
            myArray in for x in myArray {
                print(x)
            }
        }
    }
}

func readJsonFile(fileName: String, complation:([[String:Any]]) -> ()) -> [[String:Any]]{
    let path = Bundle.main.path(forResource: fileName, ofType: "json")!
    do{
        let data = try Data(contentsOf: URL(fileURLWithPath: path),options:.alwaysMapped)
        
        let json = try JSONSerialization.jsonObject(with: data) as! [[String:Any]]
        
        complation(json)
        return json
    }catch let errorTest {
        print(errorTest )
    }
    return []
}



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countElment
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CTableViewCell
        
        
        cell.L1.text = "\(dataMy[indexPath.row]["id"]!)"
       cell.L2.text = "\(dataMy[indexPath.row]["userId"]!)"
        //cell.L3.text = "\(dataMy[indexPath.row]["title"]!)"
        //cell.L4.text = "\(dataMy[indexPath.row]["body"]!)"
        
        return cell
    }
}
