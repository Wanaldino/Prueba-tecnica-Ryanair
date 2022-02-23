//
//  StationSelectionPresenterProtocol.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

protocol StationSelectionPresenterProtocol: AnyObject {
	func searchDidChange(_ text: String)

    func numberOfRowsInSection(_ section: Int) -> Int
    //To simplify the model the function just retuns the string to show
    func modelForCell(at indexPath: IndexPath) -> String
    func didSelectStation(at indexPath: IndexPath)
}
