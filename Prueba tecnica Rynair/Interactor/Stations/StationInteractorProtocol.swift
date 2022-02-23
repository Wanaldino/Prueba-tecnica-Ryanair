//
//  StationInteractorProtocol.swift
//  Prueba tecnica Rynair
//
//  Created by Carlos Martinez Medina on 23/2/22.
//  Copyright © 2022 Carlos Martinez Medina. All rights reserved.
//

import Foundation

protocol StationInteractorProtocol: AnyObject {
	func getStations(completion: @escaping (Result<[Station], Error>) -> Void)
	func getDestinations(for station: Station, completion: @escaping (Result<[Station], Error>) -> Void)
}
