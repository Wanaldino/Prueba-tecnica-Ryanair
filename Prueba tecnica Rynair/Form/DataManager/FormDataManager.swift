//
//  FormDataManager.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 26/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class FormDataManager {
    var stations: [Station]?
    
    func retrieveStations(completion: ([Station]) -> Void) {
//        let fileURL = Bundle.main.url(forResource: "stationsMock", withExtension: "json")!
//        let data = try! Data(contentsOf: fileURL)
//        let results = try! JSONDecoder().decode(StationsResponse.self, from: data)
//
//        completion(results)
//        print(results)
        
        if let stations = stations {
            completion(stations)
        } else if
            let url = URL(string: "https://tripstest.ryanair.com/static/stations.json"),
            let data = try? Data(contentsOf: url),
            let results = try? JSONDecoder().decode(StationsResponse.self, from: data)
        {
            stations = results.stations
            completion(results.stations)
        }
    }
}
