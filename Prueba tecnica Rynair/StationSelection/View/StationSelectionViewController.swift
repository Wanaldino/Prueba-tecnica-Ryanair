//
//  StationSelectionViewController.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

class StationSelectionViewController: UITableViewController {
    let searchView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        return searchBar
    }()
    
    let presenter: StationSelectionPresenterProtocol
    
    init(presenter: StationSelectionPresenterProtocol) {
        self.presenter = presenter
        self.searchView.delegate = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.tableHeaderView = searchView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let model = presenter.modelForCell(at: indexPath)
        cell.textLabel?.text = model
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectStation(at: indexPath)
    }
}

extension StationSelectionViewController: StationSelectionViewProtocol {
    func update() {
        tableView.reloadData()
    }
}
