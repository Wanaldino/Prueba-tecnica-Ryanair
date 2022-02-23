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
	let stationsInteractor: StationInteractorProtocol
	let flightInteractor: FlightInteractorProtocol
    let coordinatorOutput: (FormOutput) -> Void

	var originStation: Station?
	var destinationStation: Station?
    var date: Date?
    var adults = 1
    var teens = 0
	var children = 0
    
    init(
		stationsInteractor: StationInteractorProtocol,
		flightInteractor: FlightInteractorProtocol,
		coordinatorOutput: @escaping (FormOutput) -> Void)
	{
		self.stationsInteractor = stationsInteractor
		self.flightInteractor = flightInteractor
        self.coordinatorOutput = coordinatorOutput
    }
    
    var viewModel: FormViewModel {
        var date: String? = nil
		if let selectedDate = self.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            date = dateFormatter.string(from: selectedDate)
        }
        
        let selectedAdults = Int(self.adults)
        let adultsTextFormat = selectedAdults == 1 ? "number_adults_single".localized : "number_adults_plural".localized
        let selectedTeens = Int(self.teens)
        let teensTextFormat = selectedTeens == 1 ? "number_teens_single".localized : "number_teens_plural".localized
        let selectedChildren = Int(self.children)
        let childrenTextFormat = selectedChildren == 1 ? "number_children_single".localized : "number_children_plural".localized
        let searchButtonEnable = originStation != nil && destinationStation != nil && date != nil
        
        return FormViewModel(
            originStation: originStation?.name,
            destinationStation: destinationStation?.name,
            departureDate: date,
            adultsText: String(format: adultsTextFormat, selectedAdults),
            teensText: String(format: teensTextFormat, selectedTeens),
            childrenText: String(format: childrenTextFormat, selectedChildren),
            searchButtonEnable: searchButtonEnable
        )
    }
    
    func selectStation(for stations: [Station], type: StationSelectionType) {
        coordinatorOutput(.selectStation(stations, { [weak self] station in
            guard let self = self else { return }
			switch type {
			case .originStation:
				self.originStation = station
				self.destinationStation = nil
			case .destinationStation:
				self.destinationStation = station
			}
            self.view?.update(with: self.viewModel)
        }))
    }
}

extension FormPresenter: FormPresenterProtocol {
    var viewConfig: FormViewConfig {
        FormViewConfig(
            originPlaceholder: "origin".localized,
            destinationPlaceholder: "destination".localized,
            doneButton: "done".localized,
            departureDatePlaceholder: "departure_date".localized,
            maxAdults: 6,
            minAdults: 1,
            maxTeens: 6,
            minTeens: 0,
            maxChildren: 6,
            minChildren: 0,
            search: "search".localized
        )
    }
    
    func viewDidLoad() {
        view?.update(with: viewModel)
    }
    
    func didTapOriginStation() {
        view?.showLoader()
        stationsInteractor.getStations { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let stations):
                self.selectStation(for: stations, type: .originStation)
                self.view?.dismissLoader()
			case .failure(_):
                self.view?.dismissLoader()
                let model = DialogModel(title: "Something went wrong", message: "Please try again")
                self.view?.showDialog(with: model)
            }
        }
    }
    
    func didTapDestinationStation() {
		guard let originStation = originStation else { return }
		
        view?.showLoader()
		stationsInteractor.getDestinations(for: originStation) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let stations):
                self.selectStation(for: stations, type: .destinationStation)
                self.view?.dismissLoader()
			case .failure(_):
                self.view?.dismissLoader()
                let model = DialogModel(title: "Something went wrong", message: "Please try again")
                self.view?.showDialog(with: model)
            }
        }
    }
    
    func didSelectDepartureDate(_ date: Date) {
		self.date = date
        view?.update(with: viewModel)
    }
    
    func didChangeSelectedAdults(newValue: Double) {
        adults = Int(newValue)
        view?.update(with: viewModel)
    }
    
    func didChangeSelectedTeens(newValue: Double) {
        teens = Int(newValue)
        view?.update(with: viewModel)
    }
    
    func didChangeSelectedChildren(newValue: Double) {
        children = Int(newValue)
        view?.update(with: viewModel)
    }
    
    func didTapSearch() {
        guard
			let date = date,
			let originCode = originStation?.code,
			let destinationCode = destinationStation?.code
		else { return }
        
        view?.showLoader()

		let model = FlightSearchModel(
			origin: originCode,
			destination: destinationCode,
			dateout: date,
			adults: adults,
			teens: teens,
			children: children
		)
        flightInteractor.searchFlight(with: model) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let trips):
                    self.coordinatorOutput(.showSearch(trips))
                    self.view?.dismissLoader()
				case .failure(_):
                    self.view?.dismissLoader()
                    //Handle error as a pop up or something to notify the user
                    let model = DialogModel(title: "Something went wrong", message: "Please try again")
                    self.view?.showDialog(with: model)
                }
        }
    }
}
