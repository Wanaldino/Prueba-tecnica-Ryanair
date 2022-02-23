//
//  FlightSearchTableViewCell.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 30/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

enum FlightSearchTableViewCellCase {
	case result(FlightSearchTableViewCell.Model)
    case noResults(String)
}

class FlightSearchTableViewCell: UITableViewCell {
	struct Model {
		let originDate: String
		let originStation: String
		let flightTime: String
		let flightCode: String
		let destinationDate: String
		let destinationStation: String
		let price: String
	}

    lazy var mainStackView: UIStackView = {
        let originStackView = UIStackView(arrangedSubviews: [
            originTimeLabel,
            originStationLabel
        ])
        originStackView.axis = .vertical
        
        let flightInfoStackView = UIStackView(arrangedSubviews: [
            flightTimeLabel,
            flightCodeLabel
        ])
        flightInfoStackView.axis = .vertical
        
        let destinationStackView = UIStackView(arrangedSubviews: [
            destinationTimeLabel,
            destinationStationLabel
            
        ])
        destinationStackView.axis = .vertical
        
        let topStackView = UIStackView(arrangedSubviews: [
            originStackView,
            flightInfoStackView,
            destinationStackView
        ])
        
        let stackView = UIStackView(arrangedSubviews: [
            topStackView,
            priceLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    let originTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let originStationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    let flightTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    let flightCodeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    let destinationTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let destinationStationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.fill(with: mainStackView, edges: .init(top: 3, left: 3, bottom: 3, right: 3))
        flightTimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Model) {
        originTimeLabel.text = model.originDate
        originStationLabel.text = model.originStation
        flightTimeLabel.text = model.flightTime
        flightCodeLabel.text = model.flightCode
        destinationTimeLabel.text = model.destinationDate
        destinationStationLabel.text = model.destinationStation
        priceLabel.text = model.price
    }
}
