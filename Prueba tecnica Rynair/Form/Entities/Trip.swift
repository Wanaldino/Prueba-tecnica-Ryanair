//
//  Trip.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 26/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

struct Trip: Codable {
    let origin: String
    let destination: String
    let dates: [TripDate]
}
