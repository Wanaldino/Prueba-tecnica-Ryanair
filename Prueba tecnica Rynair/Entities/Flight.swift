//
//  Flight.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 26/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

struct Flight: Codable {
    let time: [String]
    let regularFare: Fare
    let faresLeft: Int
    let timeUTC: [String]
    let duration: String
    let flightNumber: String
    let infantsLeft: Int
    let flightKey: String
    let businessFare: Fare?
}
