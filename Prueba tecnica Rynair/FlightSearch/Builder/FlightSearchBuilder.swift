//
//  FlightSearchBuilder.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 30/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

class FlightSearchBuilder: Builder {
    let trips: [Trip]
    
    init(trips: [Trip]) {
        self.trips = trips
    }
    
    func build() -> UIViewController {
        let presenter = FlightSearchPresenter(trips: trips)
        let viewController = FlightSearchViewController(presenter: presenter)
        return viewController
    }
}
