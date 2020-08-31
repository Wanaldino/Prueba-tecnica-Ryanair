//
//  FormInteractorProtocol.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

protocol FormInteractorProtocol: class {
    var selectedOriginStation: Station? { get }
    var selectedDestinationStation: Station? { get }
    func getOriginStations(completion: @escaping (Result<[Station], Error>) -> Void)
    func getDestinationStations(completion: @escaping (Result<[Station], Error>) -> Void)
    func didSelectStation(_ station: Station, for type: StationSelectionType)
    func searchFlight(date: Date, adults: Int, teens: Int, children: Int, completion: @escaping (Result<[Trip], Error>) -> Void)
}
