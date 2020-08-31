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
    func getOriginStations(completion: @escaping (Result<[Station], Error>) -> Void) {
        dataManager.retrieveStations(completion: completion)
    }
    
    func getDestinationStations(completion: @escaping (Result<[Station], Error>) -> Void) {
        dataManager.retrieveStations { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let stations):
                let filteredStations = stations.filter { (station) -> Bool in
                    station.markets.filter { (market) -> Bool in
                        market.code == self.selectedOriginStation?.code
                    }.isNotEmpty
                }
                completion(.success(filteredStations))
            case .failure(let error):
                completion(.failure(error))
            }
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
    
    func searchFlight(date: Date, adults: Int, teens: Int, children: Int, completion: @escaping (Result<[Trip], Error>) -> Void) {
        guard let originCode = selectedOriginStation?.code, let destinationCode = selectedDestinationStation?.code else { return }
        let requestModel = FlightSearchModel(
            origin: originCode,
            destination: destinationCode,
            dateout: date,
            adults: adults,
            teens: teens,
            children: children
        )
        dataManager.retrieveFlight(for: requestModel) { (result) in
            switch result {
            case .success(let trips):
                completion(.success(trips))
            case .failure(let error):
                //Handle server error to transform it into something the presenter can understand as text, cases of error or whatever
                completion(.failure(error))
                break
            }
        }
    }
}
