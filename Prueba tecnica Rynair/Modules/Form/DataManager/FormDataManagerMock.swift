//
//  FormDataManagerMock.swift
//  Prueba tecnica Rynair
//
//  Created by Carlos Martinez Medina on 23/2/22.
//  Copyright © 2022 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class FormDataManagerMock {
	var stations: [Station]?
}

extension FormDataManagerMock: FormDataManagerProtocol {
	func retrieveStations(completion: @escaping (Result<[Station], Error>) -> Void) {
        let fileURL = Bundle.main.url(forResource: "stationsMock", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)
        let results = try! JSONDecoder().decode(StationsResponse.self, from: data)
        completion(.success(results.stations))
	}

	func retrieveFlight(for requestModel: FlightSearchModel, completion: @escaping (Result<[Trip], Error>) -> Void) {
        let fileURL = Bundle.main.url(forResource: "searchMock", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)
        let results = try! JSONDecoder().decode(FlightSearchResponse.self, from: data)
		completion(.success(results.trips))
	}
}
