//
//  ViewController.swift
//  PrayerTimeApp
//
//  Created by AlenaziHazal on 06/02/1444 AH.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableViewMain: UITableView!
    @IBOutlet weak var imageMine: UIImageView!
    var prayTime:Array<Dictionary<String,String>> = []
    var prayTime1:[Datum] = []
    var ishaHolder = ""
    var dhr = ""
    var fjr = ""
    var asr = ""
    var mgr = ""
    var asha = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        imageMine.layer.cornerRadius = imageMine.frame.width / 2
        imageMine.image = UIImage(named: "1")
        // Do any additional setup after loading the view.
        json()
        print("\(self.ishaHolder)")
        //print(prayTime1[0].timings.isha)
        tableViewMain.dataSource = self
        tableViewMain.delegate = self
        tableViewMain.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cellMain")
        tableViewMain.layer.cornerRadius = 40
    }
    func json(){
        
        //Step1
        let stringUrl = "https://api.aladhan.com/v1/hijriCalendarByCity?city=Riyadh&country=SaudiArabia&method=4&month=02&year=1444"
        guard let url = URL(string: stringUrl) else{
            print("Crash Here")
            return}
        //Step2
        let check = URLSession.shared.dataTask(with: url) { data, respone, erorr in
            guard erorr == nil else {
                print(erorr?.localizedDescription as Any)
                return
            }
            guard let respone = respone as? HTTPURLResponse else{
                print("Can't found respone")
                return
            }
            guard respone.statusCode >= 200
                    && respone.statusCode <= 299 else {
                print("Statuse Code Should be XXX, Butthe code is \(respone.statusCode)")
                return
            }
            let jsonString = String(data: data!, encoding: .utf8)
    //        print("sandand:\( jsonString!)")
            guard let json = try? JSONDecoder().decode(Welcome.self, from: data!) else {print("CrashHere")
                return}
            print("---------------------------------\(json.data[0].timings)")
            let jsonStrings = json.data[0].timings.isha
            print("--\(jsonStrings)")
            DispatchQueue.main.async {
                self.prayTime1 = json.data
                print(self.prayTime1[0].timings.isha)
                self.tableViewMain.reloadData()
            }
        }
        check.resume()
    }


}
extension ViewController: UITableViewDelegate{
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayTime1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain", for: indexPath) as! TableViewCell
        
        cell.nameCity.text = prayTime1[indexPath.row].date.gregorian.weekday.en
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fjr = prayTime1[indexPath.row].timings.fajr
        asr = prayTime1[indexPath.row].timings.asr
        dhr = prayTime1[indexPath.row].timings.dhuhr
        asha = prayTime1[indexPath.row].timings.isha
        mgr = prayTime1[indexPath.row].timings.maghrib
        performSegue(withIdentifier: "show", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show"{
            if let send = segue.destination as? SecondViewController {
                send.dhr1 = dhr
                send.fjr2 = fjr
                send.asr3 = asr
                send.mgr4 = mgr
                send.asha5 = asha
            }
        }
    }
    
}

// MARK: - Welcome
struct Welcome: Codable {
    let code: Int
    let status: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let timings: Timings
    let date: DateClass
    let meta: Meta
}

// MARK: - DateClass
struct DateClass: Codable {
    let readable, timestamp: String
    let gregorian: Gregorian
    let hijri: Hijri
}

// MARK: - Gregorian
struct Gregorian: Codable {
    let date: String
    let format: Format
    let day: String
    let weekday: GregorianWeekday
    let month: GregorianMonth
    let year: String
    let designation: Designation
}

// MARK: - Designation
struct Designation: Codable {
    let abbreviated: Abbreviated
    let expanded: Expanded
}

enum Abbreviated: String, Codable {
    case ad = "AD"
    case ah = "AH"
}

enum Expanded: String, Codable {
    case annoDomini = "Anno Domini"
    case annoHegirae = "Anno Hegirae"
}

enum Format: String, Codable {
    case ddMmYyyy = "DD-MM-YYYY"
}

// MARK: - GregorianMonth
struct GregorianMonth: Codable {
    let number: Int
    let en: PurpleEn
}

enum PurpleEn: String, Codable {
    case august = "August"
    case september = "September"
}

// MARK: - GregorianWeekday
struct GregorianWeekday: Codable {
    let en: String
}

// MARK: - Hijri
struct Hijri: Codable {
    let date: String
    let format: Format
    let day: String
    let weekday: HijriWeekday
    let month: HijriMonth
    let year: String
    let designation: Designation
    let holidays: [JSONAny]
}

// MARK: - HijriMonth
struct HijriMonth: Codable {
    let number: Int
    let en: FluffyEn
    let ar: Ar
}

enum Ar: String, Codable {
    case صفر = "صَفَر"
}

enum FluffyEn: String, Codable {
    case ṣafar = "Ṣafar"
}

// MARK: - HijriWeekday
struct HijriWeekday: Codable {
    let en, ar: String
}

// MARK: - Meta
struct Meta: Codable {
    let latitude, longitude: Double
    let timezone: Timezone
    let method: Method
    let latitudeAdjustmentMethod: LatitudeAdjustmentMethod
    let midnightMode, school: MidnightMode
    let offset: [String: Int]
}

enum LatitudeAdjustmentMethod: String, Codable {
    case angleBased = "ANGLE_BASED"
}

// MARK: - Method
struct Method: Codable {
    let id: Int
    let name: Name
    let params: Params
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double
}

enum Name: String, Codable {
    case ummAlQuraUniversityMakkah = "Umm Al-Qura University, Makkah"
}

// MARK: - Params
struct Params: Codable {
    let fajr: Double
    let isha: Isha

    enum CodingKeys: String, CodingKey {
        case fajr = "Fajr"
        case isha = "Isha"
    }
}

enum Isha: String, Codable {
    case the90Min = "90 min"
}

enum MidnightMode: String, Codable {
    case standard = "STANDARD"
}

enum Timezone: String, Codable {
    case asiaRiyadh = "Asia/Riyadh"
}

// MARK: - Timings
struct Timings: Codable {
    let fajr, sunrise, dhuhr, asr: String
    let sunset, maghrib, isha, imsak: String
    let midnight, firstthird: String
    let lastthird: Lastthird

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

enum Lastthird: String, Codable {
    case the014403 = "01:44 (+03)"
    case the014503 = "01:45 (+03)"
    case the014603 = "01:46 (+03)"
    case the014703 = "01:47 (+03)"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
