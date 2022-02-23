//
//  StationInteractor.swift
//  Prueba tecnica Rynair
//
//  Created by Carlos Martinez Medina on 23/2/22.
//  Copyright © 2022 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class StationInteractor {
	let dataManager: FormDataManagerProtocol

	init(dataManager: FormDataManagerProtocol) {
		self.dataManager = dataManager
	}
}

extension StationInteractor: StationInteractorProtocol {
	func getStations(completion: @escaping (Result<[Station], Error>) -> Void) {
		dataManager.retrieveStations(completion: completion)
	}

	func getDestinations(for station: Station, completion: @escaping (Result<[Station], Error>) -> Void) {
		dataManager.retrieveStations { (result) in
			switch result {
			case .success(let stations):
				let filteredStations = stations.filter { (station) -> Bool in
					station.markets.filter { (market) -> Bool in
						market.code == station.code
					}.isNotEmpty
				}
				completion(.success(filteredStations))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
