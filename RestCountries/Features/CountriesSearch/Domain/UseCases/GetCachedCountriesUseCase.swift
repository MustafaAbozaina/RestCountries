//
//  GetCachedCountriesUseCase.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/30/25.
//

protocol GetCachedCountriesUseCase {
    func execute() async throws -> [Country]
}

class DefaultGetCachedCountriesUseCase: GetCachedCountriesUseCase {
    let repository: CountriesRepository

    init(repository: CountriesRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Country] {
        try repository.getCachedCountries()
    }
}
