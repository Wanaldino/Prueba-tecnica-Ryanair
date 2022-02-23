//
//  FormBuilder.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

class FormBuilder: Builder {
    let coordinatorOutput: (FormOutput) -> Void
    
    init(coordinatorOutput: @escaping (FormOutput) -> Void) {
        self.coordinatorOutput = coordinatorOutput
    }
    
    func build() -> UIViewController {
		let stationsManager = StationsDataManagerMock(cache: StationsLocalCache.default)
		let stationsInteractor = StationInteractor(dataManager: stationsManager)
		let flightDataManager = FlightsDataManagerMock.default
		let flightInteractor = FlightInteractor(dataManager: flightDataManager)
		let presenter = FormPresenter(
			stationsInteractor: stationsInteractor,
			flightInteractor: flightInteractor,
			coordinatorOutput: coordinatorOutput
		)
        let viewController = FormViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}
