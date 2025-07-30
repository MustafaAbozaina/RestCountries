//
//  CountryModel.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

import Foundation

struct Country: Identifiable, Hashable {
    let id: String
    let name: String
    let capital: String?
    let flagURL: String?
    let currency: String?
}
