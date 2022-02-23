//
//  StationsDataManager.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 26/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class StationsDataManager {
    var stations: [Station]?
}

extension StationsDataManager: StationsDataManagerProtocol {
    func retrieveStations(completion: @escaping (Result<[Station], Error>) -> Void) {
        if let stations = stations {
            completion(.success(stations))
        } else if let url = URL(string: "https://tripstest.ryanair.com/static/stations.json") {
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return completion(.failure(NSError())) }
                if let data = try? Data(contentsOf: url),
                    let results = try? JSONDecoder().decode(StationsResponse.self, from: data) {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return completion(.failure(NSError())) }
                        self.stations = results.stations
                        completion(.success(results.stations))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NSError()))
                    }
                }
            }
        }
    }
}
