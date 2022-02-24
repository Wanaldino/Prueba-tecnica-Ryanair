//
//  StationInteractor.swift
//  Prueba tecnica Rynair
//
//  Created by Carlos Martinez Medina on 23/2/22.
//  Copyright © 2022 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class StationInteractor {
	let dataManager: StationsDataManagerProtocol

	init(dataManager: StationsDataManagerProtocol) {
		self.dataManager = dataManager
	}
}

extension StationInteractor: StationInteractorProtocol {
	func getStations(completion: @escaping (Result<[Station], Error>) -> Void) {
		dataManager.retrieveStations(completion: completion)
	}

	func filterStations(for name: String, completion: @escaping (Result<[Station], Error>) -> Void) {
		getStations { result in
			switch result {
			case .success(let stations):
				let searchText = name.trimmingCharacters(in: .whitespaces)
				if searchText.isEmpty { return completion(.success([])) }
				let stations = stations.filter({ $0.anyNameContains(string: searchText) })
				completion(.success(stations))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	func getDestinations(for originStation: Station, completion: @escaping (Result<[Station], Error>) -> Void) {
		getStations { (result) in
			switch result {
			case .success(let stations):
				let filteredStations = stations.filter { (station) -> Bool in
					station.markets.filter { (market) -> Bool in
						market.code == originStation.code
					}.isNotEmpty
				}
				completion(.success(filteredStations))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
