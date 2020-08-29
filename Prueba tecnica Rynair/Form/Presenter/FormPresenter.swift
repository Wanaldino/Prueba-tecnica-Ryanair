//
//  FormPresenter.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class FormPresenter {
    weak var view: FormViewProtocol?
    let interactor: FormInteractorProtocol
    let coordinatorOutput: (FormOutput) -> Void
    
    var selectedDate: Date?
    var selectedAdults: Double = 1
    var selectedTeens: Double = 0
    var selectedChildren: Double = 0
    
    init(interactor: FormInteractorProtocol, coordinatorOutput: @escaping (FormOutput) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinatorOutput
    }
    
    var viewModel: FormViewModel {
        var date: String? = nil
        if let selectedDate = selectedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            date = dateFormatter.string(from: selectedDate)
        }
        
        let selectedAdults = Int(self.selectedAdults)
        let selectedTeens = Int(self.selectedTeens)
        let selectedChildren = Int(self.selectedChildren)
        let searchButtonEnable = interactor.selectedOriginStation != nil && interactor.selectedDestinationStation != nil && selectedDate != nil
        
        return FormViewModel(
            originStation: interactor.selectedOriginStation?.name,
            destinationStation: interactor.selectedDestinationStation?.name,
            departureDate: date,
            adultsText: String(format: "%i adults", selectedAdults),
            teensText: String(format: "%i teens", selectedTeens),
            childrenText: String(format: "%i children", selectedChildren),
            searchButtonEnable: searchButtonEnable
        )
    }
    
    func selectStation(for stations: [Station], type: StationSelectionType) {
        coordinatorOutput(.selectStation(stations, { [weak self] station in
            guard let self = self else { return }
            self.interactor.didSelectStation(station, for: type)
            self.view?.update(with: self.viewModel)
        }))
    }
}

extension FormPresenter: FormPresenterProtocol {
    func viewDidLoad() {
        view?.update(with: viewModel)
    }
    
    func didTapOriginStation() {
        interactor.getOriginStations { [weak self] (stations) in
            guard let self = self else { return }
            self.selectStation(for: stations, type: .originStation)
        }
    }
    
    func didTapDestinationStation() {
        interactor.getDestinationStations { [weak self] (stations) in
            guard let self = self else { return }
            self.selectStation(for: stations, type: .destinationStation)
        }
    }
    
    func didSelectDepartureDate(_ date: Date) {
        selectedDate = date
        view?.update(with: viewModel)
    }
    
    func didChangeSelectedAdults(newValue: Double) {
        selectedAdults = newValue
        view?.update(with: viewModel)
    }
    
    func didChangeSelectedTeens(newValue: Double) {
        selectedTeens = newValue
        view?.update(with: viewModel)
    }
    
    func didChangeSelectedChildren(newValue: Double) {
        selectedChildren = newValue
        view?.update(with: viewModel)
    }
    
    func didTapSearch() {
        coordinatorOutput(.showSearch)
    }
}
