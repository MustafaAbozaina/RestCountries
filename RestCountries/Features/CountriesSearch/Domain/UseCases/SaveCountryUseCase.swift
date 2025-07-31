//
//  GetCountriesUseCase 2.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/30/25.
//

import SwiftData

protocol SaveCountryUseCase {
    func execute(country: Country) async throws
}

class DefaultSaveCountryUseCase: SaveCountryUseCase {
    let repository: CountriesCachingRepository

    init(repository: CountriesCachingRepository) {
        self.repository = repository
    }

    func execute(country: Country) async throws {
        try repository.saveFavoriteCountry(country)
    }
}
