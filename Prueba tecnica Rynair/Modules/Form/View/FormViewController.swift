//
//  FormViewController.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            originStationTextField,
            destinationStationTextField,
            departureDateTextField,
            compactStepperView(with: adultsLabel, stepper: adultsStepper),
            compactStepperView(with: teensLabel, stepper: teensStepper),
            compactStepperView(with: childrenLabel, stepper: childrenStepper),
            UIView(),
            searchButton
        ])
        stackView.axis = .vertical
        return stackView
    }()
    lazy var originStationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = config.originPlaceholder
        textField.delegate = self
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return textField
    }()
    lazy var destinationStationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = config.destinationPlaceholder
        textField.delegate = self
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return textField
    }()
    lazy var departureDateTextField: UITextField = {
        let toolBar = UIToolbar()
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: config.doneButton,
            style: .done,
            target: self,
            action: #selector(endEditing)
        )
        toolBar.setItems([flexSpace, doneButton], animated: false)
        toolBar.sizeToFit()
        
        let textField = UITextField()
        textField.placeholder = config.departureDatePlaceholder
        textField.inputView = datePicker
        textField.inputAccessoryView = toolBar
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return textField
    }()
    let adultsLabel = UILabel()
    lazy var adultsStepper: UIStepper = stepperView(maximumValue: config.maxAdults, minimumValue: config.minAdults)
    let teensLabel = UILabel()
    lazy var teensStepper: UIStepper = stepperView(maximumValue: config.maxTeens, minimumValue: config.minTeens)
    let childrenLabel = UILabel()
    lazy var childrenStepper: UIStepper = stepperView(maximumValue: config.maxChildren, minimumValue: config.minChildren)
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle(config.search, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(
            self,
            action: #selector(didTapSearchButton),
            for: .touchUpInside
        )
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .date
		datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    func stepperView(maximumValue: Double, minimumValue: Double) -> UIStepper {
        let stepper = UIStepper()
        stepper.minimumValue = minimumValue
        stepper.maximumValue = maximumValue
        stepper.addTarget(
            self,
            action: #selector(didChangeStepper(sender:)),
            for: .valueChanged
        )
        return stepper
    }
    func compactStepperView(with label: UILabel, stepper: UIStepper) -> UIView {
        let stackView = UIStackView(arrangedSubviews: [
            label,
            UIView(),
            stepper
        ])
		stackView.alignment = .center
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return stackView
    }
    
    let presenter: FormPresenterProtocol
    let config: FormViewConfig
    init(presenter: FormPresenterProtocol) {
        self.presenter = presenter
        self.config = presenter.viewConfig
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        view.fill(with: mainStackView, edges: .init(top: 0, left: 8, bottom: 0, right: 8))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @objc func endEditing() {
        presenter.didSelectDepartureDate(datePicker.date)
        view.endEditing(true)
    }
    
    @objc func didChangeStepper(sender: UIStepper) {
        switch sender {
        case adultsStepper:
            presenter.didChangeSelectedAdults(newValue: sender.value)
        case teensStepper:
            presenter.didChangeSelectedTeens(newValue: sender.value)
        case childrenStepper:
            presenter.didChangeSelectedChildren(newValue: sender.value)
        default:
            break
        }
    }
    
    @objc func didTapSearchButton() {
        presenter.didTapSearch()
    }
}

extension FormViewController: FormViewProtocol {
    func update(with model: FormViewModel) {
        originStationTextField.text = model.originStation
        destinationStationTextField.text = model.destinationStation
        departureDateTextField.text = model.departureDate
        adultsLabel.text = model.adultsText
        teensLabel.text = model.teensText
        childrenLabel.text = model.childrenText
        searchButton.backgroundColor = model.searchButtonEnable ? .blue : .gray
        searchButton.isEnabled = model.searchButtonEnable
    }
}

extension FormViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case originStationTextField:
            presenter.didTapOriginStation()
            return false
        case destinationStationTextField:
            presenter.didTapDestinationStation()
            return false
        default:
            return true
        }
    }
}
