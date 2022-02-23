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
}

extension FormDataManager: FormDataManagerProtocol {
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
    
    func retrieveFlight(for requestModel: FlightSearchModel, completion: @escaping (Result<[Trip], Error>) -> Void) {
        var urlRequest = URLRequest(url: requestModel.url!)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        let task = URLSession(configuration: .default).dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data, let results = try? JSONDecoder().decode(FlightSearchResponse.self, from: data) {
                    completion(.success(results.trips))
                } else {
                    completion(.failure(NSError()))
                }
            }
        }

        task.resume()
    }
}
