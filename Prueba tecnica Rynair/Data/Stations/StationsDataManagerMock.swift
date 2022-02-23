//
//  StationsDataManagerMock.swift
//  Prueba tecnica Rynair
//
//  Created by Carlos Martinez Medina on 23/2/22.
//  Copyright © 2022 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class StationsDataManagerMock {
	static let `default` = StationsDataManagerMock()
	var stations: [Station]?
}

extension StationsDataManagerMock: StationsDataManagerProtocol {
	func retrieveStations(completion: @escaping (Result<[Station], Error>) -> Void) {
		if let stations = stations {
			completion(.success(stations))
		} else {
			DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
				let fileURL = Bundle.main.url(forResource: "stationsMock", withExtension: "json")!
				let data = try! Data(contentsOf: fileURL)
				let results = try! JSONDecoder().decode(StationsResponse.self, from: data)

				DispatchQueue.main.async {
					self.stations = results.stations
					completion(.success(results.stations))
				}
			}
		}
	}
}
