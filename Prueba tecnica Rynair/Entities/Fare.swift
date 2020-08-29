//
//  Fare.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 26/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

struct Fare: Codable {
    let fareKey: String
    let fareClass: String
    let fares: [FareInfo]
}
