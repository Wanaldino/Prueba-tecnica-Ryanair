//
//  String+localized.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 31/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

extension String {
    public var localized: String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: "Localizable")
    }
}
