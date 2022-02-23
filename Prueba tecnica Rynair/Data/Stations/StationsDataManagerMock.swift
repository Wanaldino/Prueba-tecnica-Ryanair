//
//  StationsDataManagerMock.swift
//  Prueba tecnica Rynair
//
//  Created by Carlos Martinez Medina on 23/2/22.
//  Copyright © 2022 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class StationsDataManagerMock {
	var cache: StationsLocalCache

	init(cache: StationsLocalCache) {
		self.cache = cache
	}
}

extension StationsDataManagerMock: StationsDataManagerProtocol {
	func retrieveStations(completion: @escaping (Result<[Station], Error>) -> Void) {
		if let stations = cache.getStations() {
			completion(.success(stations))
		} else {
			DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
				let fileURL = Bundle.main.url(forResource: "stationsMock", withExtension: "json")!
				let data = try! Data(contentsOf: fileURL)
				let results = try! JSONDecoder().decode(StationsResponse.self, from: data)

				DispatchQueue.main.async { [weak self] in
					self?.cache.saveStations(results.stations)
					// We should take care of that failure error
					guard let stations = self?.cache.getStations() else { return completion(.failure(NSError())) }
					completion(.success(stations))
				}
			}
		}
	}
}
