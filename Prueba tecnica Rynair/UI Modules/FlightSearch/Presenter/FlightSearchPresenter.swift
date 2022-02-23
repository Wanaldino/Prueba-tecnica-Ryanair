//
//  FlightSearchPresenter.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 30/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class FlightSearchPresenter {
    let trip: Trip
    
    init(trips: [Trip]) {
        //As I don't know how this trips array work, I asume tha first value is the data to choose flights from origin to destination.
        self.trip = trips.first!
    }
}

extension FlightSearchPresenter: FlightSearchPresenterProtocol {
    func numberOfSections() -> Int {
        max(1, trip.dates.count)
    }
    
    func titleForHeaderInSection(_ section: Int) -> String? {
        trip.dates[section].flights.isEmpty ? nil : trip.dates[section].dateOut.transformDate(from: "yyyy-MM-dd'T'HH:mm:ss.SSS", to: "d MMM, yyyy")
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        max(1, trip.dates[section].flights.count)
    }
    
    func modelForCell(at indexPath: IndexPath) -> FlightSearchTableViewCellCase {
        if trip.dates[indexPath.section].flights.isEmpty {
            return .noResults("No results")
        } else {
            let flight = trip.dates[indexPath.section].flights[indexPath.row]
            
            return .result(.init(
                originDate: flight.time.first?.transformDate(from: "yyyy-MM-dd'T'HH:mm:ss.SSS", to: "HH:mm") ?? "",
                originStation: trip.origin,
                flightTime: flight.duration,
                flightCode: flight.flightNumber,
                destinationDate: flight.time.last?.transformDate(from: "yyyy-MM-dd'T'HH:mm:ss.SSS", to: "HH:mm") ?? "",
                destinationStation: trip.destination,
                price: flight.regularFare.fares.compactMap({ String(format: "%@: %@", $0.type.text, $0.amount.description.appending("€")) }).joined(separator: " - ")
            ))
        }
    }
}
