//
//  Stations.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 26/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

struct Station: Codable {
    let alias: [String]
    let alternateName: String?
    let code: String
    let countryAlias: String?
    let countryCode: String
    let countryGroupCode: String
    let countryName: String
    let latitude:String
    let longitude: String
    let markets: [Market]
    let mobileBoardingPass: Bool
    let name: String
    let notices: String?
    let timeZoneCode: String
}
