//
//  ViewController.swift
//  PrayerTimesAPI
//
//  Created by Anaal Albeeshi on 08/02/1444 AH.
//

import UIKit

class ViewController: UIViewController {
    
    // var mydata = [MyData]()
    
    var countElment = 0
    var mydata: [[String:Any]] = []
    
    @IBOutlet weak var tableView_1: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView_1.delegate = self
        tableView_1.dataSource = self
        // tableView_1.backgroundView
        tableView_1.register(UINib(nibName: "CellATableViewCell", bundle: nil), forCellReuseIdentifier: "CellA")
        
//
//        readJsonFile(fileName: "MyData") {
//            myArray in for x in myArray {
//                print(x)
//            }
//        }
    
    }


}// end of Class

func fetchPost(){
    // 1. Step One
    let stringURL = "https://jsonplaceholder.typicode.com/posts/3"
    guard let url = URL(string: stringURL) else {return}
    
    // 2. Step two
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // يعطي رسالة عند حدوث الخطا في الاستجابة
        guard error == nil else {return
            print(error?.localizedDescription)
        }
        
        guard let response = response as? HTTPURLResponse else {
            print("Invalid Response!!")
            return}
        
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            print("Statuse Code Should Be 2xx, but the code is \(response.statusCode)")
            return
        }
        print("SUCCSSFULY Get DATA ✅")
//            print("Data: \(data)") //عشان اعرف حجم الداتا اللي موجودة عندي
//
//            let jsonString = String(data: data!, encoding: .utf8)
//            print("MY JSON STRING IS 📍 \(jsonString!)")
        
    guard let post = try? JSONDecoder().decode(Welcome.self, from: data!) else {return}
        print(post.data)
    }
        //  الكود الان مايطبع شي لازم نسوب ريزم من خلال
    task.resume()
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
    let date: DateClass
    let meta: Meta
}

// MARK: - DateClass
struct DateClass: Codable {
    let readable, timestamp: String
    let hijri: Hijri
    let gregorian: Gregorian
}

// MARK: - Gregorian
struct Gregorian: Codable {
    let date, format, day: String
    let weekday: GregorianWeekday
    let month: GregorianMonth
    let year: String
    let designation: Designation
}

// MARK: - Designation
struct Designation: Codable {
    let abbreviated, expanded: String
}

// MARK: - GregorianMonth
struct GregorianMonth: Codable {
    let number: Int
    let en: String
}

// MARK: - GregorianWeekday
struct GregorianWeekday: Codable {
    let en: String
}

// MARK: - Hijri
struct Hijri: Codable {
    let date, format, day: String
    let weekday: HijriWeekday
    let month: HijriMonth
    let year: String
    let designation: Designation
    let holidays: [JSONAny]
}

// MARK: - HijriMonth
struct HijriMonth: Codable {
    let number: Int
    let en, ar: String
}

// MARK: - HijriWeekday
struct HijriWeekday: Codable {
    let en, ar: String
}

// MARK: - Meta
struct Meta: Codable {
    let latitude, longitude: Double
    let timezone: String
    let method: Method
    let latitudeAdjustmentMethod, midnightMode, school: String
    let offset: [String: Int]
}

// MARK: - Method
struct Method: Codable {
    let id: Int
    let name: String
    let params: Params
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double
}

// MARK: - Params
struct Params: Codable {
    let fajr: Int
    let isha: String

    enum CodingKeys: String, CodingKey {
        case fajr = "Fajr"
        case isha = "Isha"
    }
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



//func readJsonFile(fileName: String, complation:([[String:Any]]) -> ()) -> [[String:Any]]{
//    let path = Bundle.main.path(forResource: fileName, ofType: "json")!
//    do{
//        let data = try Data(contentsOf: URL(fileURLWithPath: path),options:.alwaysMapped)
//
//    let json = try JSONSerialization.jsonObject(with: data) as! [[String:Any]]
//
//        complation(json)
//        return json
//    }catch var errorTest {
//        print(errorTest )
//    }
//    return []
//}



extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countElment  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_1.dequeueReusableCell(withIdentifier: "CellA", for: indexPath) as! CellATableViewCell
        
        
        return cell
    }
    
    
    
}

