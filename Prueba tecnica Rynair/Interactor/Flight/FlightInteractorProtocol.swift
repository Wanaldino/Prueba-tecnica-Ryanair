//
//  FlightInteractorProtocol.swift
//  Prueba tecnica Rynair
//
//  Created by Carlos Martinez Medina on 23/2/22.
//  Copyright © 2022 Carlos Martinez Medina. All rights reserved.
//

import Foundation

protocol FlightInteractorProtocol: AnyObject {
	func searchFlight(with model: FlightSearchModel, completion: @escaping (Result<[Trip], Error>) -> Void)
}
