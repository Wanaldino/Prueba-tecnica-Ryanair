//
//  FormInteractor.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class FormInteractor {
    let dataManager: FormDataManagerProtocol
    var selectedOriginStation: Station?
    var selectedDestinationStation: Station?
    
    init(dataManager: FormDataManagerProtocol) {
        self.dataManager = dataManager
    }
}

extension FormInteractor: FormInteractorProtocol {
    func getOriginStations(completion: ([Station]) -> Void) {
        dataManager.retrieveStations(completion: completion)
    }
    
    func getDestinationStations(completion: ([Station]) -> Void) {
        dataManager.retrieveStations { [weak self] (stations) in
            guard let self = self else { return }
            let filteredStations = stations.filter { (station) -> Bool in
                station.markets.filter { (market) -> Bool in
                    market.code == self.selectedOriginStation?.code
                }.isNotEmpty
            }
            completion(filteredStations)
        }
    }
    
    func didSelectStation(_ station: Station, for type: StationSelectionType) {
        switch type {
        case .originStation:
            if selectedDestinationStation?.code == station.code { return }
            selectedOriginStation = station
            selectedDestinationStation = nil
        case .destinationStation:
            selectedDestinationStation = station
        }
    }
}
