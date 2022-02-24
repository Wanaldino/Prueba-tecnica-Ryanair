//
//  StationSelectionBuilder.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

class StationSelectionBuilder: Builder {
    let stations: [Station]
    let coordinatorOutput: (Station) -> Void
    
    init(stations: [Station], coordinatorOutput: @escaping (Station) -> Void) {
        self.stations = stations
        self.coordinatorOutput = coordinatorOutput
    }
    
    func build() -> UIViewController {
		let cache = StationsLocalCache(stations: stations)
		let dataManager = StationsDataManagerMock(cache: cache)
        let interactor = StationInteractor(dataManager: dataManager)
        let presenter = StationSelectionPresenter(interactor: interactor, coordinatorOutput: coordinatorOutput)
        let viewController = StationSelectionViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}

enum StationSelectionType {
    case originStation
    case destinationStation
}
