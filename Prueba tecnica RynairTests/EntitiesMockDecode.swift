//
//  FormEntitiesMockDecode.swift
//  Prueba tecnica RynairTests
//
//  Created by Wanaldino Antimonio on 26/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import XCTest
@testable import Prueba_tecnica_Rynair

class FormEntitiesMockDecode: XCTestCase {
    func testDecodeStations() throws {
        let fileURL = Bundle.main.url(forResource: "stationsMock", withExtension: "json")!
        let data = try Data(contentsOf: fileURL)
        _ = try JSONDecoder().decode(StationsResponse.self, from: data)
    }
    
    func testDecodeFlightSearch() throws {
        let fileURL = Bundle.main.url(forResource: "searchMock", withExtension: "json")!
        let data = try Data(contentsOf: fileURL)
        _ = try JSONDecoder().decode(FlightSearchResponse.self, from: data)
    }
}
