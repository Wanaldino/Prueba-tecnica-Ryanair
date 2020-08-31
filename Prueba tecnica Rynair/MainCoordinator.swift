//
//  MainCoordinator.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    let navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        goToForm()
    }
    
    func goToForm() {
        let viewController = FormBuilder(coordinatorOutput: { [weak self] (output) in
            guard let self = self else { return }
            switch output {
            case .selectStation(let stations, let didSelect):
                self.goToSelectStation(stations: stations, didSelect: didSelect)
            case .showSearch(let trips):
                self.goToSearchResults(trips: trips)
            }
        }).build()
        navigator.pushViewController(viewController, animated: true)
    }
    
    func goToSelectStation(stations: [Station], didSelect: @escaping (Station) -> Void) {
        let viewController = StationSelectionBuilder(stations: stations, coordinatorOutput: { [weak self] station in
            guard let self = self else { return }
            didSelect(station)
            self.navigator.dismiss(animated: true)
        }).build()
        navigator.present(viewController, animated: true)
    }
    
    func goToSearchResults(trips: [Trip]) {
        let viewController = FlightSearchBuilder(trips: trips).build()
        navigator.pushViewController(viewController, animated: true)
    }
}
