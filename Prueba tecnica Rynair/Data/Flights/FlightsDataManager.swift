//
//  FlightsDataManager.swift
//  Prueba tecnica Rynair
//
//  Created by Carlos Martinez Medina on 23/2/22.
//  Copyright © 2022 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class FlightsDataManager {
	var stations: [Station]?
}

extension FlightsDataManager: FlightsDataManagerProtocol {
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
