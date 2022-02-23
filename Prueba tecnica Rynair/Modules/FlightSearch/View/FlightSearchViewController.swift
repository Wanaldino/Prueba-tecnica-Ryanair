//
//  FlightSearchViewController.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 30/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

class FlightSearchViewController: UITableViewController {
    
    let presenter: FlightSearchPresenterProtocol
    init(presenter: FlightSearchPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        tableView.register(FlightSearchTableViewCell.self, forCellReuseIdentifier: "FlightSearchTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.titleForHeaderInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellCase = presenter.modelForCell(at: indexPath)
        switch cellCase {
        case .noResults(let title):
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = title
            return cell
        case .result(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlightSearchTableViewCell", for: indexPath) as! FlightSearchTableViewCell
            cell.configure(with: model)
            return cell
        }
    }
}
