//
//  FormInteractorTest.swift
//  Prueba tecnica RynairTests
//
//  Created by Wanaldino Antimonio on 31/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import XCTest
@testable import Prueba_tecnica_Rynair

class FormInteractorTest: XCTestCase {
    var interactor: FormInteractor!
    
    override func setUp() {
        super.setUp()
        interactor = FormInteractor(dataManager: FormDataManager())
    }
    
    func testDidSelectSameOriginStation() {
        let fileURL = Bundle.main.url(forResource: "stationsMock", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)
        let results = try! JSONDecoder().decode(StationsResponse.self, from: data)
        
        let originStation = results.stations[0]
        let destinationStation = results.stations[1]
        interactor.selectedOriginStation = originStation
        interactor.selectedDestinationStation = destinationStation
        
        interactor.didSelectStation(originStation, for: .originStation)
        
        XCTAssertNotNil(interactor.selectedDestinationStation)
    }
    
    func testDidSelectDifferentOriginStation() {
        let fileURL = Bundle.main.url(forResource: "stationsMock", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)
        let results = try! JSONDecoder().decode(StationsResponse.self, from: data)
        
        let originStation = results.stations[0]
        let destinationStation = results.stations[1]
        interactor.selectedOriginStation = originStation
        interactor.selectedDestinationStation = destinationStation
        
        let newStation = results.stations[2]
        interactor.didSelectStation(newStation, for: .originStation)
        
        XCTAssertNil(interactor.selectedDestinationStation)
    }
}
