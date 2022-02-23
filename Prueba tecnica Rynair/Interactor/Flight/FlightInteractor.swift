//
//  FlightInteractor.swift
//  Prueba tecnica Rynair
//
//  Created by Carlos Martinez Medina on 23/2/22.
//  Copyright © 2022 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class FlightInteractor {
	let dataManager: FormDataManagerProtocol

	init(dataManager: FormDataManagerProtocol) {
		self.dataManager = dataManager
	}
}

extension FlightInteractor: FlightInteractorProtocol {
	func searchFlight(with model: FlightSearchModel, completion: @escaping (Result<[Trip], Error>) -> Void) {
		dataManager.retrieveFlight(for: model) { (result) in
			switch result {
			case .success(let trips):
				completion(.success(trips))
			case .failure(let error):
				//Handle server error to transform it into something the presenter can understand as text, cases of error or whatever
				completion(.failure(error))
				break
			}
		}
	}
}
