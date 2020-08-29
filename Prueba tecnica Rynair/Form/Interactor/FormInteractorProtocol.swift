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
    func getOriginStations(completion: ([Station]) -> Void)
    func getDestinationStations(completion: ([Station]) -> Void)
    func didSelectStation(_ station: Station, for type: StationSelectionType)
}
