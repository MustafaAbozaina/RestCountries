//
//  DeleteCountryUseCase.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/30/25.
//

import Foundation

protocol DeleteCountryUseCase {
    func execute(country: Country) async throws
}

class DefaultDeleteCountryUseCase: DeleteCountryUseCase {
    let repository: CountriesCachingRepository

    init(repository: CountriesCachingRepository) {
        self.repository = repository
    }

    func execute(country: Country) async throws {
        try repository.deleteCountry(country)
    }
}
