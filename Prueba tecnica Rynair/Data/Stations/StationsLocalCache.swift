//
//  StationsLocalCache.swift
//  Prueba tecnica Rynair
//
//  Created by Carlos Martinez Medina on 23/2/22.
//  Copyright © 2022 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class StationsLocalCache {
	static let `default` = StationsLocalCache()
	private init() {}

	var stations: [Station]?

	func saveStations(_ stations: [Station]) {
		self.stations = stations
	}

	func getStations() -> [Station]? {
		stations
	}
}
