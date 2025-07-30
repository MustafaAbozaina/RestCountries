//
//  CountriesLocalDS.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/30/25.
//

import Foundation
import SwiftData

protocol CountriesLocalDataSource: CountriesDataSource {
    func saveCountry(_ country: Country) async throws
    func getCachedCountries() throws ->  [Country]
}

final class DefaultCountriesLocalDataSource: CountriesLocalDataSource {
    var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func getCachedCountries() throws -> [Country] {
        let fetchDescriptor = FetchDescriptor<CountryEntity>()
        let entities = try context.fetch(fetchDescriptor)
        
        return entities.map {
            Country(
                id: $0.id,
                name: $0.name,
                capital: $0.capital,
                flagURL: nil,
                currency: $0.currency
            )
        }
    }
    
    func saveCountry(_ country: Country) throws {
        let entity = CountryEntity(
            id: country.id,
            name: country.name,
            capital: country.capital,
            currency: country.currency,
            flagURL: country.flagURL
        )
        context.insert(entity)
        try context.save()
    }
    
    func deleteCountry(_ country: Country) throws {
        let countryId = country.id
        
        let fetchDescriptor = FetchDescriptor<CountryEntity>(
            predicate: #Predicate { $0.id == countryId }
        )
        
        let results = try context.fetch(fetchDescriptor)
        if let entity = results.first {
            context.delete(entity)
            try context.save()
        }
    }
}
