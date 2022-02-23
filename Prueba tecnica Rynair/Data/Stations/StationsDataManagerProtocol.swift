//
//  StationsDataManagerProtocol.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

protocol StationsDataManagerProtocol {
    func retrieveStations(completion: @escaping (Result<[Station], Error>) -> Void)
}
