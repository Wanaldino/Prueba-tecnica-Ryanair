//
//  String+dateTransform.swift
//  Prueba tecnica Rynair
//
//  Created by Wanaldino Antimonio on 30/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

extension String {
    func transformDate(from readDateFormat: String, to writeDateFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = readDateFormat
        guard let initialDate = dateFormatter.date(from: self) else { return nil }
        dateFormatter.dateFormat = writeDateFormat
        return dateFormatter.string(from: initialDate)
    }
}
