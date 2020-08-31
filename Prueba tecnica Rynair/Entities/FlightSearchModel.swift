//
//  FlightSearchModel.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 30/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

struct FlightSearchModel {
    private let baseUrl = "https://tripstest.ryanair.com/api/v4/Availability"
    let origin: String
    let destination: String
    let dateout: Date
    let adults: Int
    let teens: Int
    let children: Int
    
    private func dateAsQueryItem() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: dateout)
    }
    
    var url: URL? {
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = [
            .init(name: "origin", value: origin),
            .init(name: "destination", value: destination),
            .init(name: "dateout", value: dateAsQueryItem()),
            .init(name: "adt", value: String(adults)),
            .init(name: "teen", value: String(teens)),
            .init(name: "chd", value: String(children))
        ]
        return urlComponents?.url
    }
}
