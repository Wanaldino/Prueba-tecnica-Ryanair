//
//  StationSelectionPresenter.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

class StationSelectionPresenter {
    weak var view: StationSelectionViewProtocol?
    let interactor: StationInteractorProtocol
    let coordinatorOutput: (Station) -> Void

    var filteredStations = [Station]()
    
    init(interactor: StationInteractorProtocol, coordinatorOutput: @escaping (Station) -> Void) {
		self.interactor = interactor
        self.coordinatorOutput = coordinatorOutput
		getStations()
    }

	lazy var handleStations: ((Result<[Station], Error>) -> Void) = { [weak self] (result) in
		switch result {
		case .success(let stations):
			self?.filteredStations = stations
			self?.view?.update()
		case .failure(_):
			self?.filteredStations = []
			self?.view?.update()
		}
	}

	func filterStations(with text: String) {
		interactor.filterStations(for: text, completion: handleStations)
	}

	func getStations() {
		interactor.getStations(completion: handleStations)
	}
}

extension StationSelectionPresenter: StationSelectionPresenterProtocol {
	func searchDidChange(_ text: String) {
		if text.isEmpty {
			getStations()
		} else {
			filterStations(with: text)
		}
	}
	
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
