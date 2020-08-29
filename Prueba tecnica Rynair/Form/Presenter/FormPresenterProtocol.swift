//
//  FormPresenterProtocol.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

protocol FormPresenterProtocol: class {
    func viewDidLoad()
    func didTapOriginStation()
    func didTapDestinationStation()
    func didSelectDepartureDate(_ date: Date)
    func didChangeSelectedAdults(newValue: Double)
    func didChangeSelectedTeens(newValue: Double)
    func didChangeSelectedChildren(newValue: Double)
    func didTapSearch()
}
