//
//  FareInfo.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 26/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

struct FareInfo: Codable {
    let amount: Double
    let count: Int
    let type: String
    let hasDiscount: Bool
    let publishedFare: Double
}
