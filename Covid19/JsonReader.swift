//
//  JsonReader.swift
//  Covid19
//
//  Created by Jung-Hua Liu on 2020/12/9.
//

import Foundation


struct Response: Decodable {
    var objectIdFieldName: String
    var uniqueIdField:uniqueIdFieldData
    var globalIdFieldName: String
    var geometryProperties: [String: String]
    var geometryType: String
    var spatialReference: [String: Int]
    var fields:[[String: String?]]
    var features: [Features]
}

struct Features: Decodable {
    var attributes:  [String: Float]
    var geometry: [String: [[[Float]]]]
}

struct uniqueIdFieldData: Decodable {
    var name:  String
    var isSystemMaintained: Bool
}

class FetchData: ObservableObject {
    @Published var features = [Features]()
    init() {
        
        fetchData()
        let date = Date().addingTimeInterval(0)
        let timer = Timer(fireAt: date, interval: 30, target: self, selector: #selector(fetchData), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    
    @objc func fetchData(){
        let latitude =  UserDefaults.standard.value(forKey: "latitude") ?? "0.0"
        let longitude = UserDefaults.standard.value(forKey: "longitude") ?? "0.0"
        let apiString = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=OBJECTID,cases7_per_100k&geometry=\(latitude),\(longitude)&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=json"
        
        guard let url = URL(string: apiString) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.features = decodedResponse.features
                    }
                    return
                }
            }
            //if we failed to obtain correct json file, we call this function after 10s
            let date = Date().addingTimeInterval(0)
            let timer = Timer(fireAt: date, interval: 10, target: self, selector: #selector(self.fetchData), userInfo: nil, repeats: false)
            RunLoop.main.add(timer, forMode: .common)
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
