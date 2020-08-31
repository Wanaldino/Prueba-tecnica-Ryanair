//
//  FlightSearchPresenterProtocol.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 30/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

protocol FlightSearchPresenterProtocol: class {
    func numberOfSections() -> Int
    func titleForHeaderInSection(_ section: Int) -> String?
    func numberOfRowsInSection(_ section: Int) -> Int
    func modelForCell(at indexPath: IndexPath) -> FlightSearchTableViewCellCase
}
