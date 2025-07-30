//
//  CountryEntity.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/30/25.
//

import SwiftData

@Model
final class CountryEntity {
    @Attribute(.unique) var id: String
    var name: String
    var capital: String?
    var currency: String?
    var flagURL: String?

    init(id: String, name: String, capital: String?, currency: String?, flagURL: String?) {
        self.id = id
        self.name = name
        self.capital = capital
        self.currency = currency
        self.flagURL = flagURL
    }
}

extension CountryEntity: DomainMappable {
    func toDomain() -> Country {
        return Country(id: id, name: name, capital: capital, flagURL: flagURL, currency: currency)
    }
}

