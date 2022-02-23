//
//  StationSelectionInteractor.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class StationSelectionInteractor {
    let stations: [Station]
    
    init(stations: [Station]) {
        self.stations = stations
    }
}

extension StationSelectionInteractor: StationSelectionInteractorProtocol {
    func getStations(for searchText: String) -> [Station] {
        let searchText = searchText.trimmingCharacters(in: .whitespaces)
        if searchText.isEmpty { return stations }
        return stations.filter({ $0.anyNameContains(string: searchText) })
    }
}
