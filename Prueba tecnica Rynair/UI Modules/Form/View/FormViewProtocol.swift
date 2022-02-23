//
//  FormViewProtocol.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 29/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

protocol FormViewProtocol: class, Dialog, Loader {
    func update(with model: FormViewModel)
}
