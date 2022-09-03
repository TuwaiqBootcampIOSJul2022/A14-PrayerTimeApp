
import UIKit




class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    @IBOutlet var image: UIImageView!
    
    var array:[[String:String]] = [[:]]

   var img = UIImage(named: "image")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPost()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "identifierTableViewCell")
        tableView.layer.cornerRadius = 16
        image.image=img
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifierTableViewCell",for: indexPath) as? TableViewCell
        cell!.time.text = array[indexPath.row]["time"]
        cell?.name.text = array[indexPath.row]["pray"]
      return cell!

        
    }

    func fetchPost(){
        //1. Step one:
        let stringURL = "https://api.aladhan.com/v1/timingsByCity?city=Riyadh&country=Saudi%20Arabia&method=8"
        guard let url = URL(string: stringURL) else {return}
        print(url)
        //2. Step two:
        let task =  URLSession.shared.dataTask(with: url) {data, response, error in
            guard error ==  nil else {
                print(error?.localizedDescription as Any)
                return }
            
            guard let response = response as? HTTPURLResponse else {
                print("Invaild Response")
                return }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status code should be 2xx, but the code is \(response.statusCode)")
                return
            }
            print("Successful get data 🤩")
            _ = String(data: data!, encoding: .utf8)

            guard let post = try? JSONDecoder().decode(Prayer.self, from: data!) else{return}
            

            
            self.array = [["pray":"الفجر","time":post.data.timings.fajr],
                         ["pray":"الظهر","time":post.data.timings.dhuhr],
                         ["pray":"العصر","time":post.data.timings.asr],
                         ["pray":"المغرب","time":post.data.timings.maghrib],
                         ["pray":"العشاء","time":post.data.timings.isha]]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }

}
