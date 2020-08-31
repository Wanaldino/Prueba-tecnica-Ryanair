//
//  FareInfo.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 26/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

struct FareInfo: Codable {
    enum PersonType: String, Codable {
        case adult = "ADT"
        case teen = "TEEN"
        case children = "CHD"
        case unknown
        
        init(from decoder: Decoder) throws {
            self = try PersonType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }
        
        var text: String {
            switch self {
            case .adult:
                return "Adult"
            case .teen:
                return "Teen"
            case .children:
                return "Children"
            case .unknown:
                return ""
            }
        }
    }
    let amount: Double
    let count: Int
    let type: PersonType
    let hasDiscount: Bool
    let publishedFare: Double
}
