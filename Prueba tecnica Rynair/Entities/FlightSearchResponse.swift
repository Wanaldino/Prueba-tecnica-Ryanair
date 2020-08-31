//
//  FlightSearchResponse.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 26/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

struct FlightSearchResponse: Codable {
    let termsOfUse: String
    let currency: String
    let serverTimeUTC: String
    let currPrecision: Int
    let routeGroup: String
    let tripType: String
    let upgradeType: String
    let trips: [Trip]
}
