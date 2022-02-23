//
//  StationsDataManager.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 26/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class StationsDataManager {
	var cache: StationsLocalCache

	init(cache: StationsLocalCache) {
		self.cache = cache
	}

	func fetchStations() {

	}
}

extension StationsDataManager: StationsDataManagerProtocol {
    func retrieveStations(completion: @escaping (Result<[Station], Error>) -> Void) {
        if let stations = cache.getStations() {
            completion(.success(stations))
        } else if let url = URL(string: "https://tripstest.ryanair.com/static/stations.json") {
			DispatchQueue.global().async { [weak self] in
				if let data = try? Data(contentsOf: url),
					let results = try? JSONDecoder().decode(StationsResponse.self, from: data) {
					DispatchQueue.main.async { [weak self] in
						self?.cache.saveStations(results.stations)
						// We should take care of that failure error
						guard let stations = self?.cache.getStations() else { return completion(.failure(NSError())) }
						completion(.success(stations))
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
