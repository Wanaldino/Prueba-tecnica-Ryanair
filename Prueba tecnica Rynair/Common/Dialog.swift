//
//  Dialog.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 31/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

struct DialogModel {
    let title: String
    let message: String
}

protocol Dialog {
    func showDialog(with model: DialogModel)
}

extension Dialog where Self: UIViewController {
    func showDialog(with model: DialogModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}
