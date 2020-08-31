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
    var selectedAdults: Int = 1
    var selectedTeens: Int = 0
    var selectedChildren: Int = 0
    
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
    var viewConfig: FormViewConfig {
        FormViewConfig(
            originPlaceholder: "Origin:",
            destinationPlaceholder: "Destination:",
            doneButton: "Done",
            departureDatePlaceholder: "Departure date:",
            maxAdults: 6,
            minAdults: 1,
            maxTeens: 6,
            minTeens: 0,
            maxChildren: 6,
            minChildren: 0,
            search: "Search"
        )
    }
    
    func viewDidLoad() {
        view?.update(with: viewModel)
    }
    
    func didTapOriginStation() {
        view?.showLoader()
        interactor.getOriginStations { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let stations):
                self.selectStation(for: stations, type: .originStation)
                self.view?.dismissLoader()
            case .failure(let error):
                self.view?.dismissLoader()
                let model = DialogModel(title: "Something went wrong", message: "Please try again")
                self.view?.showDialog(with: model)
            }
        }
    }
    
    func didTapDestinationStation() {
        view?.showLoader()
        interactor.getDestinationStations { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let stations):
                self.selectStation(for: stations, type: .destinationStation)
                self.view?.dismissLoader()
            case .failure(let error):
                self.view?.dismissLoader()
                let model = DialogModel(title: "Something went wrong", message: "Please try again")
                self.view?.showDialog(with: model)
            }
        }
    }
    
    func didSelectDepartureDate(_ date: Date) {
        selectedDate = date
        view?.update(with: viewModel)
    }
    
    func didChangeSelectedAdults(newValue: Double) {
        selectedAdults = Int(newValue)
        view?.update(with: viewModel)
    }
    
    func didChangeSelectedTeens(newValue: Double) {
        selectedTeens = Int(newValue)
        view?.update(with: viewModel)
    }
    
    func didChangeSelectedChildren(newValue: Double) {
        selectedChildren = Int(newValue)
        view?.update(with: viewModel)
    }
    
    func didTapSearch() {
        guard let date = selectedDate else { return }
        
        view?.showLoader()
        interactor.searchFlight(
            date: date,
            adults: selectedAdults,
            teens: selectedTeens,
            children: selectedChildren) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let trips):
                    self.coordinatorOutput(.showSearch(trips))
                    self.view?.dismissLoader()
                case .failure(let error):
                    self.view?.dismissLoader()
                    //Handle error as a pop up or something to notify the user
                    let model = DialogModel(title: "Something went wrong", message: "Please try again")
                    self.view?.showDialog(with: model)
                }
        }
    }
}
