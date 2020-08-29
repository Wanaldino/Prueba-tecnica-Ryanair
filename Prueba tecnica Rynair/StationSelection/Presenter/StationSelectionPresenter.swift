//
//  StationSelectionPresenter.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

class StationSelectionPresenter: NSObject {
    weak var view: StationSelectionViewProtocol?
    let interactor: StationSelectionInteractorProtocol
    let coordinatorOutput: (Station) -> Void
    var searchText = String()
    var filteredStations: [Station]
    
    init(interactor: StationSelectionInteractorProtocol, coordinatorOutput: @escaping (Station) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinatorOutput
        self.filteredStations = interactor.getStations(for: searchText)
    }
}

extension StationSelectionPresenter {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        self.filteredStations = interactor.getStations(for: searchText)
        self.view?.update()
    }
}

extension StationSelectionPresenter: StationSelectionPresenterProtocol {
    func numberOfRowsInSection(_ section: Int) -> Int {
        max(filteredStations.count, 1)
    }
    
    func modelForCell(at indexPath: IndexPath) -> String {
        filteredStations.count == 0 ? "No results" : filteredStations[indexPath.row].name
    }
    
    func didSelectStation(at indexPath: IndexPath) {
        if filteredStations.isEmpty { return }
        coordinatorOutput(filteredStations[indexPath.row])
    }
}
